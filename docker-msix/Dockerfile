# Stage 1: Compilation environment
FROM debian:bookworm AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN <<EOT
    echo "deb http://deb.debian.org/debian bookworm-backports main" >/etc/apt/sources.list.d/backports.list
    apt-get update
    apt-get install -y \
        build-essential \
        clang \
        git \
        libicu-dev \
        libssl-dev \
        libcurl4-openssl-dev \
        libxerces-c-dev \
        zlib1g-dev
    apt-get install -y \
        -t bookworm-backports \
        cmake
EOT

COPY msix-packaging /msix-src
WORKDIR /msix-src

RUN ./makelinux.sh --pack

# Stage 2: Native glibc lightweight runtime environment
FROM debian:bookworm-slim

RUN <<EOT
    apt-get update
    apt-get install -y \
        --no-install-recommends \
        libicu72 \
        libssl3 \
        libcurl4 \
        libxerces-c3.2 \
        zlib1g
    rm -rf /var/lib/apt/lists/*
EOT

COPY --from=builder /msix-src/.vs/bin/makemsix /usr/local/bin
COPY --from=builder /msix-src/.vs/lib/libmsix.so /usr/lib

WORKDIR /workspace
ENTRYPOINT ["/usr/local/bin/makemsix"]
