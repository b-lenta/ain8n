# Начинаем с базы. Это последний раз, когда мы видим этот файл.
FROM n8nio/n8n:latest

# --- ЭТАП 1: РАБОТА ДЛЯ ROOT ---
# Устанавливаем все системное дерьмо. Мы это уже выучили.
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

# --- ЭТАП 2: НЕЙРОХИРУРГИЯ, ОСНОВАННАЯ НА ДОКАЗАТЕЛЬСТВАХ ---
# Мы не просто меняем директорию. Мы телепортируемся на место преступления.
# Путь, который ТЫ, СУКА, НАШЕЛ.
WORKDIR /home/node/.n8n/nodes/

# --- ЭТАП 3: РИТУАЛЬНОЕ ЗАХОРОНЕНИЕ ---
# Мы передаем лопату правильному могильщику - пользователю 'node'.
USER node
# И он, находясь в нужной папке, устанавливает пакет так,
# как будто это делает сам UI. Создавая /home/node/.n8n/nodes/node_modules/...
RUN npm install n8n-nodes-youtube-transcript
