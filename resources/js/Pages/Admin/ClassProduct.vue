<template>
    <MyLayout>
        <div
            class="bg-white overflow-x-auto shadow-sm sm:rounded-lg w-full col-span-4"
        >
            <div class="p-6 bg-white border-b border-gray-200">
                <h1 class="text-3xl font-bold mb-4">
                    Liste des classes produit
                </h1>
                <div class="flex justify-between mb-4">
                    <input
                        type="text"
                        class="form-input w-full md:w-1/2 lg:w-1/3 xl:w-1/4"
                        v-model="search"
                        placeholder="Rechercher..."
                    />
                    <button
                        class="bg-emerald-600 text-white px-4 py-2 ml-4 hover:bg-emerald-500 rounded-lg transition-all"
                        @click="add"
                    >
                        Ajouter une classe Produit
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
                            v-for="(classProduit, index) in classProduits.data"
                            :key="classProduits.IDClasseProduit"
                            class="hover"
                        >
                            <td class="font-bold">
                                {{ classProduit.IDClasseProduit }}
                            </td>
                            <td>{{ classProduit.libelleCP }}</td>
                            <td class="w-44">
                                <button
                                    @click="toggleClassProduct(index)"
                                    class="badge cursor-pointer border-none"
                                    :class="{
                                        'badge-success text-white':
                                            classProduit.etatCP == 1,
                                        'badge-error text-white':
                                            classProduit.etatCP == 0,
                                    }"
                                >
                                    <span v-if="classProduit.etatCP == 1"
                                        >Désactiver</span
                                    >
                                    <span v-else>Activer</span>
                                </button>
                            </td>

                            <td class="w-44">
                                <div class="flex justify-start gap-2">
                                    <button
                                        class="btn btn-sm btn-ghost text-info"
                                        @click="edit(classProduit)"
                                        title="Modifier"
                                    >
                                        <i class="fas fa-edit text-lg"></i>
                                    </button>
                                    <button
                                        class="btn btn-sm btn-ghost text-error"
                                        @click="
                                            destroy(
                                                classProduit.IDClasseProduit
                                            )
                                        "
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
                        :links="classProduits.links"
                        :from="classProduits.from"
                        :to="classProduits.to"
                        :total="classProduits.total"
                    />
                </div>
            </div>
        </div>

        <Modal :show="modal" @close="modal = false" maxWidth="lg">
            <ClassProductForm
                :classProduit="classProduit"
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
import ProductForm from "@/Pages/Admin/ProductForm.vue";
import ClassProductForm from "./ClassProductForm.vue";

const props = defineProps({
    classProduits: {
        type: Object,
        required: true,
    },
});

const pushRaw = (classProduit) => {
    props.classProduits.data.push(classProduit);
    props.classProduits.total++;
    props.classProduits.to++;

    classProduit.value = { libelleCP: "" };
};

const updateRaw = (classProduit) => {
    const index = props.classProduits.data.findIndex(
        (p) => p.IDClasseProduit == classProduit.IDClasseProduit
    );
    props.classProduits.data[index] = classProduit;
    classProduit.value = { libelleCP: "" };
};

const classProduit = ref({ libelleCP: "" });

const search = ref("");
const modal = ref(false);
const add = () => {
    classProduit.value = { libelleCP: "" };
    modal.value = true;
};

const destroy = async (id) => {
    if (confirm("Voulez-vous supprimer cette classe produit ?")) {
        await axios.delete(`/class-produit/${id}`);
        props.classProduits.data = props.classProduits.data.filter(
            (classProduit) => classProduit.IDClasseProduit !== id
        );
        props.classProduits.total--;
        props.classProduits.to--;
    }
};

const edit = (prod) => {
    classProduit.value = prod;
    modal.value = true;
};

const toggleClassProduct = (index) => {
    const etat = props.classProduits.data[index].etatCP == 1 ? 0 : 1;
    let params = {
        id: props.classProduits.data[index].IDClasseProduit,
        etatCP: etat,
    };
    axios
        .post(route("admin.classProduit.toggle", params))
        .then((response) => {
            props.classProduits.data[index] = response.data;
        })
        .catch((error) => {
            console.error(error);
        });
};
</script>
