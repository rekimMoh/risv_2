<template>

    <MyLayout>
        <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg w-full col-span-4">
            <div class="p-6 bg-white border-b border-gray-200">
                <h1 class="text-3xl font-bold mb-4">Liste des Users</h1>
                <div class="flex justify-between mb-4">
                    <input type="text" class="input w-full md:w-1/2 lg:w-1/3 xl:w-1/4" v-model="search"
                        placeholder="Rechercher..." />
                       
                    <button
                        class="btn btn-success text-white transition-all"
                        @click="add">
                        Ajouter un Utilisateur 
                    </button>
                    
                </div>
            </div>
            <div class="p-6">
                <table class="table table-zebra">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                        <tr>

                            <th class="py-3 px-6">#</th>
                            <th class="py-3 px-6">Nom</th>
                            <th class="py-3 px-6">Prenom</th>
                            <th class="py-3 px-6">Post</th>
                            <th class="py-3 px-6">Etat</th>
                            <th class="py-3 px-6">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(User, index) in Users.data" :key="User.IDUser"
                            class="hover:bg-gray-100 border-b">
                            <td class="py-3 px-6">{{ User.id }}</td>
                            <td class="py-3 px-6">{{ User.nom }}</td>
                            <td class="py-3 px-6">{{ User.prenom }} </td>
                            <td class="py-3 px-6">{{ User.user_metier?.typeU || 'N/A' }}</td>
                            <td class="py-3 px-6 w-44">
                                <button @click="toggleUser(index)"
                                    :class="{ 'btn-success': User.is_active == 1, 'btn-error': User.is_active == 0 }"
                                    class="btn px-4 py-2 text-white rounded">
                                    <span v-if="User.is_active == 1">Désactiver</span>
                                    <span v-else>Activer</span>
                                </button>
 
                                
                            </td>

                            <td class="py-3 px-6 w-44">
                                <div class="flex justify-around my-1">
                                    <button
                                        class="btn btn-warning px-4 py-2 rounded-full "
                                        @click="edit(User)">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button
                                        class="btn btn-error rounded-full "
                                        @click="destroy(User.IDUser)">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <Pagination :links="Users.links" :from="Users.from" :to="Users.to" :total="Users.total"
                    class="mt-4" />
            </div>
        </div>

        <Modal :show="modal" @close="modal = false" maxWidth="lg">
            <UserForm :User="User" :liens="liens" :medcins="medcins" :shifts="shifts" :userMeiters="userMeiters" :services="services" @closeModal="modal = false" @addRaw="pushRaw" @updateRaw="updateRaw" />
        </Modal>
    </MyLayout>
</template>

<script setup>
import { Link } from '@inertiajs/vue3'
import { ref, onMounted } from 'vue'
import axios from 'axios'
import MyLayout from '@/Layouts/MyLayout.vue'
import Pagination from '@/Components/Pagination.vue'
import Modal from '@/Components/Modal.vue'
import UserForm from '@/Pages/Admin/UserForm.vue'

const props = defineProps({
    Users: {
        type: Object,
        required: true
    },

    liens: {
        type: Array,
        required: true
    },

    userMeiters: {
        type: Array,
        required: true
    },

    services: {
        type: Array,
        required: true
    },
    medcins: {
        type: Array,
        required: true
    },
    shifts: {
        type: Array,
        required: true
    }
})

const pushRaw = (User) => {
    props.Users.data.push(User)
    props.Users.total++
    props.Users.to++

    User.value = { libelleUser: '', class_User_id: '', prix_afficher: '' }
}

const updateRaw = (User) => {
    const index = props.Users.data.findIndex(p => p.IDUser == User.IDUser)
    props.Users.data[index] = User
    User.value = { libelleUser: '', class_User_id: '', prix_afficher: '' }
}


const User = ref({ libelleUser: '', IDClasseUser: '', prix_afficher: '' })

const search = ref("");
const modal = ref(false);
const add = () => {
    modal.value = true;
    User.value = { libelleUser: '', class_User_id: '', prix_afficher: '' }
};

const destroy = async (id) => {
    if (confirm('Voulez-vous supprimer ce User ?')) {
        await axios.delete(`/User/${id}`)
        props.Users.data = props.Users.data.filter(User => User.IDUser !== id)
        props.Users.total--
        props.Users.to--
    }
}

const edit = (prod) => {
    User.value = prod
    modal.value = true
}

const toggleUser = (index) => {
    const etat = props.Users.data[index].is_active == 1 ? 0 : 1
    let params = {
        id: props.Users.data[index].id,
        is_active: etat
    }
    axios.post(route('admin.User.toggle', params))
        .then(response => {
            let typeU = props.Users.data[index].typeU
            props.Users.data[index] = response.data
            props.Users.data[index].typeU = typeU
        })
        .catch(error => {
            console.error(error)
        })

}
</script>