FROM golang:latest

# wget https://cmake.org/files/v3.11/cmake-3.11.4.tar.gz && tar -xvzf cmake-3.11.4.tar.gz
COPY cmake-3.11.4 /tmp

# svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm && cd llvm/tools && svn co http://llvm.org/svn/llvm-project/cfe/trunk clang
COPY llvm /tmp

RUN \
    cd /tmp/cmake-3.11.4 && \
    bash ./bootstrap && \
    make && make install && \
    cd /

RUN \
    mkdir /tmp/build && \
    cd /tmp/build && \
    cmake -G "Unix Makefiles" ../llvm && \
    make