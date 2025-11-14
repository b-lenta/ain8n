# Начинаем с базы.
FROM n8nio/n8n:latest

# --- ЭТАП 1: РАБОТА ДЛЯ ROOT ---
# Установка всего системного дерьма.
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
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
RUN chmod a+rx /usr/local/bin/yt-dlp

# --- ЭТАП 2: СОЗДАНИЕ И ПЕРЕДАЧА ---
# Мы, как ROOT, создаем нужную нам директорию. Мы используем mkdir -p,
# чтобы создать всю вложенную структуру, если она не существует.
RUN mkdir -p /home/node/.n8n/nodes

# --- ВОТ ОН! СВЯЩЕННЫЙ УКАЗ! ---
# Команда 'chown' (change owner). Мы говорим: "Сделать владельцем
# всей папки /home/node/.n8n/ (и всего, что внутри, благодаря флагу -R)
# пользователя 'node' и группу 'node'".
RUN chown -R node:node /home/node/.n8n

# --- ЭТАП 3: РАБОТА ДЛЯ НОВОГО ВЛАДЕЛЬЦА ---
# Теперь, когда крестьянин официально владеет землей, мы переключаемся на него.
USER node
# И говорим ему работать на СВОЕЙ земле.
WORKDIR /home/node/.n8n/nodes/
# И он, как полноправный хозяин, без проблем строит себе сарай для инструментов.
RUN npm install n8n-nodes-youtube-transcript


ARG CACHE_BUSTER=20251114222348
