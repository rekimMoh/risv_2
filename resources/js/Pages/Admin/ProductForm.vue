<template>
    <div class="container mx-auto p-4">
      <h1 class="text-3xl font-bold mb-4">Formulaire Produit</h1>
      <form @submit.prevent="submit">
        <div class="form-group mb-4">
          <label for="name">Libelle Produit</label>
          <input type="text" id="libelle" v-model="produit.libelleProduit" class="form-input w-full">
        </div>
        <div class="form-group mb-4">
          <label for="code">Classe de Produit</label>
          <select  id="cp" v-model="produit.class_produit_id" class="form-input w-full">
            <option value="">Selectionner</option>
            <option v-for="cp in calsseProduits" :key="cp.IDClasseProduit" :value="cp.IDClasseProduit">{{ cp.libelleCP }}</option>
          </select>
        </div>
        <div class="form-group mb-4">
          <label for="name_ar">Prix de Produit</label>
          <input type="number" id="prix" v-model="produit.prix_afficher" class="form-input w-full">
        </div>
        <button type="submit" class="btn btn-primary">Ajouter</button>
      </form>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue'
  import axios from 'axios'

  const props = defineProps({
    produit: {
      type: Object,
      default:{ libelleProduit: '', class_produit_id: '', prix_afficher: '' },
      required: true
    }
  })
  
  const calsseProduits = ref([])
 
onMounted(async () => {
  try {
    const response = await axios.get(route('listClasseProduits'));
    calsseProduits.value = response.data;
  } catch (error) {
    console.error(error);
  }
});

  
  const submit = async () => {
    try {
        if(props.produit.IDProduit){
            const response = await axios.put(`/produit/${props.produit.IDProduit}`, props.produit)
            console.log(response.data)
        } else {
            const response = await axios.post('/produit', props.produit)
            console.log(response.data)
        }
    
  } catch (error) {
    console.error(error)
  }
}
  </script>
  