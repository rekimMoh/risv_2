<script setup>
import { ref, watch, onMounted } from "vue";
import axios from "axios";

const props = defineProps({
    modelValue: {
        type: Object,
        required: true,
    },
});

const emit = defineEmits(["update:modelValue", "next"]);

const patient = ref(props.modelValue);
const searchResults = ref([]);
const showDropdown = ref(false);
const wilayas = ref([]);
const antecedents = ref([]);
const isLoadingData = ref(true);
const isSearching = ref(false);

// Watch for changes and emit update
watch(
    () => props.modelValue,
    (newVal) => {
        patient.value = newVal;
    },
    { deep: true }
);

watch(
    patient,
    (newVal) => {
        emit("update:modelValue", newVal);
    },
    { deep: true }
);

onMounted(async () => {
    isLoadingData.value = true;
    try {
        const [wilayaRes, antecedentRes] = await Promise.all([
            axios.get("/get-wilaya"),
            axios.get("/get-antecedent"),
        ]);
        wilayas.value = wilayaRes.data;
        antecedents.value = antecedentRes.data;
    } catch (error) {
        console.error("Error loading initial data:", error);
    } finally {
        isLoadingData.value = false;
    }
});

const searchPatient = async () => {
    if (patient.value.nomP.length >= 3) {
        isSearching.value = true;
        try {
            const response = await axios.get("/patient-search", {
                params: { keyWord: patient.value.nomP },
            });
            searchResults.value = response.data;
            showDropdown.value = true;
        } catch (error) {
            console.error("Error searching patient:", error);
        } finally {
            isSearching.value = false;
        }
    } else {
        showDropdown.value = false;
        searchResults.value = [];
    }
};

const selectPatient = (selectedPatient) => {
    // Fill fields
    patient.value.IDPatient = selectedPatient.IDPatient;
    patient.value.nomP = selectedPatient.nomP;
    patient.value.prenomP = selectedPatient.prenomP;
    patient.value.naisP = selectedPatient.naisP;
    patient.value.sexeP = selectedPatient.sexeP;
    patient.value.telP1 = selectedPatient.telP1;
    patient.value.wilaya_id = selectedPatient.wilaya_id;
    // Assuming backend returns antecedents properly, we might need to handle them.
    // However, the search usually returns basic info. We'll leave antecedents manual unless specified.

    showDropdown.value = false;
};

// Simple validation before next
const validateAndProceed = () => {
    if (
        patient.value.nomP &&
        patient.value.prenomP &&
        patient.value.naisP &&
        patient.value.telP1 &&
        patient.value.wilaya_id
    ) {
        emit("next");
    } else {
        alert("Veuillez remplir tous les champs obligatoires.");
    }
};
</script>

<template>
    <div class="p-6 bg-white rounded-lg shadow-lg relative min-h-[400px]">
        <h2 class="text-2xl font-bold mb-6 text-gray-800">
            Informations Patient
        </h2>

        <!-- Loading Overlay for Initial Data -->
        <div
            v-if="isLoadingData"
            class="absolute inset-0 bg-white/80 z-20 flex flex-col items-center justify-center rounded-lg"
        >
            <span
                class="loading loading-spinner loading-lg text-primary"
            ></span>
            <p class="mt-2 text-gray-500 font-medium">
                Chargement des données...
            </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <!-- Nom (Autocomplete) -->
            <div class="relative">
                <label class="label">
                    <span class="label-text font-semibold">Nom *</span>
                </label>
                <div class="relative">
                    <input
                        type="text"
                        v-model="patient.nomP"
                        @input="searchPatient"
                        placeholder="Entrez le nom"
                        class="input input-bordered w-full pr-10"
                    />
                    <span
                        v-if="isSearching"
                        class="absolute right-3 top-3 loading loading-spinner loading-xs text-primary"
                    ></span>
                </div>
                <!-- Dropdown -->
                <ul
                    v-if="showDropdown && searchResults.length > 0"
                    class="absolute z-10 w-full bg-white border border-gray-200 rounded-lg shadow-xl max-h-60 overflow-y-auto mt-1"
                >
                    <li
                        v-for="p in searchResults"
                        :key="p.IDpatient"
                        class="px-4 py-2 hover:bg-blue-50 cursor-pointer border-b last:border-b-0"
                        @click="selectPatient(p)"
                    >
                        <div class="font-bold">
                            {{ p.nomP }} {{ p.prenomP }}
                        </div>
                        <div class="text-xs text-gray-500">{{ p.naisP }}</div>
                    </li>
                </ul>
            </div>

            <!-- Prénom -->
            <div>
                <label class="label">
                    <span class="label-text font-semibold">Prénom *</span>
                </label>
                <input
                    type="text"
                    v-model="patient.prenomP"
                    placeholder="Entrez le prénom"
                    class="input input-bordered w-full"
                />
            </div>

            <!-- Date de naissance -->
            <div>
                <label class="label">
                    <span class="label-text font-semibold"
                        >Date de naissance *</span
                    >
                </label>
                <input
                    type="date"
                    v-model="patient.naisP"
                    class="input input-bordered w-full"
                />
            </div>

            <!-- Sexe -->
            <div>
                <label class="label">
                    <span class="label-text font-semibold">Sexe *</span>
                </label>
                <div class="flex gap-4 mt-2">
                    <label class="cursor-pointer label gap-2">
                        <input
                            type="radio"
                            name="sexe"
                            class="radio radio-primary"
                            value="1"
                            v-model="patient.sexeP"
                        />
                        <span class="label-text">Masculin</span>
                    </label>
                    <label class="cursor-pointer label gap-2">
                        <input
                            type="radio"
                            name="sexe"
                            class="radio radio-secondary"
                            value="2"
                            v-model="patient.sexeP"
                        />
                        <span class="label-text">Féminin</span>
                    </label>
                </div>
            </div>

            <!-- Téléphone -->
            <div>
                <label class="label">
                    <span class="label-text font-semibold">Téléphone *</span>
                </label>
                <input
                    type="text"
                    v-model="patient.telP1"
                    placeholder="0555..."
                    class="input input-bordered w-full"
                />
            </div>

            <!-- Wilaya -->
            <div>
                <label class="label">
                    <span class="label-text font-semibold">Wilaya *</span>
                </label>
                <select
                    v-model="patient.wilaya_id"
                    class="select select-bordered w-full"
                >
                    <option disabled value="">Sélectionnez une wilaya</option>
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

        <!-- Antécédents -->
        <div class="mt-6">
            <label class="label">
                <span class="label-text font-semibold">Antécédents</span>
            </label>
            <div
                class="grid grid-cols-2 md:grid-cols-3 gap-4 border p-4 rounded-lg"
            >
                <label
                    v-for="ant in antecedents"
                    :key="ant.IDAntecedent"
                    class="cursor-pointer label justify-start gap-3"
                >
                    <input
                        type="checkbox"
                        class="checkbox checkbox-sm checkbox-primary"
                        :value="ant.IDAntecedent"
                        v-model="patient.antecedents"
                    />
                    <span class="label-text">{{ ant.libelleAntecedent }}</span>
                </label>
            </div>
        </div>

        <!-- Navigation Buttons -->
        <div class="flex justify-end mt-8">
            <button
                class="btn btn-primary px-8"
                @click="validateAndProceed"
                :disabled="isLoadingData"
            >
                Suivant
            </button>
        </div>
    </div>
</template>
