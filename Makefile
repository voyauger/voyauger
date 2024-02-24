REGISTRY=quay.io
IMAGE=golang:1.20 

linux:
        GOOS=linux GOARCH=amd64 go build -o $(IMAGE)-linux main.go
        
arm:
        GOOS=linux GOARCH=arm64 go build -o $(IMAGE)-arm main.go
        
macos:
        GOOS=darwin GOARCH=amd64 go build -o $(IMAGE)-macos main.go

windows:
        GOOS=windows GOARCH=amd64 go build -o $(IMAGE)-windows main.go
        
build:
        docker build -t %{REGISTRY}/%{IMAGE}:latest.
        
clean:
        docker rmi %{REGISTRY}/%{IMAGE}:latest
