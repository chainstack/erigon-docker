FROM docker.io/library/golang:1.17-alpine3.14 AS builder

WORKDIR /app/build/bin
RUN wget https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/v0.4.7/grpc_health_probe-linux-amd64 -P /app/build/bin/ && \
    mv /app/build/bin/grpc_health_probe-linux-amd64 /app/build/bin/grpc_health_probe && \
    chmod +x /app/build/bin/grpc_health_probe

FROM thorax/erigon:v2022.03.01
COPY --from=builder /app/build/bin/* /usr/local/bin/
