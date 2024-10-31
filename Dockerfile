FROM docker.io/library/golang:1.18-alpine3.15 AS builder

WORKDIR /app/build/bin
RUN wget https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/v0.4.11/grpc_health_probe-linux-amd64 -P /app/build/bin/ && \
    mv /app/build/bin/grpc_health_probe-linux-amd64 /app/build/bin/grpc_health_probe && \
    chmod +x /app/build/bin/grpc_health_probe

FROM --platform=linux/amd64/v2 erigontech/erigon:v2.60.9
USER root
RUN apt update -y && \
    apt install -y netcat-openbsd=1.219-1 && \
    rm -rf /var/lib/apt/lists/*
USER erigon
COPY --from=builder /app/build/bin/* /usr/local/bin/
