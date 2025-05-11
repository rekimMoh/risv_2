import defaultTheme from 'tailwindcss/defaultTheme';
import forms from '@tailwindcss/forms';

/** @type {import('tailwindcss').Config} */
export default {
    content: [
        './vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php',
        './storage/framework/views/*.php',
        './resources/views/**/*.blade.php',
        './resources/js/**/*.vue',
        './resources/**/*.js',
    ],

    theme: {
        extend: {
            fontFamily: {
                sans: ['Figtree', ...defaultTheme.fontFamily.sans],
            },
             minHeight: {
                'screen-minus-10': 'calc(100vh - 10rem)',
              },
        },
    },

    //plugins: [forms],
    plugins: [require('daisyui')],
    daisyui: {
        themes: [
          'light',
          'dark',
          {
            ssp: {}, // On le déclare vide car les variables sont en CSS
          },
        ]
      }

};
