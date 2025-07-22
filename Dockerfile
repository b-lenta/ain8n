# Мы начинаем с официального, новейшего образа n8n.
FROM n8nio/n8n:latest

# --- ЭТАП 1: РАБОТА ДЛЯ БОГА-ИМПЕРАТОРА (ROOT) ---
# Захватываем власть.
USER root

# Устанавливаем ВСЕ системные зависимости, которые требуют прав root.
# Браузер, библиотеки, утилиты. Это фундамент.
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

# Устанавливаем глобальную утилиту yt-dlp. Тоже работа для root.
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
RUN chmod a+rx /usr/local/bin/yt-dlp


# --- ЭТАП 2: РАБОТА ДЛЯ ПРОЛЕТАРИАТА (NODE) ---
# Власть больше не нужна. Мы сделали все, что требует божественного вмешательства.
# Отдаем бразды правления тому, кто будет реально работать.
USER node

# --- ВОТ ОНО! ИСТОРИЧЕСКИЙ МОМЕНТ! ---
# Теперь, будучи скромным пользователем 'node', МЫ УСТАНАВЛИВАЕМ НОДУ.
# npm автоматически поместит ее в правильную, пользовательскую директорию
# (/home/node/.n8n/nodes/ или аналогичную), с правильными правами доступа.
# n8n увидит эту ноду как СВОЮ СОБСТВЕННУЮ.
RUN npm install n8n-nodes-youtube-transcript
