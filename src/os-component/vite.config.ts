import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  define: {
    'process.env.NODE_ENV': JSON.stringify('production'),
  },
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
        banner: 'var process={env:{NODE_ENV:"production"}};window.process=process;',
        assetFileNames: (assetInfo) => {
          if (assetInfo.name === 'style.css') return 'mpp-os.css'
          return assetInfo.name || '[name][extname]'
        },
      },
    },
  },
})
