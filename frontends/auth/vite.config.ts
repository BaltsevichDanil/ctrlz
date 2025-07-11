import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react-swc'
import tailwindcss from '@tailwindcss/vite'
import path from 'path'
import federation from '@originjs/vite-plugin-federation'

// https://vite.dev/config/
export default defineConfig({
  base: '/auth/',
  plugins: [react(), tailwindcss(), federation({
    name: 'auth',
    filename: 'remoteEntry.js',
    exposes: {
      './Signin': './src/features/Signin/Signin.tsx',
    },
    shared: ['react', 'react-dom'],
  })],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
  server: {
    port: 5174,
  },
  build: {
    target: 'esnext',
    minify: false,
    cssCodeSplit: false,
  },
})
