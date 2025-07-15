FROM docker.n8n.io/n8nio/n8n:latest
USER root
# Устанавливаем и ffmpeg, и yt-dlp
RUN apk add --no-cache ffmpeg curl yt-dlp
RUN chown -R node:node /home/node/.n8n
USER node
