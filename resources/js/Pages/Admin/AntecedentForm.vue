<template>
    <div class="container mx-auto p-4">
      <h1 class="text-3xl font-bold mb-4">Formulaire Antecedent</h1>
      <form @submit.prevent="submit">
        <div class="form-group mb-4">
          <label for="libelle" class="block text-sm font-medium text-gray-700 mb-1" :class="{ 'text-red-600': errors.libelleAntecedent }">Libelle Antecedent</label>
          <input type="text" id="libelle" v-model="antecedent.libelleAntecedent"
            class="form-input w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
            :class="{ 'border-red-500': errors.libelleAntecedent }">
          <p v-if="errors.libelleAntecedent" class="mt-1 text-sm text-red-600">{{ errors.libelleAntecedent[0] }}</p>
        </div>
  
  
        <button type="submit"
          class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
          Ajouter
        </button>
      </form>
    </div>
  </template>
  
  <script setup>
  import { ref, defineEmits } from 'vue'
  import axios from 'axios'
  
  const props = defineProps({
    antecedent: {
      type: Object,
      default: { libelleAntecedent: ''},
      required: true
    }
  })
  
  const  errors = ref({})
  
 
  
  const emit = defineEmits(['closeModal', 'addRaw', 'updateRaw']);
  
  // Fonction pour fermer le modal
  const fermerModal = () => {
    emit('closeModal');
  };
  
  
  
  const submit = async () => {
    try {
      if (props.antecedent.IDAntecedent) {
        const response = await axios.put(`/antecedent/${props.antecedent.IDAntecedent}`, props.antecedent)
        emit('updateRaw', response.data);
      } else {
        const response = await axios.post('/antecedent', props.antecedent)
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