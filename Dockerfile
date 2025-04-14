FROM node:21-alpine3.19

WORKDIR /usr/src/app

COPY package.json ./
COPY package-lock.json ./

# Install build dependencies for native modules like bcrypt
RUN apk add --no-cache --update make gcc g++ python3

RUN npm install

# Copy the Prisma schema directory
COPY prisma ./prisma

# Generate Prisma Client
RUN npx prisma generate

COPY . .

EXPOSE 3004

CMD [ "npm", "run", "start:dev" ]