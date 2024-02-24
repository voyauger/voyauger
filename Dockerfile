FROM $(REGISTRY)/golang:1.20 as builder

COPY . /app 
WORKDIR /app

RUN make linux && \ 
    make arm && \
    make macos && \ 
    make windows

FROM $(REGISTRY)/base/os 
COPY --from=builder /app/myapp-* /
CMD ["/myapp-linux"]
