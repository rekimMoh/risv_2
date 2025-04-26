<template>
    <form @submit.prevent="submit">
        <div class="space-y-6">
            <div class="space-y-2">
                <label for="nom" class="block text-sm font-medium text-gray-700">Nom</label>
                <input type="text" id="nom" v-model="form.nom" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                <span class="text-red-600 text-sm" v-if="errors.nom">{{ errors.nom }}</span>
            </div>
            <div class="space-y-2">
                <label for="prenom" class="block text-sm font-medium text-gray-700">Prénom</label>
                <input type="text" id="prenom" v-model="form.prenom" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                <span class="text-red-600 text-sm" v-if="errors.prenom">{{ errors.prenom }}</span>
            </div>
            <div class="space-y-2">
                <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                <input type="email" id="email" v-model="form.email" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                <span class="text-red-600 text-sm" v-if="errors.email">{{ errors.email }}</span>
            </div>
            <div class="space-y-2">
                <label for="password" class="block text-sm font-medium text-gray-700">Mot de passe</label>
                <input type="password" id="password" v-model="form.password" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                <span class="text-red-600 text-sm" v-if="errors.password">{{ errors.password }}</span>
            </div>
            <div class="space-y-2">
                <label for="password_confirmation" class="block text-sm font-medium text-gray-700">Confirmation du mot de passe</label>
                <input type="password" id="password_confirmation" v-model="form.password_confirmation" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                <span class="text-red-600 text-sm" v-if="errors.password_confirmation">{{ errors.password_confirmation }}</span>
            </div>
            <div class="space-y-2">
                <label for="userMeiter_id" class="block text-sm font-medium text-gray-700">Classe</label>
                <select id="userMeiter_id" v-model="form.userMeiter_id" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
                    <option v-for="userMeiter in $page.props.userMeiters" :key="userMeiter.IDUserMetier" :value="userMeiter.IDUserMetier">{{ userMeiter.libelleUserMetier }}</option>
                </select>
                <span class="text-red-600 text-sm" v-if="errors.userMeiter_id">{{ errors.userMeiter_id }}</span>
            </div>
        </div>
        <div class="mt-6">
            <button type="submit" class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Enregistrer</button>
        </div>
    </form>
</template>
<script setup>
import { ref, onMounted, defineEmits } from 'vue'
import axios from 'axios'

const props = defineProps({
    user: {
        type: Object,
        default: { name: '', email: '', password: '', password_confirmation: '', userMeiter_id: null},
        required: true
    }
})

const form = ref({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
    userMeiter_id: null
})

const errors = ref({})

const emit = defineEmits(['closeModal', 'addRaw', 'updateRaw'])

onMounted(() => {
    form.value = {...props.user}
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
