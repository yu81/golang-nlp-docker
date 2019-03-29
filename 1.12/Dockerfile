FROM golang:1.12.1-alpine

RUN apk update
RUN apk upgrade
RUN apk add bash python git doxygen make cmake g++

# Install libs for Japanese text
RUN go get -u github.com/ikawaha/kagome;:
RUN go get -u github.com/evalphobia/go-jp-text-ripper;:

# Install OpenCC for Chinese text.
RUN git clone https://github.com/BYVoid/OpenCC
RUN cd OpenCC && git checkout 33d57bd86c5da06f00559916cd64718e6c3961c6 && make install
RUN go get -u github.com/stevenyao/go-opencc;:
