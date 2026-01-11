<template>
    <MyLayout>
        <div
            class="bg-white overflow-hidden shadow-sm sm:rounded-lg w-full col-span-4"
        >
            <div class="p-6 bg-white border-b border-gray-200">
                <h1 class="text-3xl font-bold mb-4">Liste des Antecedents</h1>
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
                        Ajouter un Antecedent
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
                            v-for="(antecedent, index) in antecedents.data"
                            :key="antecedents.IDAntecedent"
                            class="hover"
                        >
                            <td class="font-bold">
                                {{ antecedent.IDAntecedent }}
                            </td>
                            <td>{{ antecedent.libelleAntecedent }}</td>
                            <td class="w-44">
                                <button
                                    @click="toggleClassProduct(index)"
                                    class="badge cursor-pointer border-none"
                                    :class="{
                                        'badge-success text-white':
                                            antecedent.etatAntecedent == 1,
                                        'badge-error text-white':
                                            antecedent.etatAntecedent == 0,
                                    }"
                                >
                                    <span v-if="antecedent.etatAntecedent == 1"
                                        >Désactiver</span
                                    >
                                    <span v-else>Activer</span>
                                </button>
                            </td>

                            <td class="w-44">
                                <div class="flex justify-start gap-2">
                                    <button
                                        class="btn btn-sm btn-ghost text-info"
                                        @click="edit(antecedent)"
                                        title="Modifier"
                                    >
                                        <i class="fas fa-edit text-lg"></i>
                                    </button>
                                    <button
                                        class="btn btn-sm btn-ghost text-error"
                                        @click="
                                            destroy(antecedent.IDAntecedent)
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
                        :links="antecedents.links"
                        :from="antecedents.from"
                        :to="antecedents.to"
                        :total="antecedents.total"
                    />
                </div>
            </div>
        </div>

        <Modal :show="modal" @close="modal = false" maxWidth="lg">
            <AntecedentForm
                :antecedent="antecedent"
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
import AntecedentForm from "./AntecedentForm.vue";

const props = defineProps({
    antecedents: {
        type: Object,
        required: true,
    },
});

const pushRaw = (antecedent) => {
    props.antecedents.data.push(antecedent);
    props.antecedents.total++;
    props.antecedents.to++;

    antecedent.value = { libelleAntecedent: "" };
};

const updateRaw = (antecedent) => {
    const index = props.antecedents.data.findIndex(
        (p) => p.IDAntecedent == antecedent.IDAntecedent
    );
    props.antecedents.data[index] = antecedent;
    antecedent.value = { libelleAntecedent: "" };
};

const antecedent = ref({ libelleAntecedent: "" });

const search = ref("");
const modal = ref(false);
const add = () => {
    modal.value = true;
    antecedent.value = { libelleAntecedent: "" };
};

const destroy = async (id) => {
    if (confirm("Voulez-vous supprimer cette classe produit ?")) {
        await axios.delete(`/antecedent/${id}`);
        props.antecedents.data = props.antecedents.data.filter(
            (antecedent) => antecedent.IDAntecedent !== id
        );
        props.antecedents.total--;
        props.antecedents.to--;
    }
};

const edit = (prod) => {
    antecedent.value = prod;
    modal.value = true;
};

const toggleClassProduct = (index) => {
    const etat = props.antecedents.data[index].etatAntecedent == 1 ? 0 : 1;
    let params = {
        id: props.antecedents.data[index].IDAntecedent,
        etatAntecedent: etat,
    };
    axios
        .post(route("admin.antecedent.toggle", params))
        .then((response) => {
            props.antecedents.data[index] = response.data;
        })
        .catch((error) => {
            console.error(error);
        });
};
</script>
