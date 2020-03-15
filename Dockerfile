FROM ghost:3.11-alpine as BUILD

# Add necessary packages for Sharp to work
RUN apk add --update --no-cache gcc g++ make libc6-compat python python3
RUN apk add vips-dev fftw-dev build-base --update-cache \
    --repository http://dl-3.alpinelinux.org/alpine/edge/community \
    --repository https://alpine.global.ssl.fastly.net/alpine/edge/main

FROM BUILD as publish
# set url-hostname for Ghost with build arg
ARG mode
RUN echo ${mode}
ENV url ""

# copy config.production.json with db
COPY "config.${mode}.json" "config.production.json"        
#Install Azure Storage Test
COPY ghost-storage-azure-1.1.1-0.tgz .
RUN npm install ghost-storage-azure-1.1.1-0.tgz
RUN cp -vR node_modules/ghost-storage-azure current/core/server/adapters/storage/ghost-storage-azure

VOLUME [ "/var/lib/ghost/content" ]

# # Install Azure Storage
# RUN npm install ghost-storage-azure
# RUN cp -vR node_modules/ghost-storage-azure current/core/server/adapters/storage/ghost-storage-azure

# Install cloudinary module
# RUN npm install ghost-cloudinary-store
# RUN cp -r node_modules/ghost-cloudinary-store current/core/server/adapters/storage
