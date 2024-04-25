# Build stage
FROM node:21.7-alpine as builder
WORKDIR /usr/src/app

# Ensure that dependencies are installed
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Build the application
RUN yarn build

# Production stage
FROM node:21.7-alpine
WORKDIR /app

# Create a user and assign folder ownership
RUN adduser -D myuser && chown -R myuser:myuser /app
USER myuser

# Copy built assets from the builder stage
COPY --from=builder --chown=myuser:myuser /usr/src/app/dist ./dist
COPY --from=builder --chown=myuser:myuser /usr/src/app/node_modules ./node_modules

# Set NODE_ENV to production
ENV NODE_ENV=production

# Expose port 3000 for the application
EXPOSE 3000

# Command to run the application
CMD ["node", "dist/app.js"]
