# Команда для сборки фронтенда и бэкенда
build-all: build-frontend build-backend

# Команда для запуска фронтенда
run-frontend:
	docker run -p 80:80 my-frontend

# Команда для запуска бэкенда
run-backend:
	docker run -p 8000:8000 my-backend

# Команда для запуска фронтенда и бэкенда вместе
run-all: run-frontend run-backend
