# Используем официальный образ n8n в качестве основы
FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Устанавливаем FFmpeg
RUN apk add --no-cache ffmpeg curl

# --- НАЧАЛО КЛЮЧЕВОГО ИЗМЕНЕНИЯ ---
# Создаем директорию, которую ищет проблемный узел
RUN mkdir -p /home/node/.n8n/nodes/node_modules/ffmpeg-static/

# Создаем символическую ссылку, которая "обманет" узел,
# заставив его думать, что он нашел свой внутренний ffmpeg,
# хотя на самом деле он будет использовать системный.
RUN ln -s /usr/bin/ffmpeg /home/node/.n8n/nodes/node_modules/ffmpeg-static/ffmpeg
# --- КОНЕЦ КЛЮЧЕВОГО ИЗМЕНЕНИЯ ---

# Возвращаем права владельца
RUN chown -R node:node /home/node/.n8n

USER node

ARG CACHE_BUSTER=20250715134855
