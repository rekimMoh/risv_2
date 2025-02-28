<template>

    <MyLayout>
        <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg w-full col-span-4">
            <div class="p-6 bg-white border-b border-gray-200">
                <h1 class="text-3xl font-bold mb-4">Liste des classes produit</h1>
                <div class="flex justify-between mb-4">
                    <input type="text" class="form-input w-full md:w-1/2 lg:w-1/3 xl:w-1/4" v-model="search"
                        placeholder="Rechercher..." />
                    <button
                        class="bg-emerald-600 text-white px-4 py-2 ml-4 hover:bg-emerald-500 rounded-lg transition-all"
                        @click="openModal">
                        Ajouter une classe Produit
                    </button>
                </div>
            </div>
            <div class="p-6">
                <table class="w-full text-sm text-left text-gray-500">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                        <tr>

                            <th class="py-3 px-6">#</th>
                            <th class="py-3 px-6">Libellé</th>
                            <th class="py-3 px-6">Etat</th>
                            <th class="py-3 px-6">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(classProduit, index) in classProduits.data" :key="classProduits.IDClasseProduit"
                            class="hover:bg-gray-100 border-b">
                            <td class="py-3 px-6">{{ classProduit.IDClasseProduit }}</td>
                            <td class="py-3 px-6">{{ classProduit.libelleCP }}</td>
                            <td class="py-3 px-6 w-44">
                                <button @click="toggleClassProduct(index)"
                                    :class="{ 'bg-green-500': classProduit.etatCP == 1, 'bg-red-500': classProduit.etatCP == 0 }"
                                    class="px-4 py-2 text-white rounded">
                                    <span v-if="classProduit.etatCP == 1">Désactiver</span>
                                    <span v-else>Activer</span>
                                </button>
                            </td>

                            <td class="py-3 px-6 w-44">
                                <div class="flex justify-around my-1">
                                    <button
                                        class="px-4 py-1 bg-orange-500 hover:bg-orange-400 hover:shadow-lg transition-all text-white rounded-full "
                                        @click="edit(classProduit)">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button
                                        class="px-4 py-2 bg-red-600 hover:bg-red-500 hover:shadow-lg transition-all text-white rounded-full "
                                        @click="destroy(classProduit.IDClasseProduit)">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <Pagination :links="classProduits.links" :from="classProduits.from" :to="classProduits.to" :total="classProduits.total"
                    class="mt-4" />
            </div>
        </div>

        <Modal :show="modal" @close="modal = false" maxWidth="lg">
            <ClassProductForm :classProduit="classProduit" @closeModal="modal = false" @addRaw="pushRaw" @updateRaw="updateRaw" />
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
import ProductForm from '@/Pages/Admin/ProductForm.vue'
import ClassProductForm from './ClassProductForm.vue'

const props = defineProps({
    classProduits: {
        type: Object,
        required: true
    }
})

const pushRaw = (classProduit) => {
    props.classProduits.data.push(classProduit)
    props.classProduits.total++
    props.classProduits.to++

    classProduit.value = { libelleCP: ''}
}

const updateRaw = (classProduit) => {
    const index = props.classProduits.data.findIndex(p => p.IDClasseProduit == classProduit.IDClasseProduit)
    props.classProduits.data[index] = classProduit
    classProduit.value = { libelleCP: '' }
}


const classProduit = ref({ libelleCP: ''})

const search = ref("");
const modal = ref(false);
const openModal = () => {
    modal.value = true;
};

const destroy = async (id) => {
    if (confirm('Voulez-vous supprimer cette classe produit ?')) {
        await axios.delete(`/cp/${id}`)
        props.classProduits.data = props.classProduits.data.filter(classProduit => classProduit.IDClasseProduit !== id)
        props.classProduits.total--
        props.classProduits.to--
    }
}

const edit = (prod) => {
    classProduit.value = prod
    openModal()
}

const toggleClassProduct = (index) => {
    const etat = props.classProduits.data[index].etatCP == 1 ? 0 : 1
    let params = {
        id: props.classProduits.data[index].IDClasseProduit,
        etatCP: etat
    }
    axios.post(route('admin.classProduit.toggle', params))
        .then(response => {
            props.classProduits.data[index] = response.data
        })
        .catch(error => {
            console.error(error)
        })

}
</script>