# Переменные для путей к Dockerfile
FRONTEND_PATH=./frontend
BACKEND_PATH=./backend

# Команда для сборки фронтенда
build-frontend:
	docker build -t my-frontend $(FRONTEND_PATH)

# Команда для сборки бэкенда
build-backend:
	docker build -t my-backend $(BACKEND_PATH)

# Команда для запуска всего проекта (фронтенд и бэкенд)
build-all: build-frontend build-backend
