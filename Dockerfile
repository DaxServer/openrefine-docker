ARG OPENREFINE_VERSION=3.8.2

FROM easypi/openrefine:$OPENREFINE_VERSION

ARG COMMONS_EXTENSION_VERSION=0.1.2
WORKDIR /opt/openrefine/webapp/extensions/commons

RUN apt update &&  \
    apt install -y unzip && \
    curl -sSL https://github.com/OpenRefine/CommonsExtension/releases/download/v$COMMONS_EXTENSION_VERSION/openrefine-commons.zip -o openrefine-commons.zip && \
    unzip openrefine-commons.zip && \
    rm openrefine-commons.zip && \
    apt remove -y unzip && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR $REFINE_DATA_DIR

CMD ["-m", "3048M"]
