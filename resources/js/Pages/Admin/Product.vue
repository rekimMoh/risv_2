<template>
     
    <MyLayout>
    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg w-full col-span-4">
        <div class="p-6 bg-white border-b border-gray-200">
            <h1 class="text-3xl font-bold">Liste des produits</h1>
            <button class="float-right mt-2 px-4 py-2 bg-green-500 text-white rounded">
                Ajouter un nouveau produit
            </button>
        </div>
        <div class="p-6">
            <table class="w-full text-sm text-left text-gray-500">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                    <tr>
                        <th class="py-3 px-6">ID</th>
                        <th class="py-3 px-6">Libellé</th>
                        <th class="py-3 px-6">Etat</th>
                        <th class="py-3 px-6">Prix</th>
                        <th class="py-3 px-6">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="produit in produits.data" :key="produit.IDProduit" class="hover:bg-gray-100 border-b">
                        <td class="py-3 px-6">{{ produit.IDProduit }}</td>
                        <td class="py-3 px-6">{{ produit.libelleProduit }}</td>
                        <td class="py-3 px-6">
                            <span v-if="produit.etatProduit == 1" class="text-green-500">Actif</span>
                            <span v-else class="text-red-500">Inactif</span>
                        </td>
                        <td class="py-3 px-6">{{ produit.prix_afficher }}</td>
                        <td class="py-3 px-6">
                            <button  class="px-4 py-2 bg-blue-500 text-white rounded">
                                Modifier
                            </button>
                            <button  class="px-4 py-2 bg-red-500 text-white rounded" @click="destroy(produit.IDProduit)">
                                Supprimer
                            </button>
                            <button  class="px-4 py-2 bg-yellow-500 text-white rounded">
                                Désactiver
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</MyLayout>
</template>

<script setup>
import { Link } from '@inertiajs/vue3'
import { ref, onMounted } from 'vue'
import axios from 'axios'
import MyLayout from '@/Layouts/MyLayout.vue'

const props = defineProps({
  produits: {
    type: Object,
    required: true
  }
})

const destroy = async (id) => {
    if (confirm('Voulez-vous supprimer ce produit ?')) {
        await axios.delete(route('admin.produit.destroy', id))
        produits.value.data = produits.value.data.filter(produit => produit.IDProduit !== id)
    }
}
</script>