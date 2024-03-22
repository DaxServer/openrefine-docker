FROM vimagick/openrefine

ADD openrefine-linux-3.7.9.tar.gz /tmp
RUN rm -rf /opt/openrefine &&  \
    mv /tmp/openrefine-3.7.9 /opt/openrefine
COPY --link refine.ini /opt/openrefine/refine.ini
