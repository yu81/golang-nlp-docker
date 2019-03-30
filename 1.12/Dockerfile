FROM golang:1.12.1-alpine AS first-env

RUN apk update && \
    apk upgrade && \
    apk add --no-cache python bash git doxygen make cmake g++

# Install libs for Japanese text
RUN go get -u github.com/ikawaha/kagome;:
RUN go get -u github.com/evalphobia/go-jp-text-ripper;:

# Install OpenCC for Chinese text.
RUN git clone https://github.com/BYVoid/OpenCC --depth 1 && \
    cd OpenCC && \
    git checkout 33d57bd86c5da06f00559916cd64718e6c3961c6 && \
    make install && \
    cd .. && \
    rm -rf OpenCC

RUN go get -u github.com/stevenyao/go-opencc;:

# clean .git
RUN find . -type d -name ".git" | xargs rm -rf


# Use multi stage build for reducing image size.
FROM golang:1.12.1-alpine

RUN apk update && \
    apk upgrade

COPY --from=first-env /go/src /go/src
COPY --from=first-env /usr/bin /usr/bin
COPY --from=first-env /usr/lib /usr/lib
COPY --from=first-env /usr/include/opencc /usr/include/
RUN mkdir -p /usr/share/opencc
COPY --from=first-env /usr/share/opencc/*.ocd /usr/share/opencc/
COPY --from=first-env /usr/share/opencc/*.json /usr/share/opencc/

