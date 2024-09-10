# Use Go as the builder
FROM docker.io/library/golang:1.18-alpine3.15 AS builder

# Set the working directory
WORKDIR /app/build/bin

# Download and set up grpc_health_probe
RUN wget https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/v0.4.11/grpc_health_probe-linux-amd64 -P /app/build/bin/ && \
    mv /app/build/bin/grpc_health_probe-linux-amd64 /app/build/bin/grpc_health_probe && \
    chmod +x /app/build/bin/grpc_health_probe

# Use the desired Erigon image as the base for the final stage
FROM erigontech/erigon:2.60.7
