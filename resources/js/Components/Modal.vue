<script setup>
import { computed, onMounted, onUnmounted, ref, watch } from "vue";

const props = defineProps({
    show: {
        type: Boolean,
        default: false,
    },
    maxWidth: {
        type: String,
        default: "2xl",
    },
    closeable: {
        type: Boolean,
        default: true,
    },
});

const emit = defineEmits(["close"]);
const dialog = ref();
const showSlot = ref(props.show);

watch(
    () => props.show,
    () => {
        if (props.show) {
            document.body.style.overflow = "hidden";
            showSlot.value = true;

            dialog.value?.showModal();
        } else {
            document.body.style.overflow = "";

            setTimeout(() => {
                dialog.value?.close();
                showSlot.value = false;
            }, 200);
        }
    }
);

const close = () => {
    if (props.closeable) {
        emit("close");
    }
};

const closeOnEscape = (e) => {
    if (e.key === "Escape") {
        e.preventDefault();

        if (props.show) {
            close();
        }
    }
};

onMounted(() => document.addEventListener("keydown", closeOnEscape));

onUnmounted(() => {
    document.removeEventListener("keydown", closeOnEscape);

    document.body.style.overflow = "";
});
</script>

<template>
    <dialog class="modal" ref="dialog">
        <div
            class="modal-box w-11/12 max-w-5xl p-0 overflow-hidden bg-white shadow-xl rounded-box"
        >
            <form method="dialog">
                <button
                    v-if="closeable"
                    class="btn btn-sm btn-circle btn-ghost absolute right-2 top-2 z-10 text-gray-500 hover:bg-gray-100"
                    @click="close"
                >
                    ✕
                </button>
            </form>

            <div class="max-h-[calc(100vh-5em)] overflow-y-auto">
                <slot v-if="showSlot" />
            </div>
        </div>
        <form method="dialog" class="modal-backdrop">
            <button v-if="closeable" @click="close">close</button>
        </form>
    </dialog>
</template>
