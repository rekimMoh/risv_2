<template>

    <MyLayout>
        <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg w-full col-span-4">
            <div class="p-6 bg-white border-b border-gray-200">
                <h1 class="text-3xl font-bold mb-4">Liste des Etudes</h1>
                <div class="flex justify-between mb-4">
                    <input type="text" class="form-input w-full md:w-1/2 lg:w-1/3 xl:w-1/4" v-model="search"
                        placeholder="Rechercher..." />
                    <button
                        class="bg-emerald-600 text-white px-4 py-2 ml-4 hover:bg-emerald-500 rounded-lg transition-all"
                        @click="add">
                        Ajouter un Etude
                    </button>
                </div>
            </div>
            <div class="p-6">
                <table class="w-full text-sm text-left text-gray-500">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                        <tr>

                            <th class="py-3 px-6">#</th>
                            <th class="py-3 px-6">Libellé</th>
                            <th class="py-3 px-6">Service</th>
                            <th class="py-3 px-6">Etat</th>
                            <th class="py-3 px-6">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(Etude, index) in Etudes.data" :key="Etude.IDEtude"
                            class="hover:bg-gray-100 border-b">
                            <td class="py-3 px-6">{{ Etude.IDEtude }}</td>
                            <td class="py-3 px-6">{{ Etude.libelleEtude }}</td>
                            <td class="py-3 px-6">{{ Etude.libelleService }}</td>
                            <td class="py-3 px-6 w-44">
                                <button @click="toggleProduct(index)"
                                    :class="{ 'bg-green-500': Etude.etatEtude == 1, 'bg-red-500': Etude.etatEtude == 0 }"
                                    class="px-4 py-2 text-white rounded">
                                    <span v-if="Etude.etatEtude == 1">Désactiver</span>
                                    <span v-else>Activer</span>
                                </button>
                            </td>

                            <td class="py-3 px-6 w-44">
                                <div class="flex justify-around my-1">
                                    <button
                                        class="px-4 py-1 bg-orange-500 hover:bg-orange-400 hover:shadow-lg transition-all text-white rounded-full "
                                        @click="edit(Etude)">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button
                                        class="px-4 py-2 bg-red-600 hover:bg-red-500 hover:shadow-lg transition-all text-white rounded-full "
                                        @click="destroy(Etude.IDEtude)">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <Pagination :links="Etudes.links" :from="Etudes.from" :to="Etudes.to" :total="Etudes.total"
                    class="mt-4" />
            </div>
        </div>

        <Modal :show="modal" @close="modal = false" maxWidth="lg">
            <EtudeForm :Etude="Etude" :shifts="shifts" :services="services" @closeModal="modal = false" @addRaw="pushRaw" @updateRaw="updateRaw" />
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
import EtudeForm from '@/Pages/Admin/EtudeForm.vue'

const props = defineProps({
    Etudes: {
        type: Object,
        required: true
    }
})

const pushRaw = (Etude) => {
    props.Etudes.data.push(Etude)
    props.Etudes.total++
    props.Etudes.to++

    Etude.value = { libelleEtude: '', class_Etude_id: '', prix_afficher: '' }
}

const updateRaw = (Etude) => {
    const index = props.Etudes.data.findIndex(p => p.IDEtude == Etude.IDEtude)
    props.Etudes.data[index] = Etude
    Etude.value = { libelleEtude: '', class_Etude_id: '', prix_afficher: '' }
}


const Etude = ref({ libelleEtude: '', IDClasseEtude: '', prix_afficher: '' })

const search = ref("");
const modal = ref(false);
const add = () => {
    modal.value = true;
    Etude.value = { libelleEtude: '', class_Etude_id: '', prix_afficher: '' }
};

const destroy = async (id) => {
    if (confirm('Voulez-vous supprimer ce Etude ?')) {
        await axios.delete(`/etude/${id}`)
        props.Etudes.data = props.Etudes.data.filter(Etude => Etude.IDEtude !== id)
        props.Etudes.total--
        props.Etudes.to--
    }
}

const edit = (prod) => {
    Etude.value = prod
    modal.value = true
}

const toggleProduct = (index) => {
    const etat = props.Etudes.data[index].etatEtude == 1 ? 0 : 1
    let params = {
        id: props.Etudes.data[index].IDEtude,
        etatEtude: etat
    }
    axios.post(route('admin.etude.toggle', params))
        .then(response => {
            let libelleService = props.Etudes.data[index].libelleService
            props.Etudes.data[index] = response.data
            props.Etudes.data[index].libelleService = libelleService
        })
        .catch(error => {
            console.error(error)
        })

}

const shifts = ref([])
const services = ref([])

onMounted(() => {
    axios.get('/get-shift')
        .then(response => {
            shifts.value = response.data
        })
        .catch(error => {
            console.error(error)
        })

    axios.get('/get-service')
        .then(response => {
            services.value = response.data
        })
        .catch(error => {
            console.error(error)
        })


})
</script>