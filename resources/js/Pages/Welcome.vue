<script setup>
import { Head, Link } from "@inertiajs/vue3";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import DangerButton from "@/Components/DangerButton.vue";
import MyLayout from "@/Layouts/MyLayout.vue";
import Modal from "@/Components/Modal.vue";
import { ref } from "vue";

const modal = ref(false);

const openModal = () => {
    modal.value = true;
};
const closeModal = () => {
    modal.value = false;
};
</script>

<template>

    <Head title="Welcome" />


    <MyLayout>

        <div class="p-4 bg-white rounded-lg flex items-center h-32 shadow-sm">
            <div class="w-3/5 flex justify-start">
                <ul>
                    <li class="font-bold text-gray-400">
                        Today Money
                    </li>
                    <li class="font-extrabold text-slate-800 text-xl">
                        $53000
                    </li>
                    <li>
                        <span class="text-green-400 font-bold">+34</span><span class="text-gray-400">Since
                            Yesterday</span>
                    </li>
                    <li></li>
                </ul>
            </div>

            <div class="w-2/5 flex justify-end">
                <div class="bg-rose-500 rounded-full p-2">
                    SVG
                </div>
            </div>
        </div>

        <div class="p-4 bg-white rounded-lg flex items-center h-32 shadow-sm">
            <div class="w-3/5 flex justify-start">
                <ul>
                    <li class="font-bold text-gray-400">
                        Today Money
                    </li>
                    <li class="font-extrabold text-slate-800 text-xl">
                        $53000
                    </li>
                    <li>
                        <span class="text-green-400 font-bold">+34</span><span class="text-gray-400">Since
                            Yesterday</span>
                    </li>
                    <li></li>
                </ul>
            </div>

            <div class="w-2/5 flex justify-end">
                <div class="bg-gray-800 rounded-full p-2">
                    SVG
                </div>
            </div>
        </div>
        <div class="p-4 bg-white rounded-lg flex items-center h-32 shadow-sm">
            <div class="w-3/5 flex justify-start">
                <ul>
                    <li class="font-bold text-gray-400">
                        Today Money
                    </li>
                    <li class="font-extrabold text-slate-800 text-xl">
                        $53000
                    </li>
                    <li>
                        <span class="text-green-400 font-bold">+34</span><span class="text-gray-400">Since
                            Yesterday</span>
                    </li>
                    <li></li>
                </ul>
            </div>

            <div class="w-2/5 flex justify-end">
                <div class="bg-purple-500 rounded-full p-2">
                    SVG
                </div>
            </div>
        </div>
        <div class="p-4 bg-white rounded-lg flex items-center h-32 shadow-sm">
            <div class="w-3/5 flex justify-start">
                <ul>
                    <li class="font-bold text-gray-400">
                        Today Money
                    </li>
                    <li class="font-extrabold text-slate-800 text-xl">
                        $53000
                    </li>
                    <li>
                        <span class="text-green-400 font-bold">+34</span><span class="text-gray-400">Since
                            Yesterday</span>
                    </li>
                    <li></li>
                </ul>
            </div>

            <div class="w-2/5 flex justify-end">
                <div class="bg-green-500 rounded-full p-2">
                    SVG
                </div>
            </div>
        </div>

        <div class="p-4 bg-white rounded-lg shadow-sm lg:col-span-3">
            <div class="rounded-s-lg">
                <div class="flex-1 bg-gray-50">Bar Chart</div>
                <PrimaryButton @click="openModal">Button</PrimaryButton>
                <DangerButton>Button</DangerButton>

                <Modal :show="modal" @close="modal = false" maxWidth="lg">
                    <div id="modal"
                        >
                        <div class=" p-6  transform scale-95  transition-all duration-300"
                            id="modal-content">
                            <h2 class="text-lg font-bold mb-4">Titre de la Modale</h2>
                            <p class="text-gray-600">Ceci est une fenêtre modale avec un effet de flou en arrière-plan.
                            </p>
                            <div class="mt-4 flex justify-end">
                                <button @click="closeModal()"
                                    class="px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-600">
                                    Fermer
                                </button>
                            </div>
                        </div>
                    </div>
                </Modal>
            </div>
        </div>
        <div class="rounded-lg shadow-sm bg-cover bg-slate-700"
            style="background-image: url('https://remeng.rosselcdn.net/sites/default/files/dpistyles_v2/rem_16_9_1124w/2024/12/13/node_670695/14779710/public/2024/12/13/31008691.jpeg?itok=wEkT9cDd1734094812');">
            <div class="text-white items-baseline">
                <h3 class="flex mt-32 pl-5 font-bold uppercase"> W've got you !!</h3>
                <p class="flex items-centre pt-5 pl-5">We help each other to grow together</p>
            </div>
        </div>

        <div class="rounded-lg shadow-sm bg-white md:col-span-2 lg:col-span-4">
            <div class="overflow-x-auto relative sm:rounded-s-lg">
                <table class="w-full text-sm text-left text-gray-500">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                        <tr>
                            <th class="py-3 px-6">Product Name</th>
                            <th class="py-3 px-6">Color</th>
                            <th class="py-3 px-6">Category</th>
                            <th class="py-3 px-6">Price</th>
                            <th class="py-3 px-6">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="bg-white border-b">
                            <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap">Apple Macbook
                                Pro
                                17"</th>
                            <td class="py-6 px-6">Silver</td>
                            <td class="py-6 px-6">LapTop</td>
                            <td class="py-6 px-6">$2990</td>
                            <td class="py-6 px-6">
                                <a href="#" class="font-medium text-blue-600 hover:underline">Edit</a>
                            </td>
                        </tr>
                        <tr class="bg-white border-b">
                            <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap">Apple Macbook
                                Pro
                                17"</th>
                            <td class="py-6 px-6">Silver</td>
                            <td class="py-6 px-6">LapTop</td>
                            <td class="py-6 px-6">$2990</td>
                            <td class="py-6 px-6">
                                <a href="#" class="font-medium text-blue-600 hover:underline">Edit</a>
                            </td>
                        </tr>
                        <tr class="bg-white border-b">
                            <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap">Apple Macbook
                                Pro
                                17"</th>
                            <td class="py-6 px-6">Silver</td>
                            <td class="py-6 px-6">LapTop</td>
                            <td class="py-6 px-6">$2990</td>
                            <td class="py-6 px-6">
                                <a href="#" class="font-medium text-blue-600 hover:underline">Edit</a>
                            </td>
                        </tr>
                        <tr class="bg-white border-b">
                            <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap">Apple Macbook
                                Pro
                                17"</th>
                            <td class="py-6 px-6">Silver</td>
                            <td class="py-6 px-6">LapTop</td>
                            <td class="py-6 px-6">$2990</td>
                            <td class="py-6 px-6">
                                <a href="#" class="font-medium text-blue-600 hover:underline">Edit</a>
                            </td>
                        </tr>
                        <tr class="bg-white border-b">
                            <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap">Apple Macbook
                                Pro
                                17"</th>
                            <td class="py-6 px-6">Silver</td>
                            <td class="py-6 px-6">LapTop</td>
                            <td class="py-6 px-6">$2990</td>
                            <td class="py-6 px-6">
                                <a href="#"
                                    class="font-medium bg-blue-800 py-1 px-2 rounded-md text-white hover:bg-blue-600 transition-all">Edit</a>
                            </td>
                        </tr>
                        <tr class="bg-white border-b">
                            <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap">Apple Macbook
                                Pro
                                17"</th>
                            <td class="py-6 px-6">Silver</td>
                            <td class="py-6 px-6">LapTop</td>
                            <td class="py-6 px-6">$2990</td>
                            <td class="py-6 px-6">
                                <a href="#" class="font-medium text-blue-600 hover:underline">Edit</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>


    </MyLayout>

</template>
