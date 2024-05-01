FROM vimagick/openrefine

ARG OPENREFINE_VERSION=3.7.9

WORKDIR /opt/openrefine

RUN rm -rf * && \
    curl -sSL https://github.com/OpenRefine/OpenRefine/releases/download/$OPENREFINE_VERSION/openrefine-linux-$OPENREFINE_VERSION.tar.gz | tar xz --strip 1

COPY --link refine.ini /opt/openrefine/refine.ini

WORKDIR /data

CMD ["-m", "3048M"]
