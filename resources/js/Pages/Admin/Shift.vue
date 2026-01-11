<template>
    <MyLayout>
        <div
            class="bg-white overflow-hidden shadow-sm sm:rounded-lg w-full col-span-4"
        >
            <div class="p-6 bg-white border-b border-gray-200">
                <h1 class="text-3xl font-bold mb-4">Liste des Shifts</h1>
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
                        Ajouter un Shift
                    </button>
                </div>
            </div>
            <div class="p-6 overflow-x-auto bg-base-100 rounded-box shadow">
                <table class="table w-full">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Libellé</th>
                            <th>couleur de shift</th>
                            <th>Etat</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr
                            v-for="(Shift, index) in Shifts.data"
                            :key="Shifts.IDShift"
                            class="hover"
                        >
                            <td class="font-bold">{{ Shift.IDShift }}</td>
                            <td>{{ Shift.libelleShift }}</td>
                            <td>
                                <span
                                    class="badge w-6 h-6 rounded-full"
                                    :style="{
                                        backgroundColor: Shift.colorShift,
                                    }"
                                ></span>
                            </td>
                            <td class="w-44">
                                <button
                                    @click="toggleShift(index)"
                                    class="badge cursor-pointer border-none"
                                    :class="{
                                        'badge-success text-white':
                                            Shift.etatShift == 1,
                                        'badge-error text-white':
                                            Shift.etatShift == 0,
                                    }"
                                >
                                    <span v-if="Shift.etatShift == 1"
                                        >Désactiver</span
                                    >
                                    <span v-else>Activer</span>
                                </button>
                            </td>

                            <td class="w-44">
                                <div class="flex justify-start gap-2">
                                    <button
                                        class="btn btn-sm btn-ghost text-info"
                                        @click="edit(Shift)"
                                        title="Modifier"
                                    >
                                        <i class="fas fa-edit text-lg"></i>
                                    </button>
                                    <button
                                        class="btn btn-sm btn-ghost text-error"
                                        @click="destroy(Shift.IDShift)"
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
                        :links="Shifts.links"
                        :from="Shifts.from"
                        :to="Shifts.to"
                        :total="Shifts.total"
                    />
                </div>
            </div>
        </div>

        <Modal :show="modal" @close="modal = false" maxWidth="lg">
            <ShiftForm
                :Shift="Shift"
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
import ShiftForm from "./ShiftForm.vue";

const props = defineProps({
    Shifts: {
        type: Object,
        required: true,
    },
});

const pushRaw = (Shift) => {
    props.Shifts.data.push(Shift);
    props.Shifts.total++;
    props.Shifts.to++;

    Shift.value = { libelleShift: "", colorShift: "" };
};

const updateRaw = (Shift) => {
    const index = props.Shifts.data.findIndex(
        (p) => p.IDShift == Shift.IDShift
    );
    props.Shifts.data[index] = Shift;
    Shift.value = { libelleShift: "", colorShift: "" };
};

const Shift = ref({ libelleShift: "", colorShift: "" });

const search = ref("");
const modal = ref(false);
const add = () => {
    Shift.value = { libelleShift: "", colorShift: "" };
    modal.value = true;
};

const destroy = async (id) => {
    if (confirm("Voulez-vous supprimer cette Shift ?")) {
        await axios.delete(`/shift/${id}`);
        props.Shifts.data = props.Shifts.data.filter(
            (Shift) => Shift.IDShift !== id
        );
        props.Shifts.total--;
        props.Shifts.to--;
    }
};

const edit = (s) => {
    console.log(s);
    Shift.value = s;
    modal.value = true;
};

const toggleShift = (index) => {
    const etat = props.Shifts.data[index].etatShift == 1 ? 0 : 1;
    let params = {
        id: props.Shifts.data[index].IDShift,
        etatShift: etat,
    };
    axios
        .post(route("admin.shift.toggle", params))
        .then((response) => {
            props.Shifts.data[index] = response.data;
        })
        .catch((error) => {
            console.error(error);
        });
};
</script>
