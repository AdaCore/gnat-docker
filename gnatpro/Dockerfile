FROM gnatpro:deps AS gnatpro-build-install
ARG gnat_release=gnatpro-20.2-x86_64-linux-bin.tar.gz

# Install GNAT from local archive
COPY ${gnat_release} /tmp/gnat-src.tar.gz
COPY default_install /tmp/default_install
RUN set -xe \
    && cd /tmp \
    && mkdir gnat-src \
    && tar -xf gnat-src.tar.gz -C gnat-src/ \
        --strip-components 1 \
    && cd gnat-src \
    && cp ../default_install default_install \
    && chmod +x default_install \
    && ./default_install

FROM ubuntu:18.04
COPY --from=gnatpro-build-install /usr/gnat /usr/gnat
COPY --from=gnatpro-build-install /usr/bin/make /usr/bin/make
COPY --from=gnatpro-build-install /usr/lib/ /usr/lib/
COPY --from=gnatpro-build-install /usr/include/ /usr/include/
ENV PATH="/usr/gnat/bin:${PATH}"
ENTRYPOINT ["/bin/bash"]
