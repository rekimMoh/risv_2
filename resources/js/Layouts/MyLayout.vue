<template>
      <navBar />
    <!--Side menu-->
    <div class="flex">
        <Drawer />
        <!--Contenet-->
        <div class="bg-slate-200 min-h-screen w-full ">
            <div class="p-8">
                <div
                    class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 lg:gap-8"
                >
                    <slot />


                </div>
                <!--footer-->
                <div class="pt-5 flex justify-center">
                    <p class="text-gray-400">Copyright &copy; 2025 - SSP</p>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>

import Drawer from '@/Components/Drawer.vue'
import NavBar from '@/Components/NavBar.vue'


</script>
