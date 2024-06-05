FROM docker.io/library/golang:1.18-alpine3.15 AS builder

WORKDIR /app/build/bin
RUN wget https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/v0.4.11/grpc_health_probe-linux-amd64 -P /app/build/bin/ && \
    mv /app/build/bin/grpc_health_probe-linux-amd64 /app/build/bin/grpc_health_probe && \
    chmod +x /app/build/bin/grpc_health_probe

FROM thorax/erigon:v2.60.1
COPY --from=builder /app/build/bin/* /usr/local/bin/
