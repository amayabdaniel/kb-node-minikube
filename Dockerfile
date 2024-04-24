# Use Node.js official Alpine image as it's smaller
FROM node:14-alpine

# Set non-root user and switch to it
RUN adduser -D myuser
USER myuser

# Set working directory
WORKDIR /usr/src/app
# Set the Node.js environment to production to avoid installing devDependencies
ENV NODE_ENV=production
# Install app dependencies by copying package files first
COPY --chown=myuser:myuser package.json yarn.lock ./
RUN yarn install --production

# Copy the rest of the application code
COPY --chown=myuser:myuser . .

# Build the TypeScript application
RUN yarn build

# Expose port 3000
EXPOSE 3000

# Command to run the application
CMD ["node", "dist/app.js"]
