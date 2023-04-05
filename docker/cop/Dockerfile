FROM debian:bookworm-slim
RUN apt-get update

#Install cloudbuildhelper
COPY cloudbuildhelper.sh /tmp/
RUN bash /tmp/cloudbuildhelper.sh

#Install running dependencies
RUN apt-get install -y docker.io
