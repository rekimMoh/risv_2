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

            <div class="p-6 overflow-x-auto bg-base-100 rounded-box shadow">
                <table class="table w-full">
                    <thead>
                        <tr>
                            <th>Index</th>
                            <th>Titre</th>
                            <th>Service</th>
                            <th>Étude</th>
                            <th>Statut</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-if="models.data.length === 0">
                            <td
                                colspan="6"
                                class="text-center py-4 text-gray-500"
                            >
                                Aucun modèle trouvé.
                            </td>
                        </tr>
                        <tr
                            v-for="(model, index) in models.data"
                            :key="model.IDCRM"
                            class="hover"
                        >
                            <td class="font-bold">
                                {{ index + 1 }}
                            </td>
                            <td>{{ model.titreCRM }}</td>
                            <td>
                                <div class="badge badge-info gap-2">
                                    {{
                                        model.etude?.service?.libelleService ||
                                        "N/A"
                                    }}
                                </div>
                            </td>
                            <td>
                                {{ model.etude?.libelleEtude || "N/A" }}
                            </td>
                            <td>
                                <button
                                    @click="toggleStatus(model)"
                                    class="badge cursor-pointer"
                                    :class="
                                        model.etatCRM == 1
                                            ? 'badge-success text-white'
                                            : 'badge-error text-white'
                                    "
                                >
                                    {{
                                        model.etatCRM == 1 ? "Actif" : "Inactif"
                                    }}
                                </button>
                            </td>
                            <td>
                                <div class="flex justify-center gap-2">
                                    <button
                                        @click="edit(model)"
                                        class="btn btn-sm btn-ghost text-info"
                                        title="Modifier"
                                    >
                                        <i class="fas fa-edit text-lg"></i>
                                    </button>
                                    <button
                                        @click="duplicate(model)"
                                        class="btn btn-sm btn-ghost text-warning"
                                        title="Dupliquer"
                                    >
                                        <i class="fas fa-copy text-lg"></i>
                                    </button>
                                    <button
                                        @click="destroy(model)"
                                        class="btn btn-sm btn-ghost text-error"
                                        title="Supprimer"
                                    >
                                        <i class="fas fa-trash text-lg"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="mt-4">
                    <Pagination
                        v-if="models.data.length > 0"
                        :links="models.links"
                        :from="models.from"
                        :to="models.to"
                        :total="models.total"
                    />
                </div>
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
