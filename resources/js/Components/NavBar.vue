<template>
    <nav class="bg-white shadow-md">
        <div class="mx-auto">
            <div class="flex justify-between py-2 px-4">
                <div
                    class="flex items-center space-x-2 font-bold text-gray-400"
                >
                    <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        class="h-9 w-9 text-slate-600"
                        xmlns="http://www.w3.org/2000/svg"
                    >
                        <path
                            fill-rule="evenodd"
                            clip-rule="evenodd"
                            d="M5.68393 9.10852C4.91598 11.8505 5.24227 15.3057 6.0784 17.9623L4.64759 18.4127C3.75268 15.5693 3.37082 11.8057 4.23951 8.70398C4.67664 7.14317 5.44272 5.70877 6.66305 4.66294C7.89353 3.60841 9.52687 3 11.5948 3C12.7741 3 14.3733 3.31478 16.1632 4.4996L15.3353 5.7504C13.8016 4.73522 12.4928 4.5 11.5948 4.5C9.83865 4.5 8.56461 5.00878 7.63915 5.8019C6.70354 6.60373 6.06512 7.74745 5.68393 9.10852ZM17.6243 10.9248C17.5868 9.24047 17.5585 7.97426 16.6049 7.02479L17.6633 5.96181C19.054 7.34653 19.0902 9.18617 19.1197 10.6847C19.1213 10.7641 19.1228 10.8426 19.1246 10.9199C19.1613 12.568 19.261 13.8481 20.3669 14.8088L19.3831 15.9412C17.7193 14.4957 17.6604 12.5414 17.6249 10.9534L17.6243 10.9248ZM11.5948 7.9375C10.0919 7.9375 8.88269 9.14577 8.88269 10.625H7.38269C7.38269 8.30728 9.27356 6.4375 11.5948 6.4375C13.916 6.4375 15.8069 8.30727 15.8069 10.625C15.8069 11.5439 15.9393 13.0207 16.3327 14.4178C16.7359 15.8495 17.3628 17.017 18.222 17.5502L17.4311 18.8248C16.0746 17.983 15.3166 16.3433 14.8889 14.8244C14.4514 13.271 14.3069 11.654 14.3069 10.625C14.3069 9.14577 13.0977 7.9375 11.5948 7.9375ZM11.269 15.3401C10.8583 13.465 10.7847 11.678 10.846 10.5831L12.3437 10.6669C12.2895 11.6345 12.3544 13.285 12.7343 15.0192C13.116 16.7621 13.7982 18.5085 14.9202 19.7463L13.8088 20.7537C12.4381 19.2415 11.6778 17.2066 11.269 15.3401ZM7.38269 12.0016V12H8.88269C8.88269 12.4489 8.883 13.7749 9.13271 15.3177C9.38505 16.8766 9.87875 18.5672 10.8084 19.7979L9.6115 20.7021C8.46389 19.1828 7.91896 17.2067 7.65199 15.5573C7.38269 13.8936 7.38269 12.471 7.38269 12.0016Z"
                            fill="#475569"
                        />
                    </svg>
                    <span>DashBoard</span>
                    <button
                    class="flex p-1 mr-5 ml-1 rounded-md  focus:outline-none focus:shadow-outline-purple mobile-menu-button"
                    @click="store.displayDrawer()"
                    aria-label="Menu"
                >
                    <svg
                        width="32px"
                        height="32px"
                        viewBox="0 0 24 24"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                    >
                        <path
                            d="M4 6H20M4 12H20M4 18H20"
                            stroke="#000000"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                        />
                    </svg>
                </button>
                </div>


                <Dropdown align="right" width="48">
                    <template #trigger>
                        <span class="inline-flex rounded-md">
                            <button
                                type="button"
                                class="inline-flex items-center rounded-md border border-transparent bg-white px-3 py-2 text-sm font-medium leading-4 text-gray-500 transition duration-150 ease-in-out hover:text-gray-700 focus:outline-none"
                            >
                                {{ $page.props.auth.user.nom }} {{ $page.props.auth.user.prenom }}
                               
                                <svg
                                    class="-me-0.5 ms-2 h-4 w-4"
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 20 20"
                                    fill="currentColor"
                                >
                                    <path
                                        fill-rule="evenodd"
                                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                        clip-rule="evenodd"
                                    />
                                </svg>
                            </button>
                        </span>
                    </template>

                    <template #content>
                        <DropdownLink :href="route('profile.edit')">
                            Profile
                        </DropdownLink>
                        <DropdownLink
                            :href="route('logout')"
                            method="post"
                            as="button"
                        >
                            Log Out
                        </DropdownLink>
                    </template>
                </Dropdown>


            </div>
        </div>
    </nav>
</template>

<script setup>
import Dropdown from "@/Components/Dropdown.vue";
import DropdownLink from '@/Components/DropdownLink.vue';

import { useStore } from "@/Store/Store";
const store = useStore()

</script>

<style></style>
