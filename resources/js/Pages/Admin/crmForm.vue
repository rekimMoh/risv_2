<template>
    <div class="h-full flex flex-col bg-white">
        <div class="p-6 border-b border-gray-200">
            <h2 class="text-xl font-semibold text-gray-900">
                {{
                    form.id
                        ? "Modifier le modèle"
                        : "Ajouter un modèle de compte rendu"
                }}
            </h2>
        </div>

        <form
            @submit.prevent="submit"
            class="flex-1 flex flex-col overflow-hidden"
        >
            <div class="p-6 overflow-y-auto flex-1">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
                    <div>
                        <label
                            class="block text-gray-700 text-sm font-bold mb-2"
                            >Titre du compte rendu</label
                        >
                        <input
                            v-model="form.titreCRM"
                            type="text"
                            class="input input-bordered w-full"
                            required
                        />
                        <div
                            v-if="form.errors.titreCRM"
                            class="text-red-500 text-xs mt-1"
                        >
                            {{ form.errors.titreCRM }}
                        </div>
                    </div>

                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label
                                class="block text-gray-700 text-sm font-bold mb-2"
                                >Service</label
                            >
                            <select
                                v-model="form.service_id"
                                class="select select-bordered w-full"
                                required
                            >
                                <option value="">Choisir...</option>
                                <option
                                    v-for="service in services"
                                    :key="service.IDService"
                                    :value="service.IDService"
                                >
                                    {{ service.libelleService }}
                                </option>
                            </select>
                        </div>
                        <div>
                            <label
                                class="block text-gray-700 text-sm font-bold mb-2"
                                >Étude</label
                            >
                            <select
                                v-model="form.etude_id"
                                class="select select-bordered w-full"
                                :disabled="!form.service_id"
                                required
                            >
                                <option value="">Choisir...</option>
                                <option
                                    v-for="etude in filteredEtudes"
                                    :key="etude.IDEtude"
                                    :value="etude.IDEtude"
                                >
                                    {{ etude.libelleEtude }}
                                </option>
                            </select>
                            <div
                                v-if="form.errors.etude_id"
                                class="text-red-500 text-xs mt-1"
                            >
                                {{ form.errors.etude_id }}
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mb-4 h-full flex flex-col">
                    <label class="block text-gray-700 text-sm font-bold mb-2"
                        >Contenu du compte rendu</label
                    >
                    <div class="flex-1 overflow-hidden">
                        <TiptapEditor v-model="form.contenuCRM" />
                    </div>
                    <div
                        v-if="form.errors.contenuCRM"
                        class="text-red-500 text-xs mt-1"
                    >
                        {{ form.errors.contenuCRM }}
                    </div>
                </div>
            </div>

            <div
                class="p-6 border-t border-gray-200 bg-gray-50 flex justify-end gap-3 shrink-0"
            >
                <button
                    type="button"
                    @click="$emit('close')"
                    class="px-4 py-2 bg-white border border-gray-300 hover:bg-gray-50 text-gray-700 rounded-lg transition-colors shadow-sm font-medium"
                >
                    Annuler
                </button>
                <button
                    type="submit"
                    class="px-4 py-2 bg-emerald-600 hover:bg-emerald-700 text-white rounded-lg transition-colors shadow-sm font-medium flex items-center gap-2"
                    :disabled="form.processing"
                >
                    <i
                        v-if="form.processing"
                        class="fas fa-spinner fa-spin"
                    ></i>
                    Enregistrer
                </button>
            </div>
        </form>
    </div>
</template>

<script setup>
import { computed, watch, onMounted } from "vue";
import { useForm } from "@inertiajs/vue3";
import TiptapEditor from "@/Components/TiptapEditor.vue";

const props = defineProps({
    model: Object,
    services: Array,
    etudes: Array,
});

const emit = defineEmits(["close"]);

const form = useForm({
    id: props.model?.IDCRM ?? null,
    titreCRM: props.model?.titreCRM ?? "",
    contenuCRM: props.model?.contenuCRM ?? "",
    service_id: "",
    etude_id: props.model?.etude_id ?? "",
});

const filteredEtudes = computed(() => {
    if (!form.service_id) return [];
    return props.etudes.filter((e) => e.service_id == form.service_id);
});

const initForm = () => {
    if (props.model) {
        form.id = props.model.IDCRM;
        form.titreCRM = props.model.titreCRM;
        form.contenuCRM = props.model.contenuCRM;
        form.etude_id = props.model.etude_id;

        const etude = props.etudes.find(
            (e) => e.IDEtude == props.model.etude_id
        );
        if (etude) form.service_id = etude.service_id;
    } else {
        form.reset();
        form.id = null;
        form.service_id = "";
    }
};

onMounted(() => {
    initForm();
});

watch(
    () => props.model,
    () => {
        initForm();
    },
    { deep: true }
);

const submit = () => {
    if (form.id) {
        form.put(route("crm.update", form.id), {
            preserveScroll: true,
            only: ["models"],
            onSuccess: () => {
                emit("close");
                form.reset();
            },
        });
    } else {
        form.post(route("crm.store"), {
            preserveScroll: true,
            only: ["models"],
            onSuccess: () => {
                emit("close");
                form.reset();
            },
        });
    }
};
</script>
