<template>
    <div class="container mx-auto p-4">
        <h1 class="text-3xl font-bold mb-4 text-gray-800">Formulaire Gestion Utilisateur</h1>
        <form @submit.prevent="submit">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <h3 class="text-lg font-medium leading-6 text-gray-400 col-span-2">
                    Informations Personnelles
                </h3>
                <div class="space-y-2">
                    <label for="nom" class="block text-sm font-medium text-gray-700">Nom</label>
                    <input type="text" id="nom" v-model="User.nom"
                        class="input">
                    <span class="text-red-600 text-sm" v-if="errors.nom">{{ errors.nom }}</span>
                </div>
                <div class="space-y-2">
                    <label for="prenom" class="block text-sm font-medium text-gray-700">Prénom</label>
                    <input type="text" id="prenom" v-model="User.prenom"
                        class="mt-1 input">
                    <span class="text-red-600 text-sm" v-if="errors.prenom">{{ errors.prenom }}</span>
                </div>
                <div class="space-y-2">
                    <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                    <input type="email" id="email" v-model="User.email"
                        class="mt-1 input">
                    <span class="text-red-600 text-sm" v-if="errors.email">{{ errors.email }}</span>
                </div>
                <div class="space-y-2">
                    <label for="userMeiter_id" class="block text-sm font-medium text-gray-700">Profile</label>
                    <select id="userMeiter_id" v-model="User.userMeiter_id"
                        class="mt-1 select">
                        <option v-for="userMeiter in userMeiters" :key="userMeiter.IDUserMetier"
                            :value="userMeiter.IDUserMetier">{{ userMeiter.typeU }}</option>
                    </select>
                    <span class="text-red-600 text-sm" v-if="errors.userMeiter_id">{{ errors.userMeiter_id }}</span>
                </div>
                <div class="space-y-2">
                    <label for="password" class="block text-sm font-medium text-gray-700">Mot de passe</label>
                    <input type="password" id="password" v-model="User.password"
                        class="mt-1 input">
                    <span class="text-red-600 text-sm" v-if="errors.password">{{ errors.password }}</span>
                </div>
                <div class="space-y-2">
                    <label for="password_confirmation" class="block text-sm font-medium text-gray-700">Confirmation du
                        mot de passe</label>
                    <input type="password" id="password_confirmation" v-model="User.password_confirmation"
                        class="mt-1 input">
                    <span class="text-red-600 text-sm" v-if="errors.password_confirmation">{{
                        errors.password_confirmation }}</span>
                </div>
                <div class="space-y-2" v-if="User.userMeiter_id == 2">
                    <label for="medcins" class="block text-sm font-medium text-gray-700">Signiature au nom de </label>
                    <select id="medcins" v-model="User.signature_medcin"
                        class="mt-1 input">
                        <option :value="null"> </option>
                        <option v-for="medcin in medcins" :key="medcin.id" :value="medcin.id">{{ medcin.nom }} {{
                            medcin.prenom }}</option>
                    </select>
                </div>

            </div>
            <hr class="my-6 color-gray-300">
            <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
                <h3 class="text-lg font-medium leading-6 text-gray-400 col-span-4">
                    gestion des Access
                </h3>
                <div v-for="l in liens" :key="l.IDLien">
                    <div class="" >
                    <input type="checkbox" :id="l.IDLien" v-model="lienUser" :value="l.IDLien" :aria-label="l.nomUrl"
                        class="btn checked:bg-blue-500 checked:border-blue-300 checked:text-white cursor-pointer btn-block">
                </div>
                </div>
            </div> 
            <hr class="my-6 color-gray-300"> 

            <div class=" gap-6">
                <div class="text-lg font-medium leading-6 text-gray-400 col-span-4">
                    <label for="paieTacheActif">paiement par tâche</label>
                    <input type="checkbox" name="" id="paieTacheActif" v-model="paieTacheActif"
                        :value="User.mode_paiements.length > 0" :checked="User.mode_paiements.length > 0"
                        class=" ml-4 toggle toggle- toggle-lg">
                    {{ paieTacheActif }}
                </div>   

                <div id="accordion-collapse" class="mt-10 w-full block " data-accordion="collapse">
                    <div v-for="service in services" :key="service.IDService">
                        <div id="accordion-collapse-heading-1" class="grid grid-cols-1 md:grid-cols-4 w-full p-5 font-medium rtl:text-right text-gray-500 border border-b-0 border-gray-200 rounded-t-xl focus:ring-4 focus:ring-gray-200gap-3">
                            <div class="col-span-3 flex items-center">
                                {{ service.libelleService }} : <input class="input" type="text">  
                                <input type="checkbox" 
                        class=" toggle"> Pourcentage
                            </div>
                            
                            <button type="button" @click="openAccordion = !openAccordion"
                                class="bg-green-600 hover:bg-green-500 text-white font-bold py-2 px-4 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500"
                                data-accordion-target="#accordion-collapse-body-1" aria-expanded="true"
                                aria-controls="accordion-collapse-body-1">
                                <span>Afficher</span>
                                <svg data-accordion-icon class="w-3 h-3 rotate-180 shrink-0" aria-hidden="true"
                                    xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                        stroke-width="2" d="M9 5 5 1 1 5" />
                                </svg>
                            </button>
                        </div>
                        <div id="accordion-collapse-body-1" :class="openAccordion ? 'open' : 'hidden'"
                            aria-labelledby="accordion-collapse-heading-1">
                           <div v-for="etude in service.etudes" :key="etude.IDEtude">
                                {{ etude.libelleEtude }} : <input type="text" class="input" > 
                                <input type="checkbox"
                                    class=" ml-4 toggle toggle-sm toggle-neutral"> Pourcentage

                           </div>
                        </div>
                    </div>

                </div>
                

                

            </div>
            <div class="mt-6">
                <button type="submit"
                    class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Enregistrer</button>
            </div>
        </form>
    </div>
</template>
<script setup>
import { ref, onMounted, defineEmits } from 'vue'
import axios from 'axios'

const props = defineProps({
    User: {
        type: Object,
        required: true
    },
    userMeiters: {
        type: Array,
        required: true
    },
    services: {
        type: Array,
        required: true
    },
    liens: {
        type: Array,
        required: true
    },
    medcins: {
        type: Array,
        required: true
    },
})

const paieTacheActif = ref()
const openAccordion = ref(false)
const form = ref({
    id: null,
    nom: '',
    prenom: '',
    email: '',
    password: '',
    password_confirmation: '',
    userMeiter_id: null,
    signature_medcin: null,
})

const lienUser = ref([])

props.User.lien_users.map(LU => {
    props.liens.map(l => {
        if (l.IDLien === LU.lien_id) {
            lienUser.value.push(l.IDLien)
        }
    })
})

const errors = ref({})

const emit = defineEmits(['closeModal', 'addRaw', 'updateRaw'])
const indexBtnAccordion = ref([])
onMounted(() => {
    form.value = { ...props.user }
    
      props.services.forEach(e => {
        indexBtnAccordion.value.push(false);
    })
})

const submit = async () => {
    try {
        if (form.value.id ) {
            await axios.put(route('admin.users.update', form.value.id), form.value)
            emit('updateRaw', form.value)
        } else {
            const response = await axios.post(route('admin.users.store'), form.value)
            emit('addRaw', response.data)
        }
        emit('closeModal')
    } catch (error) {
        if (error.response.status === 422) {
            errors.value = error.response.data.errors
        }
    }
}
</script>
