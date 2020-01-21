FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    gcc gdb make bash vim \
    libtool libtool-bin wget python automake autoconf coreutils bison 
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y libglib2.0

ADD https://github.com/google/AFL/archive/v2.56b.tar.gz /
RUN tar xvzf v2.56b.tar.gz && rm v2.56b.tar.gz

WORKDIR /AFL-2.56b
RUN make -j4 && make -j4 install
WORKDIR /AFL-2.56b/qemu_mode/
RUN ./build_qemu_support.sh
WORKDIR /
ENV AFL_PATH='/AFL-2.56b'
