<template>
    <MyLayout>
        <div
            class="bg-white overflow-hidden shadow-sm sm:rounded-lg w-full col-span-4"
        >
            <div class="p-6 bg-white border-b border-gray-200">
                <h1 class="text-3xl font-bold mb-4">Liste des produits</h1>
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
                        Ajouter un Produit
                    </button>
                </div>
            </div>
            <div class="p-6 overflow-x-auto bg-base-100 rounded-box shadow">
                <table class="table w-full">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Libellé</th>
                            <th>Class Produit</th>
                            <th>prix afficher</th>
                            <th>Etat</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr
                            v-for="(produit, index) in produits.data"
                            :key="produit.IDProduit"
                            class="hover"
                        >
                            <td class="font-bold">{{ produit.IDProduit }}</td>
                            <td>{{ produit.libelleProduit }}</td>
                            <td>{{ produit.libelleCP }}</td>
                            <td>{{ produit.prix_afficher }}</td>
                            <td class="w-44">
                                <button
                                    @click="toggleProduct(index)"
                                    class="badge cursor-pointer border-none"
                                    :class="{
                                        'badge-success text-white':
                                            produit.etatProduit == 1,
                                        'badge-error text-white':
                                            produit.etatProduit == 0,
                                    }"
                                >
                                    <span v-if="produit.etatProduit == 1"
                                        >Désactiver</span
                                    >
                                    <span v-else>Activer</span>
                                </button>
                            </td>

                            <td class="w-44">
                                <div class="flex justify-start gap-2">
                                    <button
                                        class="btn btn-sm btn-ghost text-info"
                                        @click="edit(produit)"
                                        title="Modifier"
                                    >
                                        <i class="fas fa-edit text-lg"></i>
                                    </button>
                                    <button
                                        class="btn btn-sm btn-ghost text-error"
                                        @click="destroy(produit.IDProduit)"
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
                        :links="produits.links"
                        :from="produits.from"
                        :to="produits.to"
                        :total="produits.total"
                    />
                </div>
            </div>
        </div>

        <Modal :show="modal" @close="modal = false" maxWidth="lg">
            <ProductForm
                :produit="produit"
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

const props = defineProps({
    produits: {
        type: Object,
        required: true,
    },
});

const pushRaw = (produit) => {
    props.produits.data.push(produit);
    props.produits.total++;
    props.produits.to++;

    produit.value = {
        libelleProduit: "",
        class_produit_id: "",
        prix_afficher: "",
    };
};

const updateRaw = (produit) => {
    const index = props.produits.data.findIndex(
        (p) => p.IDProduit == produit.IDProduit
    );
    props.produits.data[index] = produit;
    produit.value = {
        libelleProduit: "",
        class_produit_id: "",
        prix_afficher: "",
    };
};

const produit = ref({
    libelleProduit: "",
    IDClasseProduit: "",
    prix_afficher: "",
});

const search = ref("");
const modal = ref(false);
const add = () => {
    modal.value = true;
    produit.value = {
        libelleProduit: "",
        class_produit_id: "",
        prix_afficher: "",
    };
};

const destroy = async (id) => {
    if (confirm("Voulez-vous supprimer ce produit ?")) {
        await axios.delete(`/produit/${id}`);
        props.produits.data = props.produits.data.filter(
            (produit) => produit.IDProduit !== id
        );
        props.produits.total--;
        props.produits.to--;
    }
};

const edit = (prod) => {
    produit.value = prod;
    modal.value = true;
};

const toggleProduct = (index) => {
    const etat = props.produits.data[index].etatProduit == 1 ? 0 : 1;
    let params = {
        id: props.produits.data[index].IDProduit,
        etatProduit: etat,
    };
    axios
        .post(route("admin.produit.toggle", params))
        .then((response) => {
            let libelleCP = props.produits.data[index].libelleCP;
            props.produits.data[index] = response.data;
            props.produits.data[index].libelleCP = libelleCP;
        })
        .catch((error) => {
            console.error(error);
        });
};
</script>
