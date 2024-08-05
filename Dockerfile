# micromaba
FROM ghcr.io/mamba-org/micromamba:latest@sha256:954e438daab0ad0835430ea84acb27dd47d1ea35a7120c3c9dd9d1a5578f4b13
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /tmp/environment.yml
RUN micromamba install -y -n base -f environment.yml && \
    micromamba clean --all --yes

ARG MAMBA_DOCKERFILE_ACTIVATE=1
WORKDIR /build
RUN git clone https://github.com/wiedehopf/mlat-client /build 
RUN python setup.py build && \
    python setup.py install 

ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "mlat-client"]
