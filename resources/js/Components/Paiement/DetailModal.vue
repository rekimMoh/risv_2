<script setup>
import { ref, onMounted, computed, watch } from "vue";
import axios from "axios";

const props = defineProps({
    caisseId: {
        type: Number,
        required: true,
    },
});
// ... (script continues as is)

const emit = defineEmits(["close", "refresh"]);

// Data
const patient = ref({});
const exams = ref([]);
const caisse = ref({});
const isLoading = ref(true);
const isSavingPatient = ref(false);
const isDeleting = ref(null);

// Lists for dropdowns
const services = ref([]);
const radiologues = ref([]);
const produits = ref([]);
const etudes = ref([]);
const wilayas = ref([]);
const antecedents = ref([]);

// Form State
const isFormVisible = ref(false);
const isEditing = ref(false);
const editingId = ref(null);
const isLoadingEtudes = ref(false);
const isSavingExam = ref(false);

const currentExam = ref({
    typeClient: 1, // 1: Publique, 2: Convention
    service_id: "",
    etude_id: "",
    radiologue_id: "",
    produit_id: "",
    sedation: 0,
    remise: 0,
    isRemisePourcentage: false,
    montantRemise: 0,
});

const fetchData = async () => {
    if (!props.caisseId) return;
    isLoading.value = true;
    try {
        const response = await axios.get(`/detail-examen/${props.caisseId}`);
        patient.value = response.data.patient || {};
        exams.value = response.data.examens || [];
        caisse.value = response.data.caisse || {};
    } catch (error) {
        console.error("Error fetching detail:", error);
    } finally {
        isLoading.value = false;
    }
};

const fetchLists = async () => {
    try {
        const [serviceRes, radioRes, prodRes, wilayaRes, antecedentRes] =
            await Promise.all([
                axios.get("/get-service"),
                axios.get("/get-radiologue"),
                axios.get("/get-produit"),
                axios.get("/get-wilaya"),
                axios.get("/get-antecedent"),
            ]);
        services.value = serviceRes.data;
        radiologues.value = radioRes.data;
        produits.value = prodRes.data;
        wilayas.value = wilayaRes.data;
        antecedents.value = antecedentRes.data;
    } catch (error) {
        console.error("Error loading lists:", error);
    }
};

onMounted(() => {
    fetchData();
    fetchLists();
});

// Watch Service to load Etudes
watch(
    () => currentExam.value.service_id,
    async (newServiceId) => {
        if (newServiceId) {
            isLoadingEtudes.value = true;
            try {
                const response = await axios.get(
                    `/get-etude-by-service/${newServiceId}`
                );
                etudes.value = response.data;
            } catch (error) {
                console.error("Error loading etudes:", error);
                etudes.value = [];
            } finally {
                isLoadingEtudes.value = false;
            }
        } else {
            etudes.value = [];
        }
    }
);

// Computed Price Logic
const baseTarif = computed(() => {
    const prodId = currentExam.value.produit_id;
    const sedation = Number(currentExam.value.sedation) || 0;
    const etudePrix = etudes.value.find(
        (e) => e.IDEtude === currentExam.value.etude_id
    );
    const prod = produits.value.find((p) => p.IDProduit === prodId);
    let total = 0;
    if (etudePrix) total += Number(etudePrix.montantPrixExam);
    if (prod) total += Number(prod.prix_afficher);
    total += sedation;
    return total;
});

const calculatedMontantRemise = computed(() => {
    const etudePrixObj = etudes.value.find(
        (e) => e.IDEtude === currentExam.value.etude_id
    );
    const baseEtude = etudePrixObj ? Number(etudePrixObj.montantPrixExam) : 0;
    const remiseVal = Number(currentExam.value.remise) || 0;
    if (currentExam.value.isRemisePourcentage) {
        return (baseEtude * remiseVal) / 100;
    }
    return remiseVal;
});

const tarifNet = computed(() => {
    return Math.max(0, baseTarif.value - calculatedMontantRemise.value);
});

// Actions
const resetForm = () => {
    currentExam.value = {
        typeClient: 1,
        service_id: "",
        etude_id: "",
        radiologue_id: "",
        produit_id: "",
        sedation: 0,
        remise: 0,
        isRemisePourcentage: false,
        montantRemise: 0,
    };
    isEditing.value = false;
    editingId.value = null;
    isFormVisible.value = false;
};

const openAddForm = () => {
    resetForm();
    isFormVisible.value = true;
};

const editExam = async (exam) => {
    resetForm();
    isFormVisible.value = true;
    isEditing.value = true;
    editingId.value = exam.IDExamen;

    // Pre-fill form
    // Note: We need to wait for Etudes to load after service is set
    currentExam.value.service_id = exam.service_id;
    // Load etudes manually to ensure they are there before setting etude_id
    try {
        const response = await axios.get(
            `/get-etude-by-service/${exam.service_id}`
        );
        etudes.value = response.data;
    } catch (e) {}

    currentExam.value.etude_id = exam.etude_id;
    currentExam.value.radiologue_id = exam.radiologue_id;
    currentExam.value.produit_id = exam.produit_id;
    currentExam.value.sedation = 0; // Default as not stored individually on backend
    // Logic for Remise: If database stores amount, we just show amount mode by default
    currentExam.value.remise = exam.remiseMontant;
    currentExam.value.isRemisePourcentage = false;
};

const saveExam = async () => {
    if (
        !currentExam.value.service_id ||
        !currentExam.value.etude_id ||
        !currentExam.value.radiologue_id
    ) {
        alert("Champs obligatoires manquants.");
        return;
    }

    isSavingExam.value = true;
    const payload = {
        radiologue: currentExam.value.radiologue_id,
        patient_id: patient.value.IDPatient,
        etude: currentExam.value.etude_id,
        service: currentExam.value.service_id,
        produit: currentExam.value.produit_id,
        // Backend expects 'tarif' as Gross Price
        tarif: baseTarif.value,
        remise: calculatedMontantRemise.value,
        calcRemise: currentExam.value.isRemisePourcentage
            ? currentExam.value.remise
            : 0,
        typeRemise: currentExam.value.isRemisePourcentage ? "p" : "m",
        caisse_id: props.caisseId,
    };

    try {
        if (isEditing.value) {
            await axios.put(`/examen/${editingId.value}`, payload);
        } else {
            await axios.post("/examen/add-to-caisse", payload);
        }
        await fetchData();
        emit("refresh");
        resetForm();
    } catch (error) {
        console.error(error);
        alert("Erreur lors de l'enregistrement.");
    } finally {
        isSavingExam.value = false;
    }
};

const updatePatient = async () => {
    isSavingPatient.value = true;
    try {
        await axios.put(
            `/update-patient/${patient.value.IDPatient}`,
            patient.value
        );
        alert("Informations patient mises à jour !");
    } catch (error) {
        console.error(error);
        alert("Erreur lors de la mise à jour");
    } finally {
        isSavingPatient.value = false;
    }
};

const deleteExam = async (examId) => {
    if (!confirm("Supprimer cet examen ?")) return;
    isDeleting.value = examId;
    try {
        await axios.delete(`/examen/${examId}`);
        await fetchData();
        emit("refresh");
    } catch (error) {
        console.error(error);
        alert("Erreur lors de la suppression");
    } finally {
        isDeleting.value = null;
    }
};

// Helpers
const formatCurrency = (val) =>
    new Intl.NumberFormat("fr-DZ", {
        style: "currency",
        currency: "DZD",
        minimumFractionDigits: 0,
    }).format(val || 0);
</script>

<template>
    <div class="space-y-6">
        <div v-if="isLoading" class="flex justify-center p-8">
            <span class="loading loading-spinner loading-lg"></span>
        </div>

        <div v-else>
            <!-- Patient Info Section -->
            <div class="bg-blue-50 p-4 rounded-lg mb-6 border border-blue-100">
                <h3 class="font-bold text-lg text-blue-900 mb-4">
                    Informations Patient
                </h3>
                <div
                    class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4"
                >
                    <div class="form-control">
                        <label class="label"
                            ><span class="label-text">Nom</span></label
                        >
                        <input
                            type="text"
                            v-model="patient.nomP"
                            class="input input-bordered input-sm"
                        />
                    </div>
                    <div class="form-control">
                        <label class="label"
                            ><span class="label-text">Prénom</span></label
                        >
                        <input
                            type="text"
                            v-model="patient.prenomP"
                            class="input input-bordered input-sm"
                        />
                    </div>
                    <div class="form-control">
                        <label class="label"
                            ><span class="label-text"
                                >Date Naissance</span
                            ></label
                        >
                        <input
                            type="date"
                            v-model="patient.naisP"
                            class="input input-bordered input-sm"
                        />
                    </div>
                    <div class="form-control">
                        <label class="label"
                            ><span class="label-text">Sexe</span></label
                        >
                        <select
                            v-model="patient.sexeP"
                            class="select select-bordered select-sm w-full"
                        >
                            <option value="" disabled>Sélectionner</option>
                            <option value="1">Masculin</option>
                            <option value="2">Féminin</option>
                        </select>
                    </div>
                    <div class="form-control">
                        <label class="label"
                            ><span class="label-text">Téléphone</span></label
                        >
                        <input
                            type="text"
                            v-model="patient.telP1"
                            class="input input-bordered input-sm"
                        />
                    </div>
                    <div class="form-control">
                        <label class="label"
                            ><span class="label-text">Wilaya</span></label
                        >
                        <select
                            v-model="patient.wilaya_id"
                            class="select select-bordered select-sm w-full"
                        >
                            <option value="" disabled>
                                Sélectionner une wilaya
                            </option>
                            <option
                                v-for="w in wilayas"
                                :key="w.IDWilaya"
                                :value="w.IDWilaya"
                            >
                                {{ w.code }} - {{ w.wilaya }}
                            </option>
                        </select>
                    </div>
                </div>

                <!-- Antécédents Section -->
                <div class="mt-4">
                    <label class="label">
                        <span class="label-text font-semibold"
                            >Antécédents</span
                        >
                    </label>
                    <div
                        class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-3 border p-3 rounded-lg bg-white"
                    >
                        <label
                            v-for="ant in antecedents"
                            :key="ant.IDAntecedent"
                            class="cursor-pointer label justify-start gap-2"
                        >
                            <input
                                type="checkbox"
                                class="checkbox checkbox-xs checkbox-primary"
                                :value="ant.IDAntecedent"
                                v-model="patient.antecedents"
                            />
                            <span class="label-text text-sm">{{
                                ant.libelleAntecedent
                            }}</span>
                        </label>
                    </div>
                </div>

                <div class="mt-4 flex justify-end">
                    <button
                        class="btn btn-primary btn-sm"
                        @click="updatePatient"
                        :disabled="isSavingPatient"
                    >
                        <span
                            v-if="isSavingPatient"
                            class="loading loading-spinner loading-xs"
                        ></span>
                        Enregistrer Modifications
                    </button>
                </div>
            </div>

            <!-- Exam Action Bar -->
            <div class="flex justify-between items-center mb-4">
                <h3 class="font-bold text-lg text-gray-800">
                    Liste des Examens
                </h3>
                <button
                    v-if="!isFormVisible"
                    class="btn btn-sm btn-secondary"
                    @click="openAddForm"
                >
                    + Ajouter un examen
                </button>
            </div>

            <!-- Add/Edit Form Overlay -->
            <div
                v-if="isFormVisible"
                class="bg-base-100 border p-4 rounded-lg shadow-md mb-6 relative"
            >
                <button
                    @click="resetForm"
                    class="btn btn-xs btn-circle btn-ghost absolute right-2 top-2"
                >
                    ✕
                </button>
                <h4 class="font-bold mb-4">
                    {{ isEditing ? "Modifier Examen" : "Nouvel Examen" }}
                </h4>

                <div
                    class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4"
                >
                    <!-- Type Client -->
                    <div class="form-control">
                        <label class="label"
                            ><span class="label-text"
                                >Type de client</span
                            ></label
                        >
                        <select
                            v-model="currentExam.typeClient"
                            class="select select-bordered select-sm w-full"
                        >
                            <option :value="1">Publique</option>
                            <option :value="2">Convention</option>
                        </select>
                    </div>

                    <!-- Service -->
                    <div class="form-control">
                        <label class="label"
                            ><span class="label-text"
                                >Service
                                <span class="text-red-500">*</span></span
                            ></label
                        >
                        <select
                            v-model="currentExam.service_id"
                            class="select select-bordered select-sm w-full"
                        >
                            <option value="" disabled>Choisir Service</option>
                            <option
                                v-for="s in services"
                                :key="s.IDService"
                                :value="s.IDService"
                            >
                                {{ s.libelleService }}
                            </option>
                        </select>
                    </div>

                    <!-- Etude -->
                    <div class="form-control">
                        <label class="label">
                            <span class="label-text">
                                Étude <span class="text-red-500">*</span>
                                <span
                                    v-if="
                                        etudes.length > 0 &&
                                        etudes[0].libelleShift
                                    "
                                    :style="{ color: etudes[0].colorShift }"
                                    class="text-xs"
                                >
                                    ({{ etudes[0].libelleShift }})
                                </span>
                            </span>
                            <span
                                v-if="isLoadingEtudes"
                                class="loading loading-spinner loading-xs ml-2"
                            ></span>
                        </label>
                        <select
                            v-model="currentExam.etude_id"
                            class="select select-bordered select-sm w-full"
                            :disabled="!currentExam.service_id"
                        >
                            <option value="" disabled>Choisir Étude</option>
                            <option
                                v-for="e in etudes"
                                :key="e.IDEtude"
                                :value="e.IDEtude"
                            >
                                {{ e.libelleEtude }} ({{ e.montantPrixExam }}
                                DA)
                            </option>
                        </select>
                    </div>

                    <!-- Radiologue -->
                    <div class="form-control">
                        <label class="label"
                            ><span class="label-text"
                                >Radiologue
                                <span class="text-red-500">*</span></span
                            ></label
                        >
                        <select
                            v-model="currentExam.radiologue_id"
                            class="select select-bordered select-sm w-full"
                        >
                            <option value="" disabled>
                                Choisir Radiologue
                            </option>
                            <option
                                v-for="r in radiologues"
                                :key="r.id"
                                :value="r.id"
                            >
                                {{ r.nom }} {{ r.prenom }}
                            </option>
                        </select>
                    </div>

                    <!-- Produit -->
                    <div class="form-control">
                        <label class="label"
                            ><span class="label-text">Produit</span></label
                        >
                        <select
                            v-model="currentExam.produit_id"
                            class="select select-bordered select-sm w-full"
                        >
                            <option value="" disabled>Choisir Produit</option>
                            <option
                                v-for="p in produits"
                                :key="p.IDProduit"
                                :value="p.IDProduit"
                            >
                                {{ p.libelleProduit }} ({{ p.prix_afficher }}
                                DA)
                            </option>
                        </select>
                    </div>

                    <!-- Sédation -->
                    <div class="form-control">
                        <label class="label"
                            ><span class="label-text">Sédation</span></label
                        >
                        <select
                            v-model="currentExam.sedation"
                            class="select select-bordered select-sm w-full"
                        >
                            <option :value="0">Sans</option>
                            <option :value="1000">Adulte (1000 DA)</option>
                            <option :value="500">Enfant (500 DA)</option>
                        </select>
                    </div>

                    <!-- Remise -->
                    <div class="form-control">
                        <label class="label">
                            <span class="label-text">Remise</span>
                            <div class="flex items-center gap-2 cursor-pointer">
                                <span
                                    class="text-xs"
                                    :class="{
                                        'font-bold text-primary':
                                            !currentExam.isRemisePourcentage,
                                    }"
                                    >DA</span
                                >
                                <input
                                    type="checkbox"
                                    class="toggle toggle-xs toggle-primary"
                                    v-model="currentExam.isRemisePourcentage"
                                />
                                <span
                                    class="text-xs"
                                    :class="{
                                        'font-bold text-primary':
                                            currentExam.isRemisePourcentage,
                                    }"
                                    >%</span
                                >
                            </div>
                        </label>
                        <input
                            type="number"
                            v-model="currentExam.remise"
                            class="input input-bordered input-sm w-full"
                        />
                    </div>

                    <!-- Montant Remise (Readonly) -->
                    <div
                        class="form-control"
                        v-if="currentExam.isRemisePourcentage"
                    >
                        <label class="label"
                            ><span class="label-text">Calculé</span></label
                        >
                        <input
                            type="text"
                            :value="calculatedMontantRemise + ' DA'"
                            readonly
                            class="input input-bordered input-sm w-full bg-gray-100"
                        />
                    </div>

                    <!-- Tarif (Readonly) -->
                    <div class="form-control">
                        <label class="label"
                            ><span class="label-text">Tarif Net</span></label
                        >
                        <input
                            type="text"
                            :value="formatCurrency(tarifNet)"
                            readonly
                            class="input input-bordered input-sm w-full bg-gray-100"
                        />
                    </div>
                </div>

                <div class="mt-4 flex justify-end gap-2">
                    <button class="btn btn-sm btn-ghost" @click="resetForm">
                        Annuler
                    </button>
                    <button
                        class="btn btn-sm btn-primary"
                        @click="saveExam"
                        :disabled="isSavingExam"
                    >
                        <span
                            v-if="isSavingExam"
                            class="loading loading-spinner loading-xs"
                        ></span>
                        {{ isEditing ? "Mettre à jour" : "Enregistrer" }}
                    </button>
                </div>
            </div>

            <!-- Exams List Table -->
            <div class="overflow-x-auto border rounded-lg">
                <table class="table w-full">
                    <thead>
                        <tr>
                            <th>Etude</th>
                            <th>Service</th>
                            <th>Radiologue</th>
                            <th class="text-right">Montant</th>
                            <th class="text-right">Remise</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="ex in exams" :key="ex.IDExamen">
                            <td>{{ ex.libelleEtude }}</td>
                            <td>{{ ex.libelleService }}</td>
                            <td>{{ ex.nom }} {{ ex.prenom }}</td>
                            <td class="text-right font-mono">
                                {{ formatCurrency(ex.montantantVerserment) }}
                            </td>
                            <td class="text-right font-mono text-error">
                                {{
                                    ex.remiseMontant > 0
                                        ? "-" + formatCurrency(ex.remiseMontant)
                                        : "-"
                                }}
                            </td>
                            <td class="flex justify-center gap-2">
                                <button
                                    class="btn btn-xs btn-warning btn-outline"
                                    @click="editExam(ex)"
                                >
                                    Modifier
                                </button>
                                <button
                                    class="btn btn-xs btn-error btn-outline"
                                    @click="deleteExam(ex.IDExamen)"
                                    :disabled="isDeleting === ex.IDExamen"
                                >
                                    Supprimer
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Summary Footer in Modal -->
            <div class="flex justify-end mt-4 gap-8 text-lg font-bold">
                <span>Total TTC: {{ formatCurrency(caisse.ttc) }}</span>
                <span
                    :class="
                        caisse.reset > 0 ? 'text-red-500' : 'text-green-600'
                    "
                    >Reste: {{ formatCurrency(caisse.reset) }}</span
                >
            </div>
        </div>
    </div>
</template>
