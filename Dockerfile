FROM node:alpine as builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build -- all the stuff we care
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# default cmd is to start nginx
