<template>
    <div
        v-if="!store.compactDrawer"
        @click="store.displayDrawer()"
        class="fixed inset-0 bg-black bg-opacity-50 z-10 md:hidden"
    ></div>
    <div
    :class="[
            'z-20 flex-shrink-0 min-h-screen transition-all duration-300 bg-slate-800',
            'fixed md:relative',
            store.compactDrawer ? '-left-64 md:left-0 w-16' : 'left-0 w-64',
            'md:block',
            'flex flex-col' // Ajout pour la structure flex
        ]"
    >

        <!-- Navigation -->
        <nav class="p-4">
            <div
                v-for="(section, index) in menus"
                :key="index"
                class="mb-4"
            >
                <div v-if="section.items">
                    <div
                        @click="toggleSection(index)"
                        class="flex justify-between items-center px-4 py-2 text-gray-400 hover:text-white hover:bg-slate-700 rounded-md transition-colors duration-200"
                    >
                        <span>
                            <i :class="[
                                        section.icon,
                                        store.compactDrawer ? '' : 'mr-3',
                                    ]"></i> <span  v-if="!store.compactDrawer">{{ section.nomUrl }}</span></span>
                        <i
                            class="fas fa-chevron-down transition-transform"
                            :class="[
                                { 'transform rotate-180': openSections[index] },
                                { 'hidden': store.compactDrawer },
                            ]"
                        ></i>
                    </div>

                    <Transition
                        enter-active-class="transition duration-100 ease-out"
                        enter-from-class="transform scale-95 opacity-0"
                        enter-to-class="transform scale-100 opacity-100"
                        leave-active-class="transition duration-75 ease-in"
                        leave-from-class="transform scale-100 opacity-100"
                        leave-to-class="transform scale-95 opacity-0"
                    >
                        <div
                            v-if="
                                openSections[index]
                            "
                            class="mt-2 space-y-2"
                        >
                            <Link
                                v-for="(item, itemIndex) in section.items"
                                :key="itemIndex"
                                :href="item.root"
                                :title="item.nomUrl"
                                class="flex items-center px-4 py-2 text-gray-400 hover:text-white hover:bg-slate-700 rounded-md transition-colors duration-200"
                                :class="{ 'justify-center': store.compactDrawer }"
                            >
                                <i
                                    :class="[
                                        item.icon,
                                        store.compactDrawer ? '' : 'mr-3',
                                    ]"
                                ></i>
                                <span v-if="!store.compactDrawer">{{ item.nomUrl }}</span>
                            </Link>
                        </div>
                    </Transition>
                </div>
                <div v-else>
                    <Link
                                :href="section.root"
                                :title="section.nomUrl"
                                class="flex items-center px-4 py-2 text-gray-400 hover:text-white hover:bg-slate-700 rounded-md transition-colors duration-200"
                                :class="{ 'justify-center': store.compactDrawer }"
                            >
                                <i
                                    :class="[
                                        section.icon,
                                        store.compactDrawer ? '' : 'mr-3',
                                    ]"
                                ></i>
                                <span v-if="!store.compactDrawer">{{ section.nomUrl }}</span>
                            </Link>
                </div>
            </div>
        </nav>
    </div>
</template>

<script setup>
import { ref, onUnmounted, watch ,onMounted} from "vue";
import {useStore} from '@/Store/Store'
import "@fortawesome/fontawesome-free/css/all.min.css";
import { Link } from '@inertiajs/vue3'

const menus = ref([])

const openSections = ref(Array(menus.length).fill(false));
const store = useStore()
//const isCompact = ref(false);

const toggleSection = (index) => {
    openSections.value[index] = !openSections.value[index];
};
// Ajouter la gestion du défilement du body
watch(() => store.compactDrawer, (newValue) => {
    if (!newValue) {
        // Drawer ouvert - désactiver le défilement du body en mobile
        document.body.style.overflow = window.innerWidth < 768 ? 'hidden' : 'auto'
    } else {
        // Drawer fermé - réactiver le défilement du body
        document.body.style.overflow = 'auto'
    }
})



onMounted(() => {
if(localStorage.getItem('menus') == null){
    axios.get('/init')
    .then(response => {
        localStorage.setItem('menus', JSON.stringify(response.data.route))
        menus.value = response.data.route.filter(item => item.parent == null)
        response.data.route.forEach(item => {
            if(item.parent != null){
                menus.value.forEach(parent => {
                    if(parent.IDLien == item.parent){
                        if(!parent.hasOwnProperty('items')){
                            parent.items = []
                        }
                        parent.items.push(item)
                    }
                })
            }
        })
    })
    .catch(error => {
        console.log(error)
    })
}else{
    let mm = JSON.parse(localStorage.getItem('menus'))
    menus.value = mm.filter(item => item.parent == null)
        mm.forEach(item => {
            if(item.parent != null){
                menus.value.forEach(parent => {
                    if(parent.IDLien == item.parent){
                        if(!parent.hasOwnProperty('items')){
                            parent.items = []
                        }
                        parent.items.push(item)
                    }
                })
            }
        })
}
}),

onUnmounted(() => {
    document.body.style.overflow = 'auto'

   
})
</script>
<style scoped>
/* Optionnel : Style pour la barre de défilement personnalisée */
nav::-webkit-scrollbar {
    width: 4px;
}

nav::-webkit-scrollbar-track {
    background: transparent;
}

nav::-webkit-scrollbar-thumb {
    background: #4B5563;
    border-radius: 2px;
}

nav::-webkit-scrollbar-thumb:hover {
    background: #6B7280;
}
</style>
