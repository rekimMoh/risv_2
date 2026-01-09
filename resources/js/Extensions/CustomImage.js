import Image from '@tiptap/extension-image';
import { mergeAttributes } from '@tiptap/core';

export default Image.extend({
    name: 'customImage',

    addAttributes() {
        return {
            ...this.parent?.(),
            width: {
                default: '100%',
                renderHTML: attributes => {
                    return {
                        width: attributes.width,
                        style: `width: ${attributes.width}`,
                    };
                },
            },
            align: {
                default: 'center',
                renderHTML: attributes => {
                    let style = '';
                    switch (attributes.align) {
                        case 'left':
                            style = 'float: left; margin-right: 1em; margin-bottom: 0.5em;';
                            break;
                        case 'right':
                            style = 'float: right; margin-left: 1em; margin-bottom: 0.5em;';
                            break;
                        case 'center':
                            style = 'display: block; margin-left: auto; margin-right: auto;';
                            break;
                    }
                    return {
                        style,
                        'data-align': attributes.align, // Keep track of alignment
                    };
                },
            },
        };
    },
});
