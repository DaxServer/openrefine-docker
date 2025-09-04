FROM openjdk:17-slim-bullseye

ENV REFINE_INTERFACE=0.0.0.0
ENV REFINE_PORT=3333
ENV REFINE_DATA_DIR=/data
ENV REFINE_MIN_MEMORY=256M
ENV REFINE_MEMORY=1024M

RUN apt-get update
RUN apt-get install -y curl procps unzip

ARG COMMONS_EXTENSION_VERSION=0.1.5-prerelease
ARG COMMONS_EXTENSION_URL=https://github.com/OpenRefine/CommonsExtension/releases/download/v${COMMONS_EXTENSION_VERSION}/openrefine-commons-extension-${COMMONS_EXTENSION_VERSION}.zip

ARG OPENREFINE_VERSION=3.9.5
ARG OPENREFINE_URL=https://github.com/OpenRefine/OpenRefine/releases/download/${OPENREFINE_VERSION}/openrefine-linux-${OPENREFINE_VERSION}.tar.gz

WORKDIR /opt/openrefine
RUN curl -sSL ${OPENREFINE_URL} | tar xz --strip 1

WORKDIR /opt/openrefine/webapp/extensions/commons
RUN curl -sSL ${COMMONS_EXTENSION_URL} -o openrefine-commons.zip
RUN unzip openrefine-commons.zip
RUN rm openrefine-commons.zip

RUN apt-get remove -y unzip
RUN apt-get autoremove -y
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

VOLUME $REFINE_DATA_DIR
WORKDIR $REFINE_DATA_DIR
EXPOSE $REFINE_PORT

ENTRYPOINT ["/opt/openrefine/refine"]
CMD ["-m", "3048M", "-v", "debug"]
