<template>
    <div class="container mx-auto p-4">
        <h1 class="text-3xl font-bold mb-4">Formulaire Shift</h1>
        <form @submit.prevent="submit">
            <div class="form-group mb-4">
                <label for="libelle" class="block text-sm font-medium text-gray-700 mb-1"
                    :class="{ 'text-red-600': errors.libelleShift }">Libelle Shift</label>
                <input type="text" id="libelle" v-model="Shift.libelleShift"
                    class="form-input w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                    :class="{ 'border-red-500': errors.libelleShift }">
                <p v-if="errors.libelleShift" class="mt-1 text-sm text-red-600">{{ errors.libelleShift[0] }}</p>
            </div>
            <div class="form-group mb-4">
                <label for="color" class="block text-sm font-medium text-gray-700 mb-1"
                    :class="{ 'text-red-600': errors.colorShift }">Couleur Shift</label>
                <input type="color" id="color" v-model="Shift.colorShift"
                    class="form-input w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                    :class="{ 'border-red-500': errors.colorShift }">
                <p v-if="errors.colorShift" class="mt-1 text-sm text-red-600">{{ errors.colorShift[0] }}</p>
            </div>
            <div class="my-20">
                <table>
                    <thead>
                        <tr>
                            <th></th>
                            <th class="text-left px-1.5" v-for="hour in hours" :key="hour.IDhour"> {{
                                hour.libelleHour }}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(day, indexDay) in days" :key="indexDay">
                            <th class="text-left px-3 py-2">{{ day.libelleDay }}</th>
                            <td class="border border-gray-200" v-for="(plan, indexPlan) in plan[indexDay]"
                                :key="indexPlan" :style="{ backgroundColor: plan.isSelected ? Shift.colorShift : 'white' }"
                                @click="plan.isSelected = !plan.isSelected">
                            </td>

                        </tr>
                    </tbody>
                </table>
            </div>

            <button type="submit"
                class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                Ajouter
            </button>
        </form>
    </div>
</template>

<script setup>
import { ref, onMounted, defineEmits } from 'vue'
import axios from 'axios'

const props = defineProps({
    Shift: {
        type: Object,
        default: { libelleShift: '', colorShift: '' },
        required: true
    }
})

const errors = ref({})



const emit = defineEmits(['closeModal', 'addRaw', 'updateRaw']);

// Fonction pour fermer le modal
const fermerModal = () => {
    emit('closeModal');
};



const submit = async () => {
    const params = props.Shift
    params.plan = plan.value
    try {
        if (props.Shift.IDShift) {
            const response = await axios.put(`/shift/${props.Shift.IDShift}`, params)
            emit('updateRaw', response.data);
        } else {
            const response = await axios.post('/shift', params)
            emit('addRaw', response.data);
        }
        fermerModal()


    } catch (error) {
        if (error.response && error.response.status === 422) {
            // Stockez les erreurs de Laravel
            errors.value = error.response.data.errors;
        } else {
            console.error(error);
        }
    }
}

const days = ref([])
const hours = ref([])
const plan = ref([])

async function initDayHour() {
    try {
        const responseDays = await axios.get('/day')
        days.value = responseDays.data

        const responseHours = await axios.get('/hour')
        hours.value = responseHours.data

        if (days.value.length > 0 && hours.value.length > 0) {
            days.value.forEach((day, indexDay) => {
                plan.value.push([])
                hours.value.forEach(hour => {
                    plan.value[indexDay].push({
                        day: day.IDDay,
                        hour: hour.IDHour,
                        isSelected: false
                    })
                })
            })
        }
        if (props.Shift.IDShift && plan.value.length > 0) {
            axios.get(`/get-day-hour-shift/${props.Shift.IDShift}`)
                .then(response => {
                    days.value.forEach((day, indexDay) => {
                        hours.value.forEach((hour, indexHour) => {
                            response.data.forEach(shift => {
                                if (shift.day_id == day.IDDay && shift.hour_id == hour.IDHour) {
                                    plan.value[indexDay][indexHour].isSelected = true
                                }
                            })
                        })
                    })
                })
                .catch(error => {
                    console.error(error)
                })
        }
    } catch (error) {
        console.log(error)
    }
}

onMounted(() => {
    initDayHour()

})
</script>