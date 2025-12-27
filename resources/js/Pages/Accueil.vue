<script setup>
import { ref } from "vue";
import { Head, useForm } from "@inertiajs/vue3";

import MyLayout from "@/Layouts/MyLayout.vue";
import InformationPatient from "@/Components/Wizard/InformationPatient.vue";
import ExamenForm from "@/Components/Wizard/ExamenForm.vue";
import ResumeExamens from "@/Components/Wizard/ResumeExamens.vue";

const currentStep = ref(1);

// Global Form State
const patientData = ref({
    nomP: "",
    prenomP: "",
    naisP: "",
    sexeP: "H",
    telP1: "",
    wilaya_id: "",
    antecedents: [],
});

const examsList = ref([]);

// Setup Inertia Form for final submission
const form = useForm({
    patient: {},
    examens: [],
    paiment: {},
});

const nextStep = () => {
    currentStep.value++;
};

const prevStep = () => {
    currentStep.value--;
};

const handleSubmit = (summaryData) => {
    // summaryData contains { patient, examens, paiement } from ResumeExamens
    // We map it to the structure required by the Controller

    // Prepare Patient Payload (matches patientData)
    form.patient = summaryData.patient;

    // Prepare Examens Payload
    // Add missing fields for PaiementController loop
    form.examens = summaryData.examens.map((exam) => ({
        ...exam,
        radiologue: exam.radiologue_id, // Controller expects 'radiologue' (ExamenController line 35: $exam['radiologue'])
        service: exam.service_id, // Controller expects 'service'
        etude: exam.etude_id, // Controller expects 'etude'
        produit: exam.produit_id, // Controller expects 'produit'
        // tarif, remise are already there
        calcRemise: 0,
        typeRemise: "m", // default to montant
    }));

    // Prepare Paiement Payload (for CaisseController::store)
    // Structure: net, tva, ttc, verse, reset
    const p = summaryData.paiement;
    form.paiment = {
        net: p.total - p.remise, // Montant Base
        tva: p.tva,
        ttc: p.ttc,
        verse: 0, // Assuming 0 payment for request
        reset: p.ttc, // Remaining to pay
    };

    form.post("/examen", {
        onSuccess: () => {
            // Reset Wizard
            currentStep.value = 1;
            patientData.value = {
                nomP: "",
                prenomP: "",
                naisP: "",
                sexeP: "H",
                telP1: "",
                wilaya_id: "",
                antecedents: [],
            };
            examsList.value = [];

            // Maybe show a success message (Inertia usually handles flash messages)
            // But we can alert locally or let the UI update.
            alert("Demande validée avec succès !");
        },
        onError: (errors) => {
            console.error(errors);
            alert("Une erreur est survenue lors de la validation.");
        },
    });
};
</script>

<template>
    <Head title="Formulaire d’inscription" />

    <MyLayout>
        <div
            class="bg-white overflow-hidden shadow-sm sm:rounded-lg w-full col-span-4"
        >
            <div class="py-12">
                <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <!-- Wizard Steps -->
                    <div class="flex justify-center mb-8">
                        <ul
                            class="steps steps-vertical lg:steps-horizontal w-full max-w-3xl"
                        >
                            <li
                                class="step"
                                :class="{ 'step-primary': currentStep >= 1 }"
                            >
                                Informations Patient
                            </li>
                            <li
                                class="step"
                                :class="{ 'step-primary': currentStep >= 2 }"
                            >
                                Examen
                            </li>
                            <li
                                class="step"
                                :class="{ 'step-primary': currentStep >= 3 }"
                            >
                                Résumé
                            </li>
                        </ul>
                    </div>

                    <!-- Step Content -->
                    <div class="transition-all duration-300">
                        <!-- Step 1 -->
                        <div v-show="currentStep === 1">
                            <InformationPatient
                                v-model="patientData"
                                @next="nextStep"
                            />
                        </div>

                        <!-- Step 2 -->
                        <div v-show="currentStep === 2">
                            <ExamenForm
                                v-model="examsList"
                                @prev="prevStep"
                                @next="nextStep"
                            />
                        </div>

                        <!-- Step 3 -->
                        <div v-show="currentStep === 3">
                            <ResumeExamens
                                :patient="patientData"
                                :exams="examsList"
                                @prev="prevStep"
                                @submit="handleSubmit"
                            />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </MyLayout>
</template>
