FROM ubuntu:22.04

ENV PLUGIN_REPO="https://github.com/tuffacton/plugin-artifact-register"
ENV PLUGIN_TAG="latest"
ENV PLUGIN_BUILDPACK=""
ENV PLUGIN_REGISTRY="docker.io"
ENV PLUGIN_CACHE_IMAGE=""

COPY build.sh /build.sh
RUN chmod +x /build.sh

CMD [ "/build.sh" ]
