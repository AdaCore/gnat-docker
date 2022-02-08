FROM gnatpro:latest

ARG LAL_RELEASE

# Make sure that LAL_RELEASE has been set
RUN if [ -z ${LAL_RELEASE} ] ; then echo "LAL_RELEASE not set. Please refer to README." && exit 1 ; fi

# Install GNAT from local archive
COPY ${LAL_RELEASE} /tmp/lal_release.tar.gz

RUN set -xe \
    && apt-get update -y \
    && apt-get install --no-install-recommends -y \
        python3 \
        python3-pip \
        python-is-python3 \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge --auto-remove \
    && apt-get clean \
    && mkdir /tmp/lal_release \
    && cd /tmp/lal_release \
    && tar -xf ../lal_release.tar.gz -C . --strip-components 1 \
    && ./doinstall /usr/libadalang \
    && pip install /usr/libadalang/share/libadalang/python/*.whl

ENV GPR_PROJECT_PATH="/usr/libadalang/share/gpr:${GPR_PROJECT_PATH}"
ENV LD_LIBRARY_PATH="/usr/libadalang/lib:${LD_LIBRARY_PATH}"
ENTRYPOINT ["/bin/bash"]
