# micromaba
FROM ghcr.io/mamba-org/micromamba:latest@sha256:41213830594b228d1b95a35b556fbbbf11cfa2b9ad3790d58694b00d18de94a0
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /tmp/environment.yml
RUN micromamba install -y -n base -f environment.yml && \
    micromamba clean --all --yes

ARG MAMBA_DOCKERFILE_ACTIVATE=1
WORKDIR /build
RUN git clone https://github.com/wiedehopf/mlat-client /build 
RUN python setup.py build && \
    python setup.py install 

ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "mlat-client"]
