# Use golang:1.23.1-alpine as the base image.
FROM golang:1.23.1-alpine AS builder
COPY . /app
# Change directory and build the binary. Build command is also used to download the dependencies.
RUN cd /app && go build -o capture ./cmd/capture

FROM chainguard/static:latest-glibc
COPY --from=builder /app/capture /usr/bin/
# Set the default GIN_MODE to release, so that the application runs in production mode. However, this can be overridden by setting the GIN_MODE environment variable.
ENV GIN_MODE=release
CMD ["/usr/bin/capture"]
