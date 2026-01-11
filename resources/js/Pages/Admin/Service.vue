<template>
    <MyLayout>
        <div
            class="bg-white overflow-hidden shadow-sm sm:rounded-lg w-full col-span-4"
        >
            <div class="p-6 bg-white border-b border-gray-200">
                <h1 class="text-3xl font-bold mb-4">Liste des Services</h1>
                <div class="flex justify-between mb-4">
                    <input
                        type="text"
                        class="input w-full md:w-1/2 lg:w-1/3 xl:w-1/4"
                        v-model="search"
                        placeholder="Rechercher..."
                    />
                    <button
                        class="bg-emerald-600 text-white px-4 py-2 ml-4 hover:bg-emerald-500 rounded-lg transition-all"
                        @click="add"
                    >
                        Ajouter un Service
                    </button>
                </div>
            </div>
            <div class="p-6 overflow-x-auto bg-base-100 rounded-box shadow">
                <table class="table w-full">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Libellé</th>
                            <th>Etat</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr
                            v-for="(Service, index) in Services.data"
                            :key="Services.IDService"
                            class="hover"
                        >
                            <td class="font-bold">{{ Service.IDService }}</td>
                            <td>
                                {{ Service.libelleService }}
                            </td>
                            <td class="w-44">
                                <button
                                    @click="toggleService(index)"
                                    class="badge cursor-pointer border-none"
                                    :class="{
                                        'badge-success text-white':
                                            Service.etatService == 1,
                                        'badge-error text-white':
                                            Service.etatService == 0,
                                    }"
                                >
                                    <span v-if="Service.etatService == 1"
                                        >Désactiver</span
                                    >
                                    <span v-else>Activer</span>
                                </button>
                            </td>

                            <td class="w-44">
                                <div class="flex justify-start gap-2">
                                    <button
                                        class="btn btn-sm btn-ghost text-info"
                                        @click="edit(Service)"
                                        title="Modifier"
                                    >
                                        <i class="fas fa-edit text-lg"></i>
                                    </button>
                                    <button
                                        class="btn btn-sm btn-ghost text-error"
                                        @click="destroy(Service.IDService)"
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
                        :links="Services.links"
                        :from="Services.from"
                        :to="Services.to"
                        :total="Services.total"
                    />
                </div>
            </div>
        </div>

        <Modal :show="modal" @close="modal = false" maxWidth="lg">
            <ServiceForm
                :Service="Service"
                @closeModal="modal = false"
                @addRaw="pushRaw"
                @updateRaw="updateRaw"
            />
        </Modal>
    </MyLayout>
</template>

<script setup>
import { Link } from "@inertiajs/vue3";
import { ref, onMounted } from "vue";
import axios from "axios";
import MyLayout from "@/Layouts/MyLayout.vue";
import Pagination from "@/Components/Pagination.vue";
import Modal from "@/Components/Modal.vue";
import ServiceForm from "./ServiceForm.vue";

const props = defineProps({
    Services: {
        type: Object,
        required: true,
    },
});

const pushRaw = (Service) => {
    props.Services.data.push(Service);
    props.Services.total++;
    props.Services.to++;

    Service.value = { libelleService: "" };
};

const updateRaw = (Service) => {
    const index = props.Services.data.findIndex(
        (p) => p.IDService == Service.IDService
    );
    props.Services.data[index] = Service;
    Service.value = { libelleService: "" };
};

const Service = ref({ libelleService: "" });

const search = ref("");
const modal = ref(false);
const add = () => {
    Service.value = { libelleService: "" };
    modal.value = true;
};

const destroy = async (id) => {
    if (confirm("Voulez-vous supprimer cette classe produit ?")) {
        await axios.delete(`/service/${id}`);
        props.Services.data = props.Services.data.filter(
            (Service) => Service.IDService !== id
        );
        props.Services.total--;
        props.Services.to--;
    }
};

const edit = (prod) => {
    Service.value = prod;
    modal.value = true;
};

const toggleService = (index) => {
    const etat = props.Services.data[index].etatService == 1 ? 0 : 1;
    let params = {
        id: props.Services.data[index].IDService,
        etatService: etat,
    };
    axios
        .post(route("admin.service.toggle", params))
        .then((response) => {
            props.Services.data[index] = response.data;
        })
        .catch((error) => {
            console.error(error);
        });
};
</script>
