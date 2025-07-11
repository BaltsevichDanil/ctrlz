import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react-swc'
import tailwindcss from '@tailwindcss/vite'
import path from 'path'
import federation from '@originjs/vite-plugin-federation'

const getRemoteUrl = (microfrontend: string) => {
  const ports: Record<string, number> = {
    auth: 5174,
    host: 5173
  }
  
  // В production используем относительные пути через API Gateway
  if (process.env.NODE_ENV === 'production') {
    return `/${microfrontend}/assets/remoteEntry.js`
  }
  
  return `http://localhost:${ports[microfrontend]}/assets/remoteEntry.js`
}

// https://vite.dev/config/
export default defineConfig({
  base: '/',
  plugins: [
    react(), 
    tailwindcss(),
    federation({
      name: 'host',
      remotes: {
        auth: getRemoteUrl('auth'),
      },
      shared: ['react', 'react-dom'],
    }),
  ],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
  server: {
    port: 5173,
    cors: true,
  },
  build: {
    target: 'esnext',
    minify: false,
    cssCodeSplit: false,
  },
})
