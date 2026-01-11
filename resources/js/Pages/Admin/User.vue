<template>
    <MyLayout>
        <div
            class="bg-white overflow-hidden shadow-sm sm:rounded-lg w-full col-span-4"
        >
            <div class="p-6 bg-white border-b border-gray-200">
                <h1 class="text-3xl font-bold mb-4">Liste des Users</h1>
                <div class="flex justify-between mb-4">
                    <input
                        type="text"
                        class="input w-full md:w-1/2 lg:w-1/3 xl:w-1/4"
                        v-model="search"
                        placeholder="Rechercher..."
                    />

                    <button
                        class="btn btn-success text-white transition-all"
                        @click="add"
                    >
                        Ajouter un Utilisateur
                    </button>
                </div>
            </div>
            <div class="p-6 overflow-x-auto bg-base-100 rounded-box shadow">
                <table class="table w-full">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Nom</th>
                            <th>Prenom</th>
                            <th>Post</th>
                            <th>Etat</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr
                            v-for="(User, index) in Users.data"
                            :key="User.IDUser"
                            class="hover"
                        >
                            <td>{{ User.id }}</td>
                            <td>{{ User.nom }}</td>
                            <td>{{ User.prenom }}</td>
                            <td>
                                {{ User.user_metier?.typeU || "N/A" }}
                            </td>
                            <td class="w-44">
                                <button
                                    @click="toggleUser(index)"
                                    class="badge cursor-pointer border-none"
                                    :class="{
                                        'badge-success text-white':
                                            User.is_active == 1,
                                        'badge-error text-white':
                                            User.is_active == 0,
                                    }"
                                >
                                    <span v-if="User.is_active == 1"
                                        >Désactiver</span
                                    >
                                    <span v-else>Activer</span>
                                </button>
                            </td>

                            <td class="w-44">
                                <div class="flex justify-start gap-2">
                                    <button
                                        class="btn btn-sm btn-ghost text-info"
                                        @click="edit(User)"
                                        title="Modifier"
                                    >
                                        <i class="fas fa-edit text-lg"></i>
                                    </button>
                                    <button
                                        class="btn btn-sm btn-ghost text-error"
                                        @click="destroy(User.IDUser)"
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
                        :links="Users.links"
                        :from="Users.from"
                        :to="Users.to"
                        :total="Users.total"
                    />
                </div>
            </div>
        </div>

        <Modal :show="modal" @close="modal = false" maxWidth="lg">
            <UserForm
                :User="User"
                :liens="liens"
                :medcins="medcins"
                :shifts="shifts"
                :userMeiters="userMeiters"
                :services="services"
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
import UserForm from "@/Pages/Admin/UserForm.vue";

const props = defineProps({
    Users: {
        type: Object,
        required: true,
    },

    liens: {
        type: Array,
        required: true,
    },

    userMeiters: {
        type: Array,
        required: true,
    },

    services: {
        type: Array,
        required: true,
    },
    medcins: {
        type: Array,
        required: true,
    },
    shifts: {
        type: Array,
        required: true,
    },
});

const pushRaw = (User) => {
    props.Users.data.push(User);
    props.Users.total++;
    props.Users.to++;

    User.value = { libelleUser: "", class_User_id: "", prix_afficher: "" };
};

const updateRaw = (User) => {
    const index = props.Users.data.findIndex((p) => p.IDUser == User.IDUser);
    props.Users.data[index] = User;
    User.value = { libelleUser: "", class_User_id: "", prix_afficher: "" };
};

const User = ref({ libelleUser: "", IDClasseUser: "", prix_afficher: "" });

const search = ref("");
const modal = ref(false);
const add = () => {
    modal.value = true;
    User.value = {
        libelleUser: null,
        class_User_id: null,
        prix_afficher: null,
        email: null,
        password: null,
        is_active: null,
        mode_paiements: [],
        user_metier_id: null,
        service_id: null,
        shift_id: null,
        medcin_id: null,
        nom: null,
        prenom: null,
        user_metier: null,
        service: null,
        shift: null,
        medcin: null,
    };
};

const destroy = async (id) => {
    if (confirm("Voulez-vous supprimer ce User ?")) {
        await axios.delete(`/User/${id}`);
        props.Users.data = props.Users.data.filter(
            (User) => User.IDUser !== id
        );
        props.Users.total--;
        props.Users.to--;
    }
};

const edit = (prod) => {
    User.value = prod;
    modal.value = true;
};

const toggleUser = (index) => {
    const etat = props.Users.data[index].is_active == 1 ? 0 : 1;
    let params = {
        id: props.Users.data[index].id,
        is_active: etat,
    };
    axios
        .post(route("admin.User.toggle", params))
        .then((response) => {
            let typeU = props.Users.data[index].typeU;
            props.Users.data[index] = response.data;
            props.Users.data[index].typeU = typeU;
        })
        .catch((error) => {
            console.error(error);
        });
};
</script>
