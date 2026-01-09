<template>
    <MyLayout>
        <div
            class="w-full col-span-4 bg-white overflow-hidden shadow-sm sm:rounded-lg"
        >
            <div class="p-6 bg-white border-b border-gray-200">
                <h1 class="text-3xl font-bold mb-4">
                    Gestion des Modèles de Comptes Rendus
                </h1>
                <div
                    class="flex flex-col md:flex-row justify-between mb-4 gap-4"
                >
                    <input
                        type="text"
                        class="w-full md:w-1/3 border-gray-300 rounded-md shadow-sm focus:border-emerald-500 focus:ring focus:ring-emerald-200 focus:ring-opacity-50"
                        v-model="search"
                        placeholder="Rechercher..."
                    />
                    <button
                        class="bg-emerald-600 text-white px-4 py-2 hover:bg-emerald-500 rounded-lg transition-all shadow-md"
                        @click="create"
                    >
                        Ajouter un compte rendu
                    </button>
                </div>
            </div>

            <div class="p-6 overflow-x-auto">
                <table class="w-full text-sm text-left text-gray-500">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                        <tr>
                            <th class="py-3 px-6">Index</th>
                            <th class="py-3 px-6">Titre</th>
                            <th class="py-3 px-6">Service</th>
                            <th class="py-3 px-6">Étude</th>
                            <th class="py-3 px-6">Statut</th>
                            <th class="py-3 px-6 text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-if="models.data.length === 0">
                            <td
                                colspan="6"
                                class="py-4 text-center text-gray-500"
                            >
                                Aucun modèle trouvé.
                            </td>
                        </tr>
                        <tr
                            v-for="(model, index) in models.data"
                            :key="model.IDCRM"
                            class="hover:bg-gray-100 border-b transition-colors"
                        >
                            <td class="py-3 px-6 font-medium text-gray-900">
                                {{ index + 1 }}
                            </td>
                            <td class="py-3 px-6">{{ model.titreCRM }}</td>
                            <td class="py-3 px-6">
                                <span
                                    class="bg-blue-100 text-blue-800 text-xs font-semibold px-2.5 py-0.5 rounded"
                                >
                                    {{
                                        model.etude?.service?.libelleService ||
                                        "N/A"
                                    }}
                                </span>
                            </td>
                            <td class="py-3 px-6">
                                {{ model.etude?.libelleEtude || "N/A" }}
                            </td>
                            <td class="py-3 px-6">
                                <button
                                    @click="toggleStatus(model)"
                                    :class="
                                        model.etatCRM == 1
                                            ? 'bg-green-500 hover:bg-green-600'
                                            : 'bg-red-500 hover:bg-red-600'
                                    "
                                    class="px-3 py-1 text-white rounded-full text-xs font-semibold transition-colors shadow-sm"
                                >
                                    {{
                                        model.etatCRM == 1 ? "Actif" : "Inactif"
                                    }}
                                </button>
                            </td>
                            <td class="py-3 px-6">
                                <div class="flex justify-center gap-3">
                                    <button
                                        @click="edit(model)"
                                        class="text-blue-600 hover:text-blue-800 hover:bg-blue-100 p-2 rounded-full transition-all"
                                        title="Modifier"
                                    >
                                        <i class="fas fa-edit text-lg"></i>
                                    </button>
                                    <button
                                        @click="duplicate(model)"
                                        class="text-orange-500 hover:text-orange-700 hover:bg-orange-100 p-2 rounded-full transition-all"
                                        title="Dupliquer"
                                    >
                                        <i class="fas fa-copy text-lg"></i>
                                    </button>
                                    <button
                                        @click="destroy(model)"
                                        class="text-red-600 hover:text-red-800 hover:bg-red-100 p-2 rounded-full transition-all"
                                        title="Supprimer"
                                    >
                                        <i class="fas fa-trash text-lg"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <Pagination
                    v-if="models.data.length > 0"
                    :links="models.links"
                    :from="models.from"
                    :to="models.to"
                    :total="models.total"
                    class="mt-4"
                />
            </div>
        </div>

        <Modal :show="modal" @close="closeModal" maxWidth="4xl">
            <crmForm
                v-if="modal"
                :model="selectedModel"
                :services="services"
                :etudes="etudes"
                @close="closeModal"
            />
        </Modal>
    </MyLayout>
</template>

<script setup>
import { ref, watch } from "vue";
import { router } from "@inertiajs/vue3";
import MyLayout from "@/Layouts/MyLayout.vue";
import Pagination from "@/Components/Pagination.vue";
import Modal from "@/Components/Modal.vue";
import crmForm from "./crmForm.vue";

const props = defineProps({
    models: Object,
    services: Array,
    etudes: Array,
});

const search = ref("");
const modal = ref(false);
const selectedModel = ref(null);

watch(search, (value) => {
    router.get(
        route("crm.index"),
        { search: value },
        {
            preserveState: true,
            preserveScroll: true,
            replace: true,
        }
    );
});

const create = () => {
    selectedModel.value = null;
    modal.value = true;
};

const edit = (model) => {
    selectedModel.value = model;
    modal.value = true;
};

const closeModal = () => {
    modal.value = false;
    setTimeout(() => {
        selectedModel.value = null;
    }, 200); // Wait for modal animation
};

const destroy = (model) => {
    if (confirm("Êtes-vous sûr de vouloir supprimer ce modèle ?")) {
        router.delete(route("crm.destroy", model.IDCRM), {
            preserveScroll: true,
        });
    }
};

const duplicate = (model) => {
    if (confirm("Voulez-vous dupliquer ce modèle ?")) {
        router.post(
            route("crm.duplicate", model.IDCRM),
            {},
            {
                preserveScroll: true,
            }
        );
    }
};

const toggleStatus = (model) => {
    router.post(
        route("crm.toggle"),
        {
            id: model.IDCRM,
            etat: model.etatCRM == 1 ? 0 : 1,
        },
        {
            preserveScroll: true,
            onSuccess: () => {
                // Optional: Notification handled by layout usually if flash messages exist
            },
        }
    );
};
</script>
