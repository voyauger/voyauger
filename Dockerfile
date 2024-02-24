# Builder stage
FROM quay.io/projectquay/golang:1.20 as builder
WORKDIR /app
COPY . .
RUN go build -o app .
IMAGE:
        docker build -t google:latest .

RUN make linux && \
    make arm && \
    make macos && \
    make windows

# Release stage
FROM gcr.io/distroless/base AS release
LABEL maintainer="kakadoo"

COPY --from=build /app/linux /linux
COPY --from=build /app/arm /arm
COPY --from=build /app/macos /macos 
COPY --from=build /app/windows /windows

ENV PLATFORM linux
CMD ["/${PLATFORM}/myprogram"]

