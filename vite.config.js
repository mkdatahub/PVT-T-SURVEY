import { defineConfig } from 'vite';
import { resolve } from 'path';

export default defineConfig({
  server: {
    port: 3000,
    host: '0.0.0.0',
  },
  plugins: [
    {
      name: 'html-rewrite-middleware',
      configureServer(server) {
        server.middlewares.use((req, res, next) => {
          const url = req.url ? req.url.split('?')[0] : '';
          const query = req.url && req.url.includes('?') ? req.url.slice(req.url.indexOf('?')) : '';
          
          const routes = {
            '/login': '/index.html',
            '/admin-login': '/admin-login.html',
            '/sales': '/sales.html',
            '/admin': '/admin.html',
            '/survey': '/survey.html',
            '/public-survey': '/public-survey.html',
          };

          if (routes[url]) {
            req.url = routes[url] + query;
          }
          next();
        });
      },
    },
  ],
  build: {
    rollupOptions: {
      input: {
        main: resolve(__dirname, 'index.html'),
        adminLogin: resolve(__dirname, 'admin-login.html'),
        admin: resolve(__dirname, 'admin.html'),
        sales: resolve(__dirname, 'sales.html'),
        survey: resolve(__dirname, 'survey.html'),
        publicSurvey: resolve(__dirname, 'public-survey.html'),
      },
    },
  },
});

