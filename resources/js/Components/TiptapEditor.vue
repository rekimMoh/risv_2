<template>
    <div
        class="border rounded-md bg-gray-100 flex flex-col h-full w-full relative"
    >
        <!-- Hidden File Input -->
        <input
            type="file"
            ref="fileInput"
            @change="handleImageUpload"
            accept="image/*"
            class="hidden"
        />

        <!-- Bubble Menu for Image -->
        <bubble-menu
            :editor="editor"
            :tippy-options="{ duration: 100 }"
            v-if="editor"
        >
            <div
                v-if="editor.isActive('customImage')"
                class="bg-white border shadow-lg rounded-lg p-1 flex gap-1 items-center z-50"
            >
                <!-- Alignment -->
                <button
                    @click.prevent="
                        editor
                            .chain()
                            .focus()
                            .updateAttributes('customImage', { align: 'left' })
                            .run()
                    "
                    :class="{
                        'bg-gray-100': editor.isActive('customImage', {
                            align: 'left',
                        }),
                    }"
                    class="p-1 px-2 hover:bg-gray-50 rounded text-sm text-gray-700"
                    title="Aligner à gauche"
                >
                    <i class="fas fa-align-left"></i>
                </button>
                <button
                    @click.prevent="
                        editor
                            .chain()
                            .focus()
                            .updateAttributes('customImage', {
                                align: 'center',
                            })
                            .run()
                    "
                    :class="{
                        'bg-gray-100': editor.isActive('customImage', {
                            align: 'center',
                        }),
                    }"
                    class="p-1 px-2 hover:bg-gray-50 rounded text-sm text-gray-700"
                    title="Centrer"
                >
                    <i class="fas fa-align-center"></i>
                </button>
                <button
                    @click.prevent="
                        editor
                            .chain()
                            .focus()
                            .updateAttributes('customImage', { align: 'right' })
                            .run()
                    "
                    :class="{
                        'bg-gray-100': editor.isActive('customImage', {
                            align: 'right',
                        }),
                    }"
                    class="p-1 px-2 hover:bg-gray-50 rounded text-sm text-gray-700"
                    title="Aligner à droite"
                >
                    <i class="fas fa-align-right"></i>
                </button>

                <div class="w-px h-4 bg-gray-300 mx-1"></div>

                <!-- Resize -->
                <button
                    @click.prevent="
                        editor
                            .chain()
                            .focus()
                            .updateAttributes('customImage', { width: '25%' })
                            .run()
                    "
                    :class="{
                        'bg-gray-100': editor.isActive('customImage', {
                            width: '25%',
                        }),
                    }"
                    class="p-1 px-2 hover:bg-gray-50 rounded text-xs font-medium text-gray-700"
                >
                    25%
                </button>
                <button
                    @click.prevent="
                        editor
                            .chain()
                            .focus()
                            .updateAttributes('customImage', { width: '50%' })
                            .run()
                    "
                    :class="{
                        'bg-gray-100': editor.isActive('customImage', {
                            width: '50%',
                        }),
                    }"
                    class="p-1 px-2 hover:bg-gray-50 rounded text-xs font-medium text-gray-700"
                >
                    50%
                </button>
                <button
                    @click.prevent="
                        editor
                            .chain()
                            .focus()
                            .updateAttributes('customImage', { width: '75%' })
                            .run()
                    "
                    :class="{
                        'bg-gray-100': editor.isActive('customImage', {
                            width: '75%',
                        }),
                    }"
                    class="p-1 px-2 hover:bg-gray-50 rounded text-xs font-medium text-gray-700"
                >
                    75%
                </button>
                <button
                    @click.prevent="
                        editor
                            .chain()
                            .focus()
                            .updateAttributes('customImage', { width: '100%' })
                            .run()
                    "
                    :class="{
                        'bg-gray-100': editor.isActive('customImage', {
                            width: '100%',
                        }),
                    }"
                    class="p-1 px-2 hover:bg-gray-50 rounded text-xs font-medium text-gray-700"
                >
                    100%
                </button>
            </div>
        </bubble-menu>

        <!-- Toolbar -->
        <div
            v-if="editor"
            class="bg-white border-b p-2 flex flex-wrap gap-1 sticky top-0 z-10 shadow-sm items-center"
        >
            <!-- Font Size -->
            <select
                @change="
                    editor
                        .chain()
                        .focus()
                        .setFontSize($event.target.value)
                        .run()
                "
                class="p-1 px-2 rounded hover:bg-gray-100 transition-colors text-sm border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 h-8"
                title="Taille de police"
            >
                <option value="" selected disabled>Taille</option>
                <option
                    v-for="size in fontSizes"
                    :key="size"
                    :value="size + 'px'"
                    :selected="
                        editor.isActive('textStyle', { fontSize: size + 'px' })
                    "
                >
                    {{ size }}px
                </option>
            </select>

            <div class="w-px h-5 bg-gray-300 mx-1"></div>

            <!-- Text Formatting -->
            <button
                @click.prevent="editor.chain().focus().toggleItalic().run()"
                :class="{ 'bg-gray-200': editor.isActive('italic') }"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm"
                title="Italique"
            >
                <i class="fas fa-italic"></i>
            </button>
            <button
                @click.prevent="editor.chain().focus().toggleStrike().run()"
                :class="{ 'bg-gray-200': editor.isActive('strike') }"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm"
                title="Barré"
            >
                <i class="fas fa-strikethrough"></i>
            </button>
            <button
                @click.prevent="editor.chain().focus().toggleCode().run()"
                :class="{ 'bg-gray-200': editor.isActive('code') }"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm"
                title="Code"
            >
                <i class="fas fa-code"></i>
            </button>
            <button
                @click.prevent="
                    editor.chain().focus().unsetAllMarks().unsetFontSize().run()
                "
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm"
                title="Effacer le formatage"
            >
                <i class="fas fa-remove-format"></i>
            </button>

            <div class="w-px h-5 bg-gray-300 mx-1"></div>

            <!-- Alignment -->
            <button
                @click.prevent="
                    editor.chain().focus().setTextAlign('left').run()
                "
                :class="{
                    'bg-gray-200': editor.isActive({ textAlign: 'left' }),
                }"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm"
                title="Aligner à gauche"
            >
                <i class="fas fa-align-left"></i>
            </button>
            <button
                @click.prevent="
                    editor.chain().focus().setTextAlign('center').run()
                "
                :class="{
                    'bg-gray-200': editor.isActive({ textAlign: 'center' }),
                }"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm"
                title="Centrer"
            >
                <i class="fas fa-align-center"></i>
            </button>
            <button
                @click.prevent="
                    editor.chain().focus().setTextAlign('right').run()
                "
                :class="{
                    'bg-gray-200': editor.isActive({ textAlign: 'right' }),
                }"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm"
                title="Aligner à droite"
            >
                <i class="fas fa-align-right"></i>
            </button>
            <button
                @click.prevent="
                    editor.chain().focus().setTextAlign('justify').run()
                "
                :class="{
                    'bg-gray-200': editor.isActive({ textAlign: 'justify' }),
                }"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm"
                title="Justifier"
            >
                <i class="fas fa-align-justify"></i>
            </button>

            <div class="w-px h-5 bg-gray-300 mx-1"></div>

            <!-- Headings -->
            <button
                @click.prevent="
                    editor.chain().focus().toggleHeading({ level: 1 }).run()
                "
                :class="{
                    'bg-gray-200': editor.isActive('heading', { level: 1 }),
                }"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm font-bold"
                title="Titre 1"
            >
                H1
            </button>
            <button
                @click.prevent="
                    editor.chain().focus().toggleHeading({ level: 2 }).run()
                "
                :class="{
                    'bg-gray-200': editor.isActive('heading', { level: 2 }),
                }"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm font-bold"
                title="Titre 2"
            >
                H2
            </button>
            <button
                @click.prevent="
                    editor.chain().focus().toggleHeading({ level: 3 }).run()
                "
                :class="{
                    'bg-gray-200': editor.isActive('heading', { level: 3 }),
                }"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm font-bold"
                title="Titre 3"
            >
                H3
            </button>

            <div class="w-px h-5 bg-gray-300 mx-1"></div>

            <!-- Lists -->
            <button
                @click.prevent="editor.chain().focus().toggleBulletList().run()"
                :class="{ 'bg-gray-200': editor.isActive('bulletList') }"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm"
                title="Liste à puces"
            >
                <i class="fas fa-list-ul"></i>
            </button>
            <button
                @click.prevent="
                    editor.chain().focus().toggleOrderedList().run()
                "
                :class="{ 'bg-gray-200': editor.isActive('orderedList') }"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm"
                title="Liste numérotée"
            >
                <i class="fas fa-list-ol"></i>
            </button>

            <div class="w-px h-5 bg-gray-300 mx-1"></div>

            <!-- Insert -->
            <button
                @click.prevent="triggerImageUpload"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm"
                title="Insérer une image"
            >
                <i class="far fa-image"></i>
            </button>
            <button
                @click.prevent="editor.chain().focus().toggleBlockquote().run()"
                :class="{ 'bg-gray-200': editor.isActive('blockquote') }"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm"
                title="Citation"
            >
                <i class="fas fa-quote-right"></i>
            </button>
            <button
                @click.prevent="editor.chain().focus().toggleCodeBlock().run()"
                :class="{ 'bg-gray-200': editor.isActive('codeBlock') }"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm"
                title="Bloc de code"
            >
                <i class="fas fa-file-code"></i>
            </button>
            <button
                @click.prevent="
                    editor.chain().focus().setHorizontalRule().run()
                "
                class="p-1.5 rounded hover:bg-gray-100 transition-colors text-sm"
                title="Ligne horizontale"
            >
                <i class="fas fa-minus"></i>
            </button>

            <div class="w-px h-5 bg-gray-300 mx-1"></div>

            <!-- History -->
            <button
                @click.prevent="editor.chain().focus().undo().run()"
                :disabled="!editor.can().undo()"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors disabled:opacity-50 text-sm"
                title="Annuler"
            >
                <i class="fas fa-undo"></i>
            </button>
            <button
                @click.prevent="editor.chain().focus().redo().run()"
                :disabled="!editor.can().redo()"
                class="p-1.5 rounded hover:bg-gray-100 transition-colors disabled:opacity-50 text-sm"
                title="Rétablir"
            >
                <i class="fas fa-redo"></i>
            </button>
        </div>

        <!-- Editor Content (A4 centered) -->
        <div
            class="overflow-auto p-4 md:p-8 flex-1 bg-gray-200 flex justify-center w-full relative"
        >
            <div
                class="bg-white shadow-xl min-h-[29.7cm] w-[21cm] p-[2.5cm] shrink-0 transform scale-100 origin-top"
            >
                <editor-content :editor="editor" class="h-full" />
            </div>
        </div>
    </div>
</template>

<script setup>
import { useEditor, EditorContent } from "@tiptap/vue-3";
import { BubbleMenu } from "@tiptap/vue-3/menus";
import StarterKit from "@tiptap/starter-kit";
import TextAlign from "@tiptap/extension-text-align";
import CustomImage from "@/Extensions/CustomImage";
import { TextStyle } from "@tiptap/extension-text-style";
import { FontSize } from "@/Extensions/FontSize";
import { watch, onBeforeUnmount, ref } from "vue";
import axios from "axios";

const props = defineProps({
    modelValue: {
        type: String,
        default: "",
    },
    readonly: {
        type: Boolean,
        default: false,
    },
});

const emit = defineEmits(["update:modelValue"]);
const fileInput = ref(null);
const fontSizes = [12, 14, 16, 18, 20, 24, 30, 36, 48];

const editor = useEditor({
    content: props.modelValue,
    editable: !props.readonly,
    extensions: [
        StarterKit,
        TextAlign.configure({
            types: ["heading", "paragraph"],
        }),
        CustomImage,
        TextStyle,
        FontSize,
    ],
    editorProps: {
        attributes: {
            class: "prose prose-sm sm:prose lg:prose-lg focus:outline-none w-full h-full text-black",
        },
    },
    onUpdate: ({ editor }) => {
        emit("update:modelValue", editor.getHTML());
    },
});

watch(
    () => props.modelValue,
    (newValue) => {
        // Only update content if it's different to avoid cursor jumps
        if (editor.value && newValue !== editor.value.getHTML()) {
            editor.value.commands.setContent(newValue);
        }
    }
);

watch(
    () => props.readonly,
    (newVal) => {
        editor.value?.setEditable(!newVal);
    }
);

onBeforeUnmount(() => {
    editor.value?.destroy();
});

const triggerImageUpload = () => {
    fileInput.value.click();
};

const handleImageUpload = (event) => {
    const file = event.target.files[0];
    if (!file) return;

    const formData = new FormData();
    formData.append("file", file);

    axios
        .post(route("upload"), formData, {
            headers: {
                "Content-Type": "multipart/form-data",
            },
        })
        .then((response) => {
            if (response.data.url) {
                editor.value
                    .chain()
                    .focus()
                    .setImage({ src: response.data.url })
                    .run();
            }
        })
        .catch((error) => {
            console.error("Upload failed:", error);
            alert("Erreur lors de l'upload de l'image");
        })
        .finally(() => {
            // Reset input
            event.target.value = "";
        });
};
</script>

<style>
/* Tiptap specific styling overrides */
.ProseMirror {
    outline: none !important;
    min-height: 100%;
}
.ProseMirror p.is-editor-empty:first-child::before {
    content: attr(data-placeholder);
    float: left;
    color: #adb5bd;
    pointer-events: none;
    height: 0;
}
/* Removed global img centering to allow CustomImage alignment to work */
.ProseMirror img {
    max-width: 100%;
    height: auto;
}
</style>
