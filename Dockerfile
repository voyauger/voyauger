# Використання базового образу з quay.io
FROM quay.io/projectquay/golang:1.20 AS builder

# Встановлення залежностей для тестового набору
RUN apt-get update && apt-get install -y \
    build-essential \
    # Інші залежності ...

# Копіювання коду для зборки та тестів
COPY . /app
WORKDIR /app

# Збірка коду для різних платформ
RUN make linux
RUN make arm
RUN make macos
RUN make windows

# Тут можна додати команди для запуску тестів

# Другий етап для створення окремих Docker-контейнерів для кожної платформи
FROM quay.io/projectquay/golang:1.20 AS release

# Копіювання збілджених бінарних файлів з попереднього етапу
COPY --from=builder /app/build/linux/myprogram /app/linux/
COPY --from=builder /app/build/arm/myprogram /app/arm/
COPY --from=builder /app/build/macos/myprogram /app/macos/
COPY --from=builder /app/build/windows/myprogram.exe /app/windows/

# Тут можна додати команди для запуску тестів у відповідних середовищах

# Команда за замовчуванням для запуску контейнера
CMD ["echo", "Specify platform to run tests"]
