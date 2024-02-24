# Builder stage
FROM golang:1.20 AS build
WORKDIR /app
COPY . .

RUN make linux && \
    make arm && \
    make macos && \
    make windows

# Release stage
FROM gcr.io/distroless/base AS release
LABEL maintainer="google"

COPY --from=build /app/linux /linux
COPY --from=build /app/arm /arm
COPY --from=build /app/macos /macos 
COPY --from=build /app/windows /windows

ENV PLATFORM linux
CMD ["/${PLATFORM}/myprogram"]

