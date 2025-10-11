FROM node:24 AS creador_dist
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:24-alpine
WORKDIR /app
COPY --from=creador_dist /app/dist /app/dist
COPY package*.json /app
RUN npm install --production
ENV PORT=3000
CMD ["node", "dist/main"]
