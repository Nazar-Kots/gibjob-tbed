FROM node:lts-alpine AS builder
WORKDIR /app

COPY /src /app/src
COPY package.json .
COPY package-lock.json .

RUN npm install
RUN npx vite build

FROM nginx:1.16 as nginx

COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]