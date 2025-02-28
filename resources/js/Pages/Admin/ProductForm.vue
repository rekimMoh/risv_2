<template>
  <div class="container mx-auto p-4">
    <h1 class="text-3xl font-bold mb-4">Formulaire Produit</h1>
    <form @submit.prevent="submit">
      <div class="form-group mb-4">
        <label for="libelle" class="block text-sm font-medium text-gray-700 mb-1" :class="{ 'text-red-600': errors.libelleProduit }">Libelle Produit</label>
        <input type="text" id="libelle" v-model="produit.libelleProduit"
          class="form-input w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
          :class="{ 'border-red-500': errors.libelleProduit }">
        <p v-if="errors.libelleProduit" class="mt-1 text-sm text-red-600">{{ errors.libelleProduit[0] }}</p>
      </div>

      <div class="form-group mb-4">
        <label for="cp" class="block text-sm font-medium text-gray-700 mb-1">Classe de Produit</label>
        <select id="cp" v-model="produit.class_produit_id"
          class="form-input w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
          :class="{ 'border-red-500': errors.class_produit_id }">
          <option value="">Selectionner</option>
          <option v-for="cp in calsseProduits" :key="cp.IDClasseProduit" :value="cp.IDClasseProduit">{{ cp.libelleCP }}
          </option>
        </select>
        <p v-if="errors.class_produit_id" class="mt-1 text-sm text-red-600">{{ errors.class_produit_id[0] }}</p>
      </div>

      <div class="form-group mb-4">
        <label for="prix" class="block text-sm font-medium text-gray-700 mb-1">Prix de Produit</label>
        <input type="number" id="prix" v-model="produit.prix_afficher"
          class="form-input w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
          :class="{ 'border-red-500': errors.prix_afficher }">
        <p v-if="errors.prix_afficher" class="mt-1 text-sm text-red-600">{{ errors.prix_afficher[0] }}</p>
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
  produit: {
    type: Object,
    default: { libelleProduit: '', class_produit_id: '', prix_afficher: '' },
    required: true
  }
})

const calsseProduits = ref([])
const  errors = ref({})

onMounted(async () => {
  try {
    const response = await axios.get(route('listClasseProduits'));
    calsseProduits.value = response.data;
  } catch (error) {
    console.error(error);
  }
});

const emit = defineEmits(['closeModal', 'addRaw', 'updateRaw']);

// Fonction pour fermer le modal
const fermerModal = () => {
  emit('closeModal');
};



const submit = async () => {
  try {
    if (props.produit.IDProduit) {
      const response = await axios.put(`/produit/${props.produit.IDProduit}`, props.produit)
      emit('updateRaw', response.data);
    } else {
      const response = await axios.post('/produit', props.produit)
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