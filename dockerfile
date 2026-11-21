# ================= Stage 1: Builder =================
# Pinned Node.js 22 Alpine image used only to build the site
FROM node:22-alpine AS builder

# Set the working directory inside the build container
WORKDIR /app

# Copy only the dependency manifests first so this layer is cached
# and npm ci re-runs only when dependencies change
COPY package*.json ./

# Install the exact dependency versions from package-lock.json (includes Parcel)
RUN npm ci

# Copy the website source files (HTML pages and shared stylesheet)
COPY src/ ./src/
COPY styles/ ./styles/

# Build the static site into /app/dist using Parcel
RUN npm run build

# ================= Stage 2: Runtime =================
# Pinned lightweight Nginx image used to serve the built site
FROM nginx:1.27-alpine

# Copy only the built static files from the builder stage
# (no Node.js, node_modules or source files reach the final image)
COPY --from=builder /app/dist /usr/share/nginx/html

# Document that the container listens on port 80
EXPOSE 80

# Run Nginx in the foreground so the container keeps running
CMD ["nginx", "-g", "daemon off;"]