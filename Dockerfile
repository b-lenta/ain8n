# STAGE 0: берем apk из alpine
FROM alpine:latest AS alpine

# STAGE 1: основной образ n8n
FROM n8nio/n8n:latest

# вернуть apk в образ (как workaround)
COPY --from=alpine /sbin/apk /sbin/apk
COPY --from=alpine /usr/lib/libapk.so* /usr/lib/

USER root

RUN apk add --no-cache \
    curl \
    ffmpeg \
    python3 \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    udev

RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
 && chmod a+rx /usr/local/bin/yt-dlp

RUN mkdir -p /home/node/.n8n/nodes \
 && chown -R node:node /home/node/.n8n

USER node
WORKDIR /home/node/.n8n/nodes/
RUN npm install n8n-nodes-youtube-transcript

ARG CACHE_BUSTER=20260331224005
