# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake g++

## Add source code to the build stage.
ADD . /packJPG
WORKDIR /packJPG

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN cd source && make dev

# Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /packJPG/source/packJPG /
COPY --from=builder /packJPG/docs/sample_images.zip /
RUN unzip /sample_images.zip -d /testsuite
