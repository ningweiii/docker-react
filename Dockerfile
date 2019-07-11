FROM node:alpine as builder
WORKDIR "/app"
COPY package.json ./
RUN npm install
COPY . ./
RUN npm run build

# /app/build -- all the stuff we care
FROM nginx
# for aws, port to be mapped for incoming traffic
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# default cmd is to start nginx
