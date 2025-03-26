<template>
    <div class="container mx-auto p-4">
        <h1 class="text-3xl font-bold mb-4">Formulaire Etude</h1>
        <form @submit.prevent="submit">
            <div class="form-group mb-4">
                <label for="libelle" class="block text-sm font-medium text-gray-700 mb-1">Libelle Etude</label>
                <input type="text" id="libelle" v-model="Etude.libelleEtude"
                    class="form-input w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                    required>
            </div>

            <div class="form-group mb-4">
                <label for="serice" class="block text-sm font-medium text-gray-700 mb-1">Service</label>
                <select v-model="Etude.service_id" id="serice"
                    class="form-input w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                    required>
                    <option value="">Selectionner</option>
                    <option v-for="service in services" :key="service.IDService" :value="service.IDService">
                        {{ service.libelleService }}
                    </option>
                </select>

            </div>
            <div class="grid md:grid-cols-2 gap-4">
                <div class="form-group mb-4" v-for="prix in prix_exams" :key="prix.shift_id">
                    <label for="duree" class="block text-sm font-medium text-gray-700 mb-1">
                        Prix {{ prix.libelleShift }}</label>
                    <input type="number" id="duree" v-model="prix.montantPrixExam"
                        class="form-input w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                        required>
                </div>
            </div>



            <button type="submit"
                class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                Ajouter
            </button>
        </form>
    </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import { useForm } from '@inertiajs/vue3'

const props = defineProps({
    shifts: {
        type: Array,
        required: true
    },
    services: {
        type: Array,
        required: true
    },
    Etude: {
        type: Object,
        required: true
    }
})

const prix_exams = ref([])

onMounted(() => {
    props.shifts.forEach(shift => {
        let prix;
        props.Etude.prix_exams ?  prix = props.Etude.prix_exams.find(p => p.shift_id == shift.IDShift) : prix = false
            if (prix) {
                prix_exams.value.push({
                    libelleShift: shift.libelleShift,
                    shift_id: shift.IDShift,
                    montantPrixExam: prix.montantPrixExam,
                    IDPrixExam: prix.IDPrixExam
                })    
            } else  {  
                prix_exams.value.push({
                    libelleShift: shift.libelleShift,
                    shift_id: shift.IDShift,
                    montantPrixExam: '',
                    IDPrixExam: false
                })
            }
            

    })
})

const etude = ref({
    libelleEtude: '',
    prix: '',
    duree: '',
    nombreDePlace: ''
})

const  errors = ref({})
  
 
  
  const emit = defineEmits(['closeModal', 'addRaw', 'updateRaw']);
  
  // Fonction pour fermer le modal
  const fermerModal = () => {
    emit('closeModal');
  };
  
  
  
  const submit = async () => {
    try {
        const params = {
            ...props.Etude,
            prix_exams: prix_exams.value
        }
      if (props.Etude.IDEtude) {
        const response = await axios.put(`/etude/${props.Etude.IDEtude}`, params)
        emit('updateRaw', response.data);
      } else {
        const response = await axios.post('/etude', params)
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

</script>
