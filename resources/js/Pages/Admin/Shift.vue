<template>

    <MyLayout>
        <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg w-full col-span-4">
            <div class="p-6 bg-white border-b border-gray-200">
                <h1 class="text-3xl font-bold mb-4">Liste des Shifts</h1>
                <div class="flex justify-between mb-4">
                    <input type="text" class="form-input w-full md:w-1/2 lg:w-1/3 xl:w-1/4" v-model="search"
                        placeholder="Rechercher..." />
                    <button
                        class="bg-emerald-600 text-white px-4 py-2 ml-4 hover:bg-emerald-500 rounded-lg transition-all"
                        @click="add">
                        Ajouter un Shift
                    </button>
                </div>
            </div>
            <div class="p-6">
                <table class="w-full text-sm text-left text-gray-500">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                        <tr>

                            <th class="py-3 px-6">#</th>
                            <th class="py-3 px-6">Libellé</th>
                            <th class="py-3 px-6">couleur de shift</th>
                            <th class="py-3 px-6">Etat</th>
                            <th class="py-3 px-6">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(Shift, index) in Shifts.data" :key="Shifts.IDShift"
                            class="hover:bg-gray-100 border-b">
                            <td class="py-3 px-6">{{ Shift.IDShift }}</td>
                            <td class="py-3 px-6">{{ Shift.libelleShift }}</td>
                            <td class="py-3 px-6">
                                <span class="px-2  py-1 rounded-full size-5 w-20 table-cell h-7"
                                    :style="{ backgroundColor: Shift.colorShift,  }"></span>
                            </td>
                            <td class="py-3 px-6 w-44">
                                <button @click="toggleShift(index)"
                                    :class="{ 'bg-green-500': Shift.etatShift == 1, 'bg-red-500': Shift.etatShift == 0 }"
                                    class="px-4 py-2 text-white rounded">
                                    <span v-if="Shift.etatShift == 1">Désactiver</span>
                                    <span v-else>Activer</span>
                                </button>
                            </td>

                            <td class="py-3 px-6 w-44">
                                <div class="flex justify-around my-1">
                                    <button
                                        class="px-4 py-1 bg-orange-500 hover:bg-orange-400 hover:shadow-lg transition-all text-white rounded-full "
                                        @click="edit(Shift)">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button
                                        class="px-4 py-2 bg-red-600 hover:bg-red-500 hover:shadow-lg transition-all text-white rounded-full "
                                        @click="destroy(Shift.IDShift)">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <Pagination :links="Shifts.links" :from="Shifts.from" :to="Shifts.to" :total="Shifts.total"
                    class="mt-4" />
            </div>
        </div>

        <Modal :show="modal" @close="modal = false" maxWidth="lg">
            <ShiftForm :Shift="Shift" @closeModal="modal = false" @addRaw="pushRaw" @updateRaw="updateRaw" />
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
import ShiftForm from './ShiftForm.vue'

const props = defineProps({
    Shifts: {
        type: Object,
        required: true
    }
})

const pushRaw = (Shift) => {
    props.Shifts.data.push(Shift)
    props.Shifts.total++
    props.Shifts.to++

    Shift.value = { libelleShift: '', colorShift: ''}
}

const updateRaw = (Shift) => {
    const index = props.Shifts.data.findIndex(p => p.IDShift == Shift.IDShift)
    props.Shifts.data[index] = Shift
    Shift.value = { libelleShift: '', colorShift: ''}
}


const Shift = ref({ libelleShift: '', colorShift: ''})

const search = ref("");
const modal = ref(false);
const add = () => {
    Shift.value = { libelleShift: '', colorShift: ''}
    modal.value = true;
};

const destroy = async (id) => {
    if (confirm('Voulez-vous supprimer cette Shift ?')) {
        await axios.delete(`/shift/${id}`)
        props.Shifts.data = props.Shifts.data.filter(Shift => Shift.IDShift !== id)
        props.Shifts.total--
        props.Shifts.to--
    }
}

const edit = (s) => {
    console.log(s)
    Shift.value = s
    modal.value = true;
}

const toggleShift = (index) => {
    const etat = props.Shifts.data[index].etatShift == 1 ? 0 : 1
    let params = {
        id: props.Shifts.data[index].IDShift,
        etatShift: etat
    }
    axios.post(route('admin.shift.toggle', params))
        .then(response => {
            props.Shifts.data[index] = response.data
        })
        .catch(error => {
            console.error(error)
        })

}
</script>