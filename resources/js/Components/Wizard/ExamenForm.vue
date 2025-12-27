<script setup>
import { ref, computed, onMounted, watch } from "vue";
import axios from "axios";

const props = defineProps({
    modelValue: {
        type: Array, // Array of exams
        default: () => [],
    },
});

const emit = defineEmits(["update:modelValue", "next", "prev"]);

// Lists for dropdowns
const services = ref([]);
const radiologues = ref([]);
const produits = ref([]);
const etudes = ref([]);

// Form State
const currentExam = ref({
    typeClient: 1, // 1: Publique, 2: Convention
    service_id: "",
    etude_id: "",
    radiologue_id: "",
    produit_id: "",
    sedation: 0,
    remise: 0,
});

// Editing State
const isEditing = ref(false);
const editingIndex = ref(-1);

const isLoadingEtudes = ref(false);

// Local list of exams (synced with modelValue potentially, or just local until next)
const examsList = ref([...props.modelValue]);

// Watchers
watch(
    examsList,
    (newVal) => {
        emit("update:modelValue", newVal);
    },
    { deep: true }
);

// Fetch Initial Data
onMounted(async () => {
    try {
        const [serviceRes, radioRes, prodRes] = await Promise.all([
            axios.get("/get-service"),
            axios.get("/get-radiologue"),
            axios.get("/get-produit"),
        ]);
        services.value = serviceRes.data;
        radiologues.value = radioRes.data;
        produits.value = prodRes.data;
    } catch (error) {
        console.error("Error loading exam data:", error);
    }
});

// Fetch Etudes when Service changes
watch(
    () => currentExam.value.service_id,
    async (newServiceId) => {
        // Strategy: Only clear etude_id if it's not already set to what we want (which is hard to know here).
        // Better: Just re-fetch list. If current etude_id is valid for this service, it stays selected.
        // But the select element might clear if the option isn't in the list 'etudes' yet.
        // So we wait for fetch.

        // etudes.value = []; // Don't clear immediately to avoid flickering if possible, or just accept flicker.
        // User wants loading effect.

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
            currentExam.value.etude_id = "";
        }
    }
);

// Computed Tarif
const tarif = computed(() => {
    const prodId = currentExam.value.produit_id;
    const prod = produits.value.find((p) => p.IDProduit === prodId);
    if (prod) {
        // Ensure price is treated as number
        return Number(prod.prix_afficher) + 500;
    }
    return 500; // Fallback if 500 is base
});

// Add or Update Exam
const saveExam = () => {
    // Validate
    if (
        !currentExam.value.service_id ||
        !currentExam.value.etude_id ||
        !currentExam.value.radiologue_id
    ) {
        alert(
            "Veuillez remplir tous les champs obligatoires (Service, Étude, Radiologue)."
        );
        return;
    }

    // Find labels
    const service = services.value.find(
        (s) => s.IDService === currentExam.value.service_id
    );
    const etude = etudes.value.find(
        (e) => e.IDEtude === currentExam.value.etude_id
    );
    const radio = radiologues.value.find(
        (u) => u.id === currentExam.value.radiologue_id
    );
    const produit = produits.value.find(
        (p) => p.IDProduit === currentExam.value.produit_id
    );

    const examData = {
        ...currentExam.value,
        tarif: tarif.value,
        // Labels for UI
        serviceLabel: service?.libelleService,
        etudeLabel: etude?.libelleEtude, // Assuming libelleEtude
        radiologueLabel: radio ? `${radio.nom} ${radio.prenom}` : "",
        produitLabel: produit?.libelleProduit,
        id: isEditing.value
            ? examsList.value[editingIndex.value].id
            : Date.now(), // Keep ID if editing
    };

    if (isEditing.value) {
        examsList.value[editingIndex.value] = examData;
        isEditing.value = false;
        editingIndex.value = -1;
    } else {
        examsList.value.push(examData);
    }

    // Reset Form
    resetForm();
};

const editExam = async (index) => {
    const exam = examsList.value[index];

    // Set basic fields
    currentExam.value = {
        typeClient: exam.typeClient,
        service_id: exam.service_id,
        // etude_id: exam.etude_id, // Will be set after service load?
        radiologue_id: exam.radiologue_id,
        produit_id: exam.produit_id,
        sedation: exam.sedation,
        remise: exam.remise,
    };

    // We need to ensure etudes are loaded for this service before setting etude_id
    // The watch on service_id will trigger.
    // We can manually load here to be safe and avoid race condition or clearing.

    try {
        const response = await axios.get(
            `/get-etude-by-service/${exam.service_id}`
        );
        etudes.value = response.data;
        currentExam.value.etude_id = exam.etude_id; // Set it now that options exist
    } catch (e) {
        console.error(e);
    }

    isEditing.value = true;
    editingIndex.value = index;
};

const removeExam = (index) => {
    if (isEditing.value && editingIndex.value === index) {
        resetForm();
    }
    examsList.value.splice(index, 1);
};

const resetForm = () => {
    currentExam.value = {
        typeClient: 1,
        service_id: "",
        etude_id: "",
        radiologue_id: "",
        produit_id: "",
        sedation: 0,
        remise: 0,
    };
    isEditing.value = false;
    editingIndex.value = -1;
};

const proceed = () => {
    if (examsList.value.length === 0) {
        alert("Veuillez ajouter au moins un examen.");
        return;
    }
    emit("next");
};
</script>

<template>
    <div class="p-6 bg-white rounded-lg shadow-lg">
        <h2 class="text-2xl font-bold mb-6 text-gray-800">
            Détails de l'examen
        </h2>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <!-- Type Client -->
            <div class="form-control">
                <label class="label"
                    ><span class="label-text font-semibold"
                        >Type de client *</span
                    ></label
                >
                <select
                    v-model="currentExam.typeClient"
                    class="select select-bordered w-full"
                >
                    <option :value="1">Publique</option>
                    <option :value="2">Convention</option>
                </select>
            </div>

            <!-- Service -->
            <div class="form-control">
                <label class="label"
                    ><span class="label-text font-semibold"
                        >Service *</span
                    ></label
                >
                <select
                    v-model="currentExam.service_id"
                    class="select select-bordered w-full"
                >
                    <option value="" disabled>Sélectionner un service</option>
                    <option
                        v-for="s in services"
                        :key="s.IDService"
                        :value="s.IDService"
                    >
                        {{ s.libelleService }}
                    </option>
                </select>
            </div>

            <!-- Étude -->
            <div class="form-control">
                <label class="label">
                    <span class="label-text font-semibold">Étude *</span>
                    <span
                        v-if="isLoadingEtudes"
                        class="loading loading-spinner loading-xs text-primary ml-2"
                    ></span>
                </label>
                <select
                    v-model="currentExam.etude_id"
                    class="select select-bordered w-full"
                    :disabled="!currentExam.service_id || isLoadingEtudes"
                >
                    <option value="" disabled>
                        {{
                            isLoadingEtudes
                                ? "Chargement..."
                                : "Sélectionner une étude"
                        }}
                    </option>
                    <option
                        v-for="e in etudes"
                        :key="e.IDEtude"
                        :value="e.IDEtude"
                    >
                        {{ e.libelleEtude }}
                    </option>
                </select>
            </div>

            <!-- Radiologue -->
            <div class="form-control">
                <label class="label"
                    ><span class="label-text font-semibold"
                        >Radiologue *</span
                    ></label
                >
                <select
                    v-model="currentExam.radiologue_id"
                    class="select select-bordered w-full"
                >
                    <option value="" disabled>
                        Sélectionner un radiologue
                    </option>
                    <option v-for="r in radiologues" :key="r.id" :value="r.id">
                        {{ r.nom }} {{ r.prenom }}
                    </option>
                </select>
            </div>

            <!-- Produit -->
            <div class="form-control">
                <label class="label"
                    ><span class="label-text font-semibold"
                        >Produit *</span
                    ></label
                >
                <select
                    v-model="currentExam.produit_id"
                    class="select select-bordered w-full"
                >
                    <option value="" disabled>Sélectionner un produit</option>
                    <option
                        v-for="p in produits"
                        :key="p.IDProduit"
                        :value="p.IDProduit"
                    >
                        {{ p.libelleProduit }} ({{ p.prix_afficher }} DA)
                    </option>
                </select>
            </div>

            <!-- Sédation -->
            <div class="form-control">
                <label class="label"
                    ><span class="label-text font-semibold"
                        >Sédation *</span
                    ></label
                >
                <select
                    v-model="currentExam.sedation"
                    class="select select-bordered w-full"
                >
                    <option :value="0">Sans</option>
                    <option :value="1000">Adulte (1000 DA)</option>
                    <option :value="500">Enfant (500 DA)</option>
                </select>
            </div>

            <!-- Remise -->
            <div class="form-control">
                <label class="label"
                    ><span class="label-text font-semibold">Remise</span></label
                >
                <input
                    type="number"
                    v-model="currentExam.remise"
                    placeholder="0"
                    class="input input-bordered w-full"
                    min="0"
                />
            </div>

            <!-- Tarif (Read Only) -->
            <div class="form-control">
                <label class="label"
                    ><span class="label-text font-semibold">Tarif</span></label
                >
                <input
                    type="text"
                    :value="tarif + ' DA'"
                    readonly
                    class="input input-bordered w-full bg-gray-100"
                />
            </div>

            <!-- Add/Edit & Cancel Buttons -->
            <div class="flex items-end gap-2">
                <button
                    v-if="isEditing"
                    @click="resetForm"
                    class="btn btn-ghost w-1/3"
                >
                    Annuler
                </button>
                <button
                    @click="saveExam"
                    class="btn w-full"
                    :class="isEditing ? 'btn-warning w-2/3' : 'btn-secondary'"
                >
                    <svg
                        v-if="!isEditing"
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-6 w-6 mr-2"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                    >
                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            stroke-width="2"
                            d="M12 4v16m8-8H4"
                        />
                    </svg>
                    <span v-if="isEditing">Modifier l'examen</span>
                    <span v-else>Ajouter un examen</span>
                </button>
            </div>
        </div>

        <!-- Mini List of added exams -->
        <div v-if="examsList.length > 0" class="mt-8">
            <h3 class="font-bold text-lg mb-4">
                Examens Ajoutés ({{ examsList.length }})
            </h3>
            <div class="overflow-x-auto">
                <table class="table table-compact w-full border">
                    <thead>
                        <tr>
                            <th>Service</th>
                            <th>Étude</th>
                            <th>Produit</th>
                            <th>Tarif</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr
                            v-for="(exam, index) in examsList"
                            :key="exam.id"
                            :class="{
                                'bg-yellow-50':
                                    isEditing && editingIndex === index,
                            }"
                        >
                            <td>{{ exam.serviceLabel }}</td>
                            <td>{{ exam.etudeLabel }}</td>
                            <td>{{ exam.produitLabel }}</td>
                            <td>{{ exam.tarif }} DA</td>
                            <td class="flex gap-2">
                                <button
                                    @click="editExam(index)"
                                    class="btn btn-xs btn-warning"
                                >
                                    Editer
                                </button>
                                <button
                                    @click="removeExam(index)"
                                    class="btn btn-xs btn-error"
                                >
                                    Retirer
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Navigation -->
        <div class="flex justify-between mt-8">
            <button class="btn btn-neutral" @click="emit('prev')">
                Précédent
            </button>
            <button class="btn btn-primary px-8" @click="proceed">
                Suivant
            </button>
        </div>
    </div>
</template>
