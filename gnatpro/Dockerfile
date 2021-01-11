FROM gnatpro:deps AS gnatpro-build-install
ARG gnat_release=gnatpro-20.2-x86_64-linux-bin.tar.gz
# could also remove examples if not for testing
ARG remove="doc gnatstudio gps info man"

# Install GNAT from local archive
COPY ${gnat_release} /tmp/gnat-src.tar.gz
COPY default_install.sh /tmp/default_install.sh
RUN set -xe \
    && DEBIAN_FRONTEND=noninteractive apt-get update -y \
    && apt-get install --no-install-recommends -y \
        gcc \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge --auto-remove \
    && apt-get clean \
    && cd /tmp \
    && mkdir gnat-src \
    && tar -xf gnat-src.tar.gz -C gnat-src/ \
        --strip-components 1 \
    && cd gnat-src \
    && cp ../default_install.sh default_install.sh \
    && chmod +x default_install.sh \
    && ./default_install.sh \
    && cd /usr/gnat/share \
    && rm -rf ${remove}

FROM gnatpro:deps
COPY --from=gnatpro-build-install /usr/gnat /usr/gnat
ENV PATH="/usr/gnat/bin:${PATH}"
ENTRYPOINT ["/bin/bash"]
