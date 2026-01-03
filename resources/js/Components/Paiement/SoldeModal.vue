<script setup>
import { ref, onMounted, watch } from "vue";
import axios from "axios";

const props = defineProps({
    caisseId: {
        type: Number,
        required: true,
    },
});

const emit = defineEmits(["close", "refresh"]);

const history = ref([]);
const caisse = ref({});
const isLoading = ref(true);
const newVersement = ref(0);
const isSubmitting = ref(false);

const fetchData = async () => {
    if (!props.caisseId) return;
    isLoading.value = true;
    try {
        const response = await axios.get(`/detailCaisse/${props.caisseId}`);
        caisse.value = response.data.caisse;
        history.value = response.data.versements;
    } catch (error) {
        console.error("Error fetching solde details:", error);
    } finally {
        isLoading.value = false;
    }
};

onMounted(fetchData);

// Format helper
const formatCurrency = (val) => {
    return new Intl.NumberFormat("fr-DZ", {
        style: "currency",
        currency: "DZD",
        minimumFractionDigits: 0,
    }).format(val || 0);
};

// Date helper
const formatDate = (dateStr) => {
    if (!dateStr) return "-";
    return new Date(dateStr).toLocaleDateString("fr-FR", {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
        hour: "2-digit",
        minute: "2-digit",
    });
};

const submitVersement = async () => {
    if (newVersement.value <= 0) return;
    isSubmitting.value = true;
    try {
        await axios.post("/set-versement", {
            IDCaisse: props.caisseId,
            newVerse: newVersement.value,
        });
        newVersement.value = 0;
        await fetchData(); // Refresh local
        emit("refresh"); // Refresh parent table
    } catch (error) {
        alert("Erreur lors de l'ajout du versement");
        console.error(error);
    } finally {
        isSubmitting.value = false;
    }
};
</script>

<template>
    <div class="space-y-6">
        <div v-if="isLoading" class="flex justify-center p-4">
            <span class="loading loading-spinner loading-lg"></span>
        </div>

        <div v-else>
            <!-- header Info -->
            <div
                class="grid grid-cols-3 gap-4 bg-gray-50 p-4 rounded-lg text-center mb-6"
            >
                <div>
                    <div class="text-sm text-gray-500">Total TTC</div>
                    <div class="text-xl font-bold">
                        {{ formatCurrency(caisse.ttc) }}
                    </div>
                </div>
                <div>
                    <div class="text-sm text-gray-500">Total Versé</div>
                    <div class="text-xl font-bold text-success">
                        {{ formatCurrency(caisse.verse) }}
                    </div>
                </div>
                <div>
                    <div class="text-sm text-gray-500">Reste à payer</div>
                    <div
                        class="text-xl font-bold"
                        :class="
                            caisse.reset > 0 ? 'text-error' : 'text-gray-700'
                        "
                    >
                        {{ formatCurrency(caisse.reset) }}
                    </div>
                </div>
            </div>

            <!-- Add Payment Form -->
            <div class="flex items-end gap-4 mb-6" v-if="caisse.reset > 0">
                <div class="form-control w-full">
                    <label class="label"
                        ><span class="label-text"
                            >Nouveau Versement</span
                        ></label
                    >
                    <div class="relative">
                        <input
                            type="number"
                            v-model="newVersement"
                            class="input input-bordered w-full pr-12"
                            min="1"
                            placeholder="Montant..."
                        />
                        <span class="absolute right-3 top-3 text-gray-500"
                            >DA</span
                        >
                    </div>
                </div>
                <button
                    class="btn btn-success text-white"
                    @click="submitVersement"
                    :disabled="isSubmitting || newVersement <= 0"
                >
                    <span
                        v-if="isSubmitting"
                        class="loading loading-spinner loading-sm"
                    ></span>
                    Ajouter
                </button>
            </div>
            <div v-else class="alert alert-success my-4">
                <span>Dossier soldé.</span>
            </div>

            <!-- History Table -->
            <h4 class="font-bold mb-2 text-gray-700">
                Historique des paiements
            </h4>
            <div class="overflow-x-auto border rounded-lg">
                <table class="table w-full table-zebra">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th class="text-right">Montant</th>
                            <th>Utilisateur</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr
                            v-for="versement in history"
                            :key="versement.IDVersement"
                        >
                            <td>{{ formatDate(versement.created_at) }}</td>
                            <td class="text-right font-mono">
                                {{ formatCurrency(versement.versement) }}
                            </td>
                            <td>—</td>
                            <!-- User info not joined in controller yet, straightforward to add if needed -->
                        </tr>
                        <tr v-if="history.length === 0">
                            <td colspan="3" class="text-center text-gray-500">
                                Aucun versement enregistré.
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</template>
