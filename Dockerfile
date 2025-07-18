# Версия 5.0: "Завет". Финальная. Обсуждению не подлежит.
FROM n8nio/n8n:latest

USER root

#
# --- АПОГЕЙ НАШЕЙ МЫСЛИ ---
#
# Мы делаем то же самое, что и в прошлый раз: ставим curl и ffmpeg.
# НО! Мы возвращаем из небытия 'python3'. Не 'pip'. Не весь этот хлам для разработки.
# Только чистое, необходимое тело для души нашего yt-dlp.
RUN apk add --no-cache curl ffmpeg python3

# Мы по-прежнему крадем последнюю версию yt-dlp с GitHub, потому что это
# единственно верный способ обойти все защиты и пакетные менеджеры.
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp

# Мы по-прежнему даем ему право на жизнь.
RUN chmod a+rx /usr/local/bin/yt-dlp

USER node
