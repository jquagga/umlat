# micromaba
FROM ghcr.io/mamba-org/micromamba:latest@sha256:94d6837f023c0fc0bb68782dd2a984ff7fe0e21ea7e533056c9b8ca060e31de2
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /tmp/environment.yml
RUN micromamba install -y -n base -f environment.yml && \
    micromamba clean --all --yes

ARG MAMBA_DOCKERFILE_ACTIVATE=1
WORKDIR /build
RUN git clone https://github.com/wiedehopf/mlat-client /build 
RUN python setup.py build && \
    python setup.py install 

ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "mlat-client"]
