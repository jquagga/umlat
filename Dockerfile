# micromaba
FROM ghcr.io/mamba-org/micromamba:latest@sha256:9122854efe1011ac8af74c4ab0ad5bba94a201c3d75652660bd4ffaa851a2023
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /tmp/environment.yml
RUN micromamba install -y -n base -f environment.yml && \
    micromamba clean --all --yes

ARG MAMBA_DOCKERFILE_ACTIVATE=1
WORKDIR /build
RUN git clone https://github.com/wiedehopf/mlat-client /build 
RUN python setup.py build && \
    python setup.py install 

ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "mlat-client"]
