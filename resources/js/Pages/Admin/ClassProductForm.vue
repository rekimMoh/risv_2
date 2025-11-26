<template>
    <div class="container mx-auto p-4">
      <h1 class="text-3xl font-bold mb-4">Formulaire classe Produit</h1>
      <form @submit.prevent="submit">
        <div class="form-group mb-4">
          <label for="libelle" class="block text-sm font-medium text-gray-700 mb-1" :class="{ 'text-red-600': errors.libelleCP }">Libelle Classe Produit</label>
          <input type="text" id="libelle" v-model="classProduit.libelleCP"
            class="form-input w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
            :class="{ 'border-red-500': errors.libelleCP }">
          <p v-if="errors.libelleCP" class="mt-1 text-sm text-red-600">{{ errors.libelleCP[0] }}</p>
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
    classProduit: {
      type: Object,
      default: { libelleCP: ''},
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
      if (props.classProduit.IDClasseProduit) {
        const response = await axios.put(`/class-produit/${props.classProduit.IDClasseProduit}`, props.classProduit)
        emit('updateRaw', response.data);
      } else {
        const response = await axios.post('/class-produit', props.classProduit)
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