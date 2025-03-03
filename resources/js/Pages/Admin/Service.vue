<template>

    <MyLayout>
        <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg w-full col-span-4">
            <div class="p-6 bg-white border-b border-gray-200">
                <h1 class="text-3xl font-bold mb-4">Liste des Services</h1>
                <div class="flex justify-between mb-4">
                    <input type="text" class="form-input w-full md:w-1/2 lg:w-1/3 xl:w-1/4" v-model="search"
                        placeholder="Rechercher..." />
                    <button
                        class="bg-emerald-600 text-white px-4 py-2 ml-4 hover:bg-emerald-500 rounded-lg transition-all"
                        @click="openModal">
                        Ajouter un Service
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
                        <tr v-for="(Service, index) in Services.data" :key="Services.IDService"
                            class="hover:bg-gray-100 border-b">
                            <td class="py-3 px-6">{{ Service.IDService }}</td>
                            <td class="py-3 px-6">{{ Service.libelleService }}</td>
                            <td class="py-3 px-6 w-44">
                                <button @click="toggleService(index)"
                                    :class="{ 'bg-green-500': Service.etatService == 1, 'bg-red-500': Service.etatService == 0 }"
                                    class="px-4 py-2 text-white rounded">
                                    <span v-if="Service.etatService == 1">Désactiver</span>
                                    <span v-else>Activer</span>
                                </button>
                            </td>

                            <td class="py-3 px-6 w-44">
                                <div class="flex justify-around my-1">
                                    <button
                                        class="px-4 py-1 bg-orange-500 hover:bg-orange-400 hover:shadow-lg transition-all text-white rounded-full "
                                        @click="edit(Service)">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button
                                        class="px-4 py-2 bg-red-600 hover:bg-red-500 hover:shadow-lg transition-all text-white rounded-full "
                                        @click="destroy(Service.IDService)">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <Pagination :links="Services.links" :from="Services.from" :to="Services.to" :total="Services.total"
                    class="mt-4" />
            </div>
        </div>

        <Modal :show="modal" @close="modal = false" maxWidth="lg">
            <ServiceForm :Service="Service" @closeModal="modal = false" @addRaw="pushRaw" @updateRaw="updateRaw" />
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
import ServiceForm from './ServiceForm.vue'

const props = defineProps({
    Services: {
        type: Object,
        required: true
    }
})

const pushRaw = (Service) => {
    props.Services.data.push(Service)
    props.Services.total++
    props.Services.to++

    Service.value = { libelleService: ''}
}

const updateRaw = (Service) => {
    const index = props.Services.data.findIndex(p => p.IDService == Service.IDService)
    props.Services.data[index] = Service
    Service.value = { libelleService: '' }
}


const Service = ref({ libelleService: ''})

const search = ref("");
const modal = ref(false);
const openModal = () => {
    modal.value = true;
};

const destroy = async (id) => {
    if (confirm('Voulez-vous supprimer cette classe produit ?')) {
        await axios.delete(`/service/${id}`)
        props.Services.data = props.Services.data.filter(Service => Service.IDService !== id)
        props.Services.total--
        props.Services.to--
    }
}

const edit = (prod) => {
    Service.value = prod
    openModal()
}

const toggleService = (index) => {
    const etat = props.Services.data[index].etatService == 1 ? 0 : 1
    let params = {
        id: props.Services.data[index].IDService,
        etatService: etat
    }
    axios.post(route('admin.service.toggle', params))
        .then(response => {
            props.Services.data[index] = response.data
        })
        .catch(error => {
            console.error(error)
        })

}
</script>