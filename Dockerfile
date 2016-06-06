FROM ubuntu:16.04

# --------------------------- ubuntu ------------------------------------------
RUN apt-get -y update
RUN	apt-get -y install build-essential cmake clang wget vim git \
	autoconf automake libboost-thread-dev libboost-system-dev curl gcc \
	g++ libsasl2-dev libsasl2-modules libtool ntp patch pkg-config \
	make rsync unzip vim-common gdb python asciidoctor xsltproc

RUN git clone https://github.com/apache/incubator-kudu kudu
RUN cd kudu && thirdparty/build-if-necessary.sh
RUN	apt-get -y install cmake
RUN mkdir -p /kudu/build/release && cd /kudu/build/release && \
	../../thirdparty/installed/bin/cmake -DCMAKE_BUILD_TYPE=release ../.. && \
	make -j4
