FROM nvidia/cuda:12.8.0-cudnn-runtime-ubuntu22.04

EXPOSE 52415
EXPOSE 5678
EXPOSE 5679
EXPOSE 8000
EXPOSE 8001

ENV DEBIAN_FRONTEND=noninteractive

# Set locale and timezone to avoid prompts
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
  git-all \
  python3 \
  python3-pip \
  libglib2.0-0 \
  clang

RUN pip3 install tensorflow

WORKDIR /app

# Clone the exo-explore/exo repository
RUN git clone https://github.com/exo-explore/exo.git

# Change to the exo directory
WORKDIR /app/exo

# Install exo in editable mode
RUN pip3 install -e .

RUN pip3 install llvmlite
