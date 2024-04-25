# Use Node.js official Alpine image as it's smaller
FROM node:21.7-alpine

# Create app directory and ensure correct permissions
WORKDIR /usr/src/app
RUN adduser -D myuser && chown -R myuser:myuser /usr/src/app

# Switch to non-root user
USER myuser

# Temporarily set NODE_ENV to development to install all dependencies
ENV NODE_ENV=development

# Install app dependencies including devDependencies
COPY --chown=myuser:myuser package.json yarn.lock ./
RUN yarn install

# Set NODE_ENV back to production (if needed at runtime)
ENV NODE_ENV=production

# Copy the rest of the application code
COPY --chown=myuser:myuser . .

# Build the TypeScript application
RUN yarn build

# Expose port 3000
EXPOSE 3000

# Command to run the application
CMD ["node", "dist/app.js"]
