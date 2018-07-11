FROM golang:latest

RUN \
    cd /tmp && \
    wget https://cmake.org/files/v3.11/cmake-3.11.4.tar.gz && \
    tar -xvzf cmake-3.11.4.tar.gz && \
    cd cmake-3.11.4 && \
    bash ./bootstrap && \
    make && \
    make install && \
    rm -rf /tmp/cmake-3.11.4.tar.gz

RUN \
    cd /tmp && \
    svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm && \
    cd llvm/tools && \
    svn co http://llvm.org/svn/llvm-project/cfe/trunk clang && \
    cd ../.. && \
    mkdir build && \
    cd build && \
    cmake -G "Unix Makefiles" ../llvm && \
    make