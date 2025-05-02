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
                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                    <span class="text-red-600 text-sm" v-if="errors.nom">{{ errors.nom }}</span>
                </div>
                <div class="space-y-2">
                    <label for="prenom" class="block text-sm font-medium text-gray-700">Prénom</label>
                    <input type="text" id="prenom" v-model="User.prenom"
                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                    <span class="text-red-600 text-sm" v-if="errors.prenom">{{ errors.prenom }}</span>
                </div>
                <div class="space-y-2">
                    <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                    <input type="email" id="email" v-model="User.email"
                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                    <span class="text-red-600 text-sm" v-if="errors.email">{{ errors.email }}</span>
                </div>
                <div class="space-y-2">
                    <label for="userMeiter_id" class="block text-sm font-medium text-gray-700">Profile</label>
                    <select id="userMeiter_id" v-model="User.userMeiter_id"
                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                        <option v-for="userMeiter in userMeiters" :key="userMeiter.IDUserMetier"
                            :value="userMeiter.IDUserMetier">{{ userMeiter.typeU }}</option>
                    </select>
                    <span class="text-red-600 text-sm" v-if="errors.userMeiter_id">{{ errors.userMeiter_id }}</span>
                </div>
                <div class="space-y-2">
                    <label for="password" class="block text-sm font-medium text-gray-700">Mot de passe</label>
                    <input type="password" id="password" v-model="User.password"
                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                    <span class="text-red-600 text-sm" v-if="errors.password">{{ errors.password }}</span>
                </div>
                <div class="space-y-2">
                    <label for="password_confirmation" class="block text-sm font-medium text-gray-700">Confirmation du
                        mot de passe</label>
                    <input type="password" id="password_confirmation" v-model="User.password_confirmation"
                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                    <span class="text-red-600 text-sm" v-if="errors.password_confirmation">{{
                        errors.password_confirmation }}</span>
                </div>
                <div class="space-y-2" v-if="User.userMeiter_id == 2">
                    <label for="medcins" class="block text-sm font-medium text-gray-700">Signiature au nom de </label>
                    <select id="medcins" v-model="User.signature_medcin"
                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
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
                <div class="space-y-2" v-for="l in liens" :key="l.IDLien">
                    <label :for="l.IDLien" class="block text-sm font-medium text-gray-700">{{ l.nomUrl }}</label>
                    <input type="checkbox" :id="l.IDLien" v-model="lienUser" :value="l.IDLien"
                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                    <span class="text-red-600 text-sm" v-if="errors[l.IDLien]">{{ errors[l.IDLien] }}</span>

                </div>

            </div>
            <hr class="my-6 color-gray-300">

            <div class=" gap-6">
                <div class="text-lg font-medium leading-6 text-gray-400 col-span-4">
                    <label for="paieTacheActif">paiement par tâche</label>
                    <input type="checkbox" name="" id="paieTacheActif" v-model="paieTacheActif"
                        :value="User.mode_paiements.length > 0" :checked="User.mode_paiements.length > 0"
                        class=" ml-4 rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                    {{ paieTacheActif }}
                </div>

                    <div id="accordion-collapse" class="mt-10 w-full block " data-accordion="collapse">
                        <h2 id="accordion-collapse-heading-1">
                            <button type="button" @click="openAccordion = !openAccordion"
                                class="flex items-center justify-between w-full p-5 font-medium rtl:text-right text-gray-500 border border-b-0 border-gray-200 rounded-t-xl focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-800 dark:border-gray-700 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 gap-3"
                                data-accordion-target="#accordion-collapse-body-1" aria-expanded="true"
                                aria-controls="accordion-collapse-body-1">
                                <span>What is Flowbite?</span>
                                <svg data-accordion-icon class="w-3 h-3 rotate-180 shrink-0" aria-hidden="true"
                                    xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                        stroke-width="2" d="M9 5 5 1 1 5" />
                                </svg>
                            </button>
                        </h2>
                        <div id="accordion-collapse-body-1" :class="openAccordion ? 'open' : 'hidden'"
                            aria-labelledby="accordion-collapse-heading-1">
                            <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700 dark:bg-gray-900">
                                <p class="mb-2 text-gray-500 dark:text-gray-400">Flowbite is an open-source library of
                                    interactive components built on top of Tailwind CSS including buttons, dropdowns,
                                    modals, navbars, and more.</p>
                                <p class="text-gray-500 dark:text-gray-400">Check out this guide to learn how to <a
                                        href="/docs/getting-started/introduction/"
                                        class="text-blue-600 dark:text-blue-500 hover:underline">get started</a> and
                                    start developing websites even faster with components on top of Tailwind CSS.</p>
                            </div>
                        </div>
                        <h2 id="accordion-collapse-heading-2">
                            <button type="button"
                                class="flex items-center justify-between w-full p-5 font-medium rtl:text-right text-gray-500 border border-b-0 border-gray-200 focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-800 dark:border-gray-700 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 gap-3"
                                data-accordion-target="#accordion-collapse-body-2" aria-expanded="false"
                                aria-controls="accordion-collapse-body-2">
                                <span>Is there a Figma file available?</span>
                                <svg data-accordion-icon class="w-3 h-3 rotate-180 shrink-0" aria-hidden="true"
                                    xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                        stroke-width="2" d="M9 5 5 1 1 5" />
                                </svg>
                            </button>
                        </h2>
                        <div id="accordion-collapse-body-2" class="hidden"
                            aria-labelledby="accordion-collapse-heading-2">
                            <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                                <p class="mb-2 text-gray-500 dark:text-gray-400">Flowbite is first conceptualized and
                                    designed using the Figma software so everything you see in the library has a design
                                    equivalent in our Figma file.</p>
                                <p class="text-gray-500 dark:text-gray-400">Check out the <a
                                        href="https://flowbite.com/figma/"
                                        class="text-blue-600 dark:text-blue-500 hover:underline">Figma design system</a>
                                    based on the utility classes from Tailwind CSS and components from Flowbite.</p>
                            </div>
                        </div>
                        <h2 id="accordion-collapse-heading-3">
                            <button type="button"
                                class="flex items-center justify-between w-full p-5 font-medium rtl:text-right text-gray-500 border border-gray-200 focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-800 dark:border-gray-700 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 gap-3"
                                data-accordion-target="#accordion-collapse-body-3" aria-expanded="false"
                                aria-controls="accordion-collapse-body-3">
                                <span>What are the differences between Flowbite and Tailwind UI?</span>
                                <svg data-accordion-icon class="w-3 h-3 rotate-180 shrink-0" aria-hidden="true"
                                    xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                        stroke-width="2" d="M9 5 5 1 1 5" />
                                </svg>
                            </button>
                        </h2>
                        <div id="accordion-collapse-body-3" class="hidden"
                            aria-labelledby="accordion-collapse-heading-3">
                            <div class="p-5 border border-t-0 border-gray-200 dark:border-gray-700">
                                <p class="mb-2 text-gray-500 dark:text-gray-400">The main difference is that the core
                                    components from Flowbite are open source under the MIT license, whereas Tailwind UI
                                    is a paid product. Another difference is that Flowbite relies on smaller and
                                    standalone components, whereas Tailwind UI offers sections of pages.</p>
                                <p class="mb-2 text-gray-500 dark:text-gray-400">However, we actually recommend using
                                    both Flowbite, Flowbite Pro, and even Tailwind UI as there is no technical reason
                                    stopping you from using the best of two worlds.</p>
                                <p class="mb-2 text-gray-500 dark:text-gray-400">Learn more about these technologies:
                                </p>
                                <ul class="ps-5 text-gray-500 list-disc dark:text-gray-400">
                                    <li><a href="https://flowbite.com/pro/"
                                            class="text-blue-600 dark:text-blue-500 hover:underline">Flowbite Pro</a>
                                    </li>
                                    <li><a href="https://tailwindui.com/" rel="nofollow"
                                            class="text-blue-600 dark:text-blue-500 hover:underline">Tailwind UI</a>
                                    </li>
                                </ul>
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

onMounted(() => {
    form.value = { ...props.user }
})

const submit = async () => {
    try {
        if (form.value.id) {
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
