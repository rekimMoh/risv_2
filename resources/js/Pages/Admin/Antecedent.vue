<template>

    <MyLayout>
        <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg w-full col-span-4">
            <div class="p-6 bg-white border-b border-gray-200">
                <h1 class="text-3xl font-bold mb-4">Liste des Antecedents</h1>
                <div class="flex justify-between mb-4">
                    <input type="text" class="form-input w-full md:w-1/2 lg:w-1/3 xl:w-1/4" v-model="search"
                        placeholder="Rechercher..." />
                    <button
                        class="bg-emerald-600 text-white px-4 py-2 ml-4 hover:bg-emerald-500 rounded-lg transition-all"
                        @click="add">
                        Ajouter un Antecedent
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
                        <tr v-for="(antecedent, index) in antecedents.data" :key="antecedents.IDAntecedent"
                            class="hover:bg-gray-100 border-b">
                            <td class="py-3 px-6">{{ antecedent.IDAntecedent }}</td>
                            <td class="py-3 px-6">{{ antecedent.libelleAntecedent }}</td>
                            <td class="py-3 px-6 w-44">
                                <button @click="toggleClassProduct(index)"
                                    :class="{ 'bg-green-500': antecedent.etatAntecedent == 1, 'bg-red-500': antecedent.etatAntecedent == 0 }"
                                    class="px-4 py-2 text-white rounded">
                                    <span v-if="antecedent.etatAntecedent == 1">Désactiver</span>
                                    <span v-else>Activer</span>
                                </button>
                            </td>

                            <td class="py-3 px-6 w-44">
                                <div class="flex justify-around my-1">
                                    <button
                                        class="px-4 py-1 bg-orange-500 hover:bg-orange-400 hover:shadow-lg transition-all text-white rounded-full "
                                        @click="edit(antecedent)">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button
                                        class="px-4 py-2 bg-red-600 hover:bg-red-500 hover:shadow-lg transition-all text-white rounded-full "
                                        @click="destroy(antecedent.IDAntecedent)">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <Pagination :links="antecedents.links" :from="antecedents.from" :to="antecedents.to" :total="antecedents.total"
                    class="mt-4" />
            </div>
        </div>

        <Modal :show="modal" @close="modal = false" maxWidth="lg">
            <AntecedentForm :antecedent="antecedent" @closeModal="modal = false" @addRaw="pushRaw" @updateRaw="updateRaw" />
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
import AntecedentForm from './AntecedentForm.vue'

const props = defineProps({
    antecedents: {
        type: Object,
        required: true
    }
})

const pushRaw = (antecedent) => {
    props.antecedents.data.push(antecedent)
    props.antecedents.total++
    props.antecedents.to++

    antecedent.value = { libelleAntecedent: ''}
}

const updateRaw = (antecedent) => {
    const index = props.antecedents.data.findIndex(p => p.IDAntecedent == antecedent.IDAntecedent)
    props.antecedents.data[index] = antecedent
    antecedent.value = { libelleAntecedent: '' }
}


const antecedent = ref({ libelleAntecedent: ''})

const search = ref("");
const modal = ref(false);
const add = () => {
    modal.value = true;
    antecedent.value = { libelleAntecedent: '' }
};

const destroy = async (id) => {
    if (confirm('Voulez-vous supprimer cette classe produit ?')) {
        await axios.delete(`/antecedent/${id}`)
        props.antecedents.data = props.antecedents.data.filter(antecedent => antecedent.IDAntecedent !== id)
        props.antecedents.total--
        props.antecedents.to--
    }
}

const edit = (prod) => {
    antecedent.value = prod
    modal.value = true
}

const toggleClassProduct = (index) => {
    const etat = props.antecedents.data[index].etatAntecedent == 1 ? 0 : 1
    let params = {
        id: props.antecedents.data[index].IDAntecedent,
        etatAntecedent: etat
    }
    axios.post(route('admin.antecedent.toggle', params))
        .then(response => {
            props.antecedents.data[index] = response.data
        })
        .catch(error => {
            console.error(error)
        })

}
</script>