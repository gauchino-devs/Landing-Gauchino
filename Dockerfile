# Build stage
FROM node:22-alpine AS build

# Instalar pnpm globalmente
RUN npm install -g pnpm

# Crear directorio de trabajo
WORKDIR /app

# Copiar archivos de dependencias
COPY package*.json ./
COPY pnpm-lock.yaml ./

# Instalar dependencias con pnpm
RUN pnpm install

# Copiar código fuente
COPY . .

# Construir la aplicación con pnpm
RUN pnpm run build

# Production stage - usar serve en lugar de nginx
FROM node:22-alpine
# Instalar cwebp y serve para servir archivos estáticos
RUN apk add --no-cache libwebp-tools \
    && npm install -g serve
# Copiar archivos construidos
COPY --from=build /app/dist ./dist
# Exponer puerto 80
EXPOSE 80
# Comando para ejecutar serve
CMD ["serve", "dist", "-l", "80"]
