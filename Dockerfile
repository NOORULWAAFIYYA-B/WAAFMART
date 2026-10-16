FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    pkg-config \
    libdrogon-dev \
    libjsoncpp-dev \
    libcurl4-openssl-dev \
    libpq-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY CMakeLists.txt ./
COPY main.cc ./
COPY waafiyyamart.html ./

RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Release \
    && cmake --build build --config Release -j"$(nproc)"

ENV PORT=8080

EXPOSE 8080

CMD ["sh", "-c", "exec ./build/WaafiyyaMart"]
