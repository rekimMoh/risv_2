<script setup>
import { ref, watch } from "vue";
import { Head, router, Link } from "@inertiajs/vue3";
import MyLayout from "@/Layouts/MyLayout.vue";
import SoldeModal from "@/Components/Paiement/SoldeModal.vue";
import DetailModal from "@/Components/Paiement/DetailModal.vue";

const props = defineProps({
    caisses: Object, // Paginated response
    filters: Object, // Filters passed back from server
});

// Format currency helper
const formatCurrency = (value) => {
    return new Intl.NumberFormat("fr-DZ", {
        style: "currency",
        currency: "DZD",
        minimumFractionDigits: 0,
    }).format(value);
};

// Filter State
const formFilters = ref({
    nom: props.filters?.nom || "",
    prenom: props.filters?.prenom || "",
    date_filter: props.filters?.date_filter || "",
    date_debut: props.filters?.date_debut || "",
    date_fin: props.filters?.date_fin || "",
    status: props.filters?.status || "",
    nbItem: props.filters?.nbItem || 10,
});

// Watch throttling could be good, but for now simple watch
let timeout = null;
const updateFilters = () => {
    clearTimeout(timeout);
    timeout = setTimeout(() => {
        router.get("/paiement", formFilters.value, {
            preserveState: true,
            replace: true,
        });
    }, 300);
};

// Watch deep on filters
watch(formFilters, updateFilters, { deep: true });

// Delete Action
const deleteCaisse = (id) => {
    if (
        confirm(
            "Voulez-vous vraiment supprimer cet enregistrement ? Cela supprimera tous les examens et paiements associés !"
        )
    ) {
        router.delete(`/paiement/${id}`, {
            preserveScroll: true,
        });
    }
};

// Modals State (Placeholder for now)
const showDetailModal = ref(false);
const showSoldeModal = ref(false);
const selectedCaisseId = ref(null);

const openDetail = (id) => {
    selectedCaisseId.value = id;
    showDetailModal.value = true;
    // Load detail data logic here or inside modal
};

const openSolde = (id) => {
    selectedCaisseId.value = id;
    showSoldeModal.value = true;
};

const refreshData = () => {
    router.reload({ only: ["caisses"] });
};
</script>

<template>
    <Head title="Mouvement de la caisse" />
    <MyLayout>
        <div class="col-span-4 bg-white p-6 rounded-lg shadow-md">
            <!-- Header -->
            <div class="flex justify-between items-center mb-6">
                <h1 class="text-2xl font-bold text-gray-800">
                    Mouvement de la caisse
                </h1>
            </div>

            <!-- Filters -->
            <div
                class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6 bg-gray-50 p-4 rounded-lg border"
            >
                <!-- Nom -->
                <div class="form-control">
                    <label class="label"
                        ><span class="label-text">Nom Patient</span></label
                    >
                    <input
                        type="text"
                        v-model="formFilters.nom"
                        class="input input-sm input-bordered"
                        placeholder="Rechercher..."
                    />
                </div>
                <!-- Prénom -->
                <div class="form-control">
                    <label class="label"
                        ><span class="label-text">Prénom Patient</span></label
                    >
                    <input
                        type="text"
                        v-model="formFilters.prenom"
                        class="input input-sm input-bordered"
                        placeholder="Rechercher..."
                    />
                </div>
                <!-- Date Filter -->
                <div class="form-control">
                    <label class="label"
                        ><span class="label-text">Date Examen</span></label
                    >
                    <select
                        v-model="formFilters.date_filter"
                        class="select select-sm select-bordered"
                    >
                        <option value="">Toutes les dates</option>
                        <option value="hier">Hier</option>
                        <option value="semaine_cours">Cette semaine</option>
                        <option value="semaine_passee">Semaine passée</option>
                        <option value="mois_passe">Mois passé</option>
                        <option value="custom">Personnalisée</option>
                    </select>
                </div>
                <!-- Status -->
                <div class="form-control">
                    <label class="label cursor-pointer justify-start gap-2">
                        <input
                            type="checkbox"
                            v-model="formFilters.status"
                            true-value="non_paye"
                            false-value=""
                            class="checkbox checkbox-sm checkbox-primary"
                        />
                        <span class="label-text">Non totalement payés</span>
                    </label>
                </div>

                <!-- Custom Dates -->
                <div
                    v-if="formFilters.date_filter === 'custom'"
                    class="col-span-full grid grid-cols-2 gap-4 mt-2"
                >
                    <div class="form-control">
                        <label class="label"
                            ><span class="label-text">Date Début</span></label
                        >
                        <input
                            type="date"
                            v-model="formFilters.date_debut"
                            class="input input-sm input-bordered"
                        />
                    </div>
                    <div class="form-control">
                        <label class="label"
                            ><span class="label-text">Date Fin</span></label
                        >
                        <input
                            type="date"
                            v-model="formFilters.date_fin"
                            class="input input-sm input-bordered"
                        />
                    </div>
                </div>
            </div>

            <!-- Table -->
            <div class="overflow-x-auto">
                <table class="table w-full hover">
                    <thead>
                        <tr>
                            <th>Patient</th>
                            <th>Date Examen</th>
                            <th class="text-right">Total TTC</th>
                            <th class="text-right">Reste à payer</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="item in caisses.data" :key="item.IDCaisse">
                            <td class="font-bold">
                                {{ item.nomP }} {{ item.prenomP }}
                            </td>
                            <td>
                                {{
                                    new Date(
                                        item.created_at
                                    ).toLocaleDateString("fr-FR")
                                }}
                            </td>
                            <td class="text-right font-mono">
                                {{ formatCurrency(item.ttc) }}
                            </td>
                            <td
                                class="text-right font-mono"
                                :class="{
                                    'text-red-500 font-bold': item.reset > 0,
                                    'text-green-600': item.reset <= 0,
                                }"
                            >
                                {{ formatCurrency(item.reset) }}
                            </td>
                            <td class="flex justify-center gap-2">
                                <button
                                    class="btn btn-xs btn-info"
                                    @click="openDetail(item.IDCaisse)"
                                >
                                    Détail
                                </button>
                                <button
                                    class="btn btn-xs btn-success text-white"
                                    @click="openSolde(item.IDCaisse)"
                                >
                                    Solde
                                </button>
                                <button
                                    class="btn btn-xs btn-error text-white"
                                    @click="deleteCaisse(item.IDCaisse)"
                                >
                                    Supprimer
                                </button>
                            </td>
                        </tr>
                        <tr v-if="caisses.data.length === 0">
                            <td
                                colspan="5"
                                class="text-center py-8 text-gray-500"
                            >
                                Aucune donnée trouvée
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="flex justify-center mt-6">
                <div class="join">
                    <Link
                        v-for="link in caisses.links"
                        :key="link.label"
                        :href="link.url ?? '#'"
                        class="join-item btn btn-sm"
                        :class="{
                            'btn-active': link.active,
                            'btn-disabled': !link.url,
                        }"
                        v-html="link.label"
                    />
                </div>
            </div>
        </div>

        <!-- Modals -->
        <dialog class="modal" :class="{ 'modal-open': showDetailModal }">
            <div class="modal-box w-11/12 max-w-5xl">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="font-bold text-lg">Détails Examen</h3>
                    <button
                        class="btn btn-sm btn-circle btn-ghost"
                        @click="showDetailModal = false"
                    >
                        ✕
                    </button>
                </div>
                <div v-if="showDetailModal && selectedCaisseId">
                    <DetailModal
                        :caisseId="selectedCaisseId"
                        @refresh="refreshData"
                    />
                </div>
                <div class="modal-action">
                    <button class="btn" @click="showDetailModal = false">
                        Fermer
                    </button>
                </div>
            </div>
        </dialog>

        <dialog class="modal" :class="{ 'modal-open': showSoldeModal }">
            <div class="modal-box">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="font-bold text-lg">Gestion Solde</h3>
                    <button
                        class="btn btn-sm btn-circle btn-ghost"
                        @click="showSoldeModal = false"
                    >
                        ✕
                    </button>
                </div>
                <div v-if="showSoldeModal && selectedCaisseId">
                    <SoldeModal
                        :caisseId="selectedCaisseId"
                        @refresh="refreshData"
                    />
                </div>
                <div class="modal-action">
                    <button class="btn" @click="showSoldeModal = false">
                        Fermer
                    </button>
                </div>
            </div>
        </dialog>
    </MyLayout>
</template>
