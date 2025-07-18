# Версия 3.0: Оптимизированный для хилых облачных платформ
FROM n8nio/n8n:latest

USER root

# ОДНА КОМАНДА, ЧТОБЫ ПРАВИТЬ ВСЕМИ!
# Мы устанавливаем все, что нам нужно, ОДНИМ махом.
# Затем, в этой же команде (связка '&&'), мы используем pip для установки yt-dlp.
# --no-cache-dir говорит pip не гадить в системе кэшем.
# И, наконец, ВИШЕНКА НА ТОРТЕ: мы УДАЛЯЕМ pip и другие сборочные зависимости
# сразу после того, как они сделали свою работу. Это уменьшает размер финального образа.
RUN apk add --no-cache --virtual .build-deps python3 py3-pip curl && \
    pip3 install --no-cache-dir --upgrade yt-dlp && \
    apk del .build-deps && \
    apk add --no-cache ffmpeg

# Твоя команда для прав доступа. Она все еще полезна.
RUN chown -R node:node /home/node/.n8n

USER node
