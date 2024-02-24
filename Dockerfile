FROM quay.io/projectquay/golang:1.20 as builder

WORKDIR /app
COPY . .

RUN go build -o app .

FROM alpine:latest
COPY --from=builder /app/app .

CMD ["/app"] 

LABEL maintainer="myname"
