# Базовый образ для Python (для бэкенда)
FROM python:3.11.9-slim as backend

# Устанавливаем зависимости для бэкенда
WORKDIR /app/backend
COPY ./backend/requirements.txt .
RUN pip install -r requirements.txt
COPY ./backend .

# Базовый образ для Node.js (для фронтенда)
FROM node:alpine as frontend

# Устанавливаем зависимости для фронтенда
WORKDIR /app/frontend
COPY ./frontend/package*.json ./
RUN npm install
COPY ./frontend .
RUN npm run build

# Финальный образ на основе Alpine Linux с nginx и supervisord
FROM alpine:latest

# Устанавливаем nginx, python и supervisord
RUN apk --no-cache add nginx python3 py3-pip supervisor

# Копируем собранный фронтенд в директорию Nginx
COPY --from=frontend /app/frontend/dist /usr/share/nginx/html

# Копируем бэкенд в финальный контейнер
COPY --from=backend /app/backend /app/backend

# Копируем конфигурации nginx и supervisord
COPY ./frontend/nginx.conf /etc/nginx/nginx.conf
COPY ./supervisord.conf /etc/supervisord.conf

# Открываем порты для nginx (80) и бэкенда (например, 8000)
EXPOSE 80 8000

# Команда для запуска supervisord, который будет управлять процессами
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
