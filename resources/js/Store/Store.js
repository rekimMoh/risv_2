import { defineStore } from "pinia";

export const useStore = defineStore("store", {
    state: () => ({
        compactDrawer: false,
    }),
    getters: {

    },
    actions: {
        displayDrawer(){
            this.compactDrawer = !this.compactDrawer
        }
        },
});