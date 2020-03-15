FROM ghost:3.11-alpine

# set url-hostname for Ghost with build arg
ARG mode
ENV devMode ${mode}
ENV url ""

# copy config.production.json with db
COPY config.${devMode}.json config.production.json

# copy themes/images to container
COPY content content

# copy redirects
COPY redirects.json content/data

# Install Azure Storage
RUN npm install ghost-storage-azure
RUN cp -vR node_modules/ghost-storage-azure current/core/server/adapters/storage/ghost-storage-azure
