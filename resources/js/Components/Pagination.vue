<template>
    <!-- <ScreenSize /> -->
    <div v-if="links.length > 0" class="flex justify-between">
        <div>
           {{ from }} a {{ to }} sur {{ total }}
        </div>
        <div class="flex flex-wrap -mb-1">
            <template v-for="(link, p) in links" :key="p">
                <div v-if="link.url === null" class="mr-1 mb-1 px-2.5 py-2 text-gray-400 text-sm" v-html="link.label">

                </div>

                <Link v-else :href="link.url"
                class=" mr-0.5 mb-1  min-w-9">
                    <div class="mb-1 px-2.5 py-2  text-sm shadow rounded-full hover:bg-blue-500 hover:text-white text-center"
                    v-html="link.label" :class="link.active ? 'bg-blue-400 text-white' : 'text-gray-400 bg-white'">
                </div></Link>
                
            </template>
        </div>

    </div>
</template>

<script setup>
import { computed, } from "vue";
import {Link} from "@inertiajs/vue3"

const props = defineProps({
    links: {
        type: Object,
        required: true,
    },
    from : {
        type: Number,
        required: true,
    },
    to : {
        type: Number,
        required: true,
    },
    total : {
        type: Number,
        required: true,
    }
});



</script>
