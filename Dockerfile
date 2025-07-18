# Версия "Тупой, и еще тупее". Мы больше не играем в умников.
FROM n8nio/n8n:latest

USER root

# ОДНА КОМАНДА. ОДНА ЦЕЛЬ. БЕЗ ЛИШНЕГО ДЕРЬМА.
# 1. Устанавливаем ТОЛЬКО curl (чтобы скачать) и ffmpeg (потому что он тебе ПОНАДОБИТСЯ, поверь мне).
# 2. ИСПОЛЬЗУЕМ curl, чтобы СКАЧАТЬ последнюю готовую версию yt-dlp прямо с GitHub.
# 3. КЛАДЁМ ее в /usr/local/bin/, чтобы система её видела.
# 4. ДАЁМ ей права на исполнение (делаем её "кликабельной" для терминала).
RUN apk add --no-cache curl ffmpeg && \
    curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp && \
    chmod a+rx /usr/local/bin/yt-dlp

USER node
