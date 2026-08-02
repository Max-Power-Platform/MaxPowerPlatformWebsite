import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  build: {
    target: 'es2015',
    cssCodeSplit: false,
    lib: {
      entry: 'src/main.tsx',
      name: 'MPPOperatingSystem',
      fileName: () => 'mpp-os.js',
      formats: ['iife'],
    },
    rollupOptions: {
      output: {
        assetFileNames: (assetInfo) => {
          if (assetInfo.name === 'style.css') return 'mpp-os.css'
          return assetInfo.name || '[name][extname]'
        },
      },
    },
  },
})
