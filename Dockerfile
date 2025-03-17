FROM openjdk:17-slim-bullseye

ARG OPENREFINE_VERSION=3.9.1
ARG COMMONS_EXTENSION_VERSION=0.1.3
ARG OPENREFINE_FILE=openrefine-linux-${OPENREFINE_VERSION:?}.tar.gz
ARG OPENREFINE_URL=https://github.com/OpenRefine/OpenRefine/releases/download/${OPENREFINE_VERSION}/${OPENREFINE_FILE}
ARG COMMONS_EXTENSION_URL=https://github.com/OpenRefine/CommonsExtension/releases/download/v${COMMONS_EXTENSION_VERSION}/openrefine-commons-extension-${COMMONS_EXTENSION_VERSION}.zip

ENV REFINE_INTERFACE=0.0.0.0
ENV REFINE_PORT=3333
ENV REFINE_DATA_DIR=/data
ENV REFINE_MIN_MEMORY=256M
ENV REFINE_MEMORY=1024M

RUN apt-get update && \
    apt-get install -y curl procps unzip && \
    mkdir -p /opt/openrefine && \
    cd /opt/openrefine && \
    curl -sSL ${OPENREFINE_URL} | tar xz --strip 1 && \
    mkdir -p /opt/openrefine/webapp/extensions/commons && \
    cd /opt/openrefine/webapp/extensions/commons && \
    curl -sSL ${COMMONS_EXTENSION_URL} -o openrefine-commons.zip && \
    unzip openrefine-commons.zip && \
    rm openrefine-commons.zip && \
    apt-get remove -y unzip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

VOLUME $REFINE_DATA_DIR
WORKDIR $REFINE_DATA_DIR
EXPOSE $REFINE_PORT

ENTRYPOINT ["/opt/openrefine/refine"]
CMD ["-m", "3048M", "-v", "debug"]
