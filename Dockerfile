FROM ghost:3.11-alpine


# copy config.production.json with db
COPY config.json config.production.json


# Install Azure Storage
RUN npm install ghost-storage-azure
RUN cp -vR node_modules/ghost-storage-azure current/core/server/adapters/storage/ghost-storage-azure
