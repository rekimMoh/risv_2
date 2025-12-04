<template>
    <div class="container mx-auto p-4">
        <h1 class="text-3xl font-bold mb-4 text-gray-800">
            Formulaire Gestion Utilisateur
        </h1>
        <form @submit.prevent="submit">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <h3
                    class="text-lg font-medium leading-6 text-gray-400 col-span-2"
                >
                    Informations Personnelles
                </h3>
                <div class="space-y-2">
                    <label
                        for="nom"
                        class="block text-sm font-medium text-gray-700"
                        >Nom</label
                    >
                    <input
                        type="text"
                        id="nom"
                        v-model="User.nom"
                        class="input"
                    />
                    <span class="text-red-600 text-sm" v-if="errors.nom">{{
                        errors.nom
                    }}</span>
                </div>
                <div class="space-y-2">
                    <label
                        for="prenom"
                        class="block text-sm font-medium text-gray-700"
                        >Prénom</label
                    >
                    <input
                        type="text"
                        id="prenom"
                        v-model="User.prenom"
                        class="mt-1 input"
                    />
                    <span class="text-red-600 text-sm" v-if="errors.prenom">{{
                        errors.prenom
                    }}</span>
                </div>
                <div class="space-y-2">
                    <label
                        for="email"
                        class="block text-sm font-medium text-gray-700"
                        >Email</label
                    >
                    <input
                        type="email"
                        id="email"
                        v-model="User.email"
                        class="mt-1 input"
                    />
                    <span class="text-red-600 text-sm" v-if="errors.email">{{
                        errors.email
                    }}</span>
                </div>
                <div class="space-y-2">
                    <label
                        for="userMeiter_id"
                        class="block text-sm font-medium text-gray-700"
                        >Profile</label
                    >
                    <select
                        id="userMeiter_id"
                        v-model="User.userMeiter_id"
                        @change="User.signature_medcin = null"
                        class="mt-1 select"
                    >
                        <option
                            v-for="userMeiter in userMeiters"
                            :key="userMeiter.IDUserMetier"
                            :value="userMeiter.IDUserMetier"
                        >
                            {{ userMeiter.typeU }}
                        </option>
                    </select>
                    <span
                        class="text-red-600 text-sm"
                        v-if="errors.userMeiter_id"
                        >{{ errors.userMeiter_id }}</span
                    >
                </div>
                <div class="space-y-2">
                    <label
                        for="password"
                        class="block text-sm font-medium text-gray-700"
                        >Mot de passe</label
                    >
                    <input
                        type="password"
                        id="password"
                        v-model="User.password"
                        class="mt-1 input"
                    />
                    <span class="text-red-600 text-sm" v-if="errors.password">{{
                        errors.password
                    }}</span>
                </div>
                <div class="space-y-2">
                    <label
                        for="password_confirmation"
                        class="block text-sm font-medium text-gray-700"
                        >Confirmation du mot de passe</label
                    >
                    <input
                        type="password"
                        id="password_confirmation"
                        v-model="User.password_confirmation"
                        class="mt-1 input"
                    />
                    <span
                        class="text-red-600 text-sm"
                        v-if="errors.password_confirmation"
                        >{{ errors.password_confirmation }}</span
                    >
                </div>
                <div class="space-y-2" v-if="User.userMeiter_id == 2">
                    <label
                        for="medcins"
                        class="block text-sm font-medium text-gray-700"
                        >Signiature au nom de
                    </label>
                    <select
                        id="medcins"
                        v-model="User.signature_medcin"
                        class="mt-1 input"
                    >
                        <option :value="null"></option>
                        <option
                            v-for="medcin in medcins"
                            :key="medcin.id"
                            :value="medcin.id"
                        >
                            {{ medcin.nom }} {{ medcin.prenom }}
                        </option>
                    </select>
                </div>
            </div>
            <hr class="my-6 color-gray-300" />
            <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
                <h3
                    class="text-lg font-medium leading-6 text-gray-400 col-span-4"
                >
                    gestion des Access
                </h3>
                <div v-for="l in liens" :key="l.IDLien">
                    <div class="">
                        <input
                            type="checkbox"
                            :id="l.IDLien"
                            v-model="lienUser"
                            :value="l.IDLien"
                            :aria-label="l.nomUrl"
                            class="btn checked:bg-blue-500 checked:border-blue-300 checked:text-white cursor-pointer btn-block"
                        />
                    </div>
                </div>
            </div>
            <hr class="my-6 color-gray-300" />

            <div class="gap-6">
                <div
                    class="text-lg font-medium leading-6 text-gray-400 col-span-4"
                >
                    <label for="paieTacheActif">paiement par tâche</label>
                    <input
                        type="checkbox"
                        name=""
                        id="paieTacheActif"
                        v-model="paieTacheActif"
                        :value="
                            User.mode_paiements &&
                            User.mode_paiements.length > 0
                        "
                        :checked="
                            User.mode_paiements &&
                            User.mode_paiements.length > 0
                        "
                        class="ml-4 toggle toggle- toggle-lg"
                    />
                </div>

                <div
                    id="accordion-collapse"
                    class="mt-10 w-full block"
                    data-accordion="collapse"
                    v-if="paieTacheActif"
                >
                    <div
                        v-for="(service, indexService) in modePaiement"
                        :key="service.IDService"
                    >
                        <div
                            id="accordion-collapse-heading-1"
                            class="w-full p-5 font-medium rtl:text-right text-gray-500 border border-b-0 border-gray-200 focus:ring-4 focus:ring-gray-200 gap-3 flex justify-between"
                            :class="[
                                indexService == 0
                                    ? 'rounded-t-xl'
                                    : 'rounded-none',
                                indexService == modePaiement.length - 1
                                    ? 'border-b-2'
                                    : 'rounded-none',
                            ]"
                        >
                            <div class="col-span-3 flex items-center w-4/5">
                                <div class="w-1/5 text-xs">
                                    {{ service.libelleService }} :
                                </div>
                                <div
                                    v-for="shift in service.shifts"
                                    :key="shift.IDShift"
                                    class="w-28 mr-4"
                                >
                                    <input
                                        class="input input-sm"
                                        @input="
                                            setValueEtude(
                                                indexService,
                                                shift.IDShift
                                            )
                                        "
                                        type="number"
                                        :placeholder="shift.libelleShift"
                                        v-model="shift.valueSRV"
                                    />
                                </div>
                                <input
                                    type="checkbox"
                                    v-model="service.pourcentageSRV"
                                    @change="
                                        service.etudes.forEach(
                                            (etude) =>
                                                (etude.pourcentage =
                                                    service.pourcentageSRV)
                                        )
                                    "
                                    class="toggle ml-4 toggle-sm toggle-neutral mr-4"
                                />
                                {{ service.pourcentageSRV ? "%" : "DZD" }}
                            </div>

                            <button
                                type="button"
                                @click="
                                    openAccordion[indexService] =
                                        !openAccordion[indexService]
                                "
                                class="btn btn-ghost btn-sm"
                                data-accordion-target="#accordion-collapse-body-1"
                                aria-expanded="true"
                                aria-controls="accordion-collapse-body-1"
                            >
                                <span>Afficher</span>
                            </button>
                        </div>
                        <div
                            id="accordion-collapse-body-1 "
                            class="border border-t-0 border-gray-200 p-5"
                            :class="
                                openAccordion[indexService] ? 'open' : 'hidden'
                            "
                            aria-labelledby="accordion-collapse-heading-1"
                        >
                            <div
                                v-for="etude in service.etudes"
                                :key="etude.IDEtude"
                                class="mb-4 flex justify-start gap-4"
                            >
                                <div class="w-1/6 text-xs">
                                    {{ etude.libelleEtude }} :
                                </div>
                                <div
                                    v-for="shift in etude.shifts"
                                    :key="shift.IDShift"
                                    class=""
                                >
                                    <input
                                        type="number"
                                        class="input input-sm"
                                        :placeholder="shift.libelleShift"
                                        v-model="shift.value"
                                    />
                                </div>
                                <input
                                    type="checkbox"
                                    v-model="etude.pourcentage"
                                    class="mx-4 toggle toggle-sm toggle-neutral"
                                />
                                {{ etude.pourcentage ? "%" : "DZD" }}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mt-6">
                <button
                    type="submit"
                    class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                >
                    Enregistrer
                </button>
            </div>
        </form>
    </div>
</template>
<script setup>
import { ref, onMounted, defineEmits } from "vue";
import axios from "axios";

const props = defineProps({
    User: {
        type: Object,
        required: true,
    },
    userMeiters: {
        type: Array,
        required: true,
    },
    services: {
        type: Array,
        required: true,
    },
    liens: {
        type: Array,
        required: true,
    },
    medcins: {
        type: Array,
        required: true,
    },
    shifts: {
        type: Array,
        required: true,
    },
});
onMounted(() => {
    console.log(props.User);
    if (props.User.mode_paiements.length > 0) {
        paieTacheActif.value = true;
    } else {
        paieTacheActif.value = false;
    }

    const modePaiementTemp = props.User.mode_paiements;

    props.services.forEach((s) => {
        const service = {
            IDService: s.IDService,
            libelleService: s.libelleService,
            shifts: props.shifts.map((shift) => ({
                IDShift: shift.IDShift,
                libelleShift: shift.libelleShift,
                valueSRV: null,
            })),
            pourcentageSRV: false,
            etudes: s.etudes.map((etude) => ({
                IDEtude: etude.IDEtude,
                libelleEtude: etude.libelleEtude,
                shifts: props.shifts.map((shift) => ({
                    IDShift: shift.IDShift,
                    libelleShift: shift.libelleShift,
                    value: null,
                })),
                pourcentage: false,
            })),
        };
        const modePaiementExiste = modePaiementTemp.filter((mp) => {
            return mp.service_id === s.IDService;
        });
        if (modePaiementExiste.length > 0) {
            service.shifts.forEach((shiftSRV) => {
                const paimentShiftExiste = modePaiementExiste.find(
                    (mp) => mp.shift_id === shiftSRV.IDShift
                );
                if (paimentShiftExiste) {
                    service.pourcentageSRV =
                        paimentShiftExiste.pourcentageSRV === 1;
                    shiftSRV.valueSRV = paimentShiftExiste.valueSRV;
                }
            });

            service.etudes.forEach((etude) => {
                etude.shifts.forEach((shift) => {
                    const paimentShiftExiste = modePaiementExiste.find(
                        (mpE) =>
                            mpE.shift_id === shift.IDShift &&
                            mpE.etude_id === etude.IDEtude
                    );
                    if (paimentShiftExiste) {
                        etude.pourcentage =
                            paimentShiftExiste.pourcentage === 1;
                        shift.value = paimentShiftExiste.value;
                    }
                });
            });
        }

        modePaiement.value.push(service);
    });

    //
});

const modePaiement = ref([]);

const paieTacheActif = ref(null);
const openAccordion = ref([]);
const form = ref({
    id: null,
    nom: "",
    prenom: "",
    email: "",
    password: "",
    password_confirmation: "",
    userMeiter_id: null,
    signature_medcin: null,
});

const setValueEtude = (indexService, IDShift) => {
    modePaiement.value[indexService].etudes.forEach((etude) => {
        etude.shifts.forEach((shift) => {
            if (shift.IDShift === IDShift) {
                shift.value = modePaiement.value[indexService].shifts.find(
                    (s) => s.IDShift === IDShift
                ).valueSRV;
            }
        });
    });
};

const lienUser = ref([]);
if (props.User.lien_users) {
    props.User.lien_users.map((LU) => {
        props.liens.map((l) => {
            if (l.IDLien === LU.lien_id) {
                lienUser.value.push(l.IDLien);
            }
        });
    });
}
const errors = ref({});

const emit = defineEmits(["closeModal", "addRaw", "updateRaw"]);
const indexBtnAccordion = ref([]);

const submit = async () => {
    console.log(props.User);
    try {
        props.User.lien_users = lienUser.value;
        props.User.mode_paiements = modePaiement.value;
        if (props.User.id) {
            await axios
                .put(`/users/${props.User.id}`, props.User)
                .then((response) => {
                    emit("updateRaw", response.data);
                    console.log(response.data);
                })
                .catch((error) => {
                    console.log(error);
                });
            //emit('updateRaw', props.User)
        } else {
            const response = await axios
                .post(`/users`, props.User)
                .then((response) => {
                    emit("addRaw", response.data);
                    console.log(response.data);
                })
                .catch((error) => {
                    console.log(error);
                });
            //emit('addRaw', response.data)
        }
        emit("closeModal");
    } catch (error) {
        console.log(error);
    }
};
</script>
