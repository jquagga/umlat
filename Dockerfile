# Mostly from: https://github.com/GoogleContainerTools/distroless/blob/main/examples/python3-requirements/Dockerfile
# Build a virtualenv using the appropriate Debian release

FROM debian:12-slim@sha256:ccb33c3ac5b02588fc1d9e4fc09b952e433d0c54d8618d0ee1afadf1f3cf2455 AS build
RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes git python3-venv gcc libpython3-dev
WORKDIR /app
RUN git clone https://github.com/wiedehopf/mlat-client
WORKDIR /app/mlat-client
RUN python3 -m venv /venv && \
    . /venv/bin/activate && \
    python3 setup.py build && \
    python3 setup.py install

# Copy the virtualenv into a distroless image
FROM gcr.io/distroless/python3-debian12:nonroot@sha256:95f5fa82f7cc7da0e133a8a895900447337ef0830870ad8387eb4c696be17057
COPY --from=build /venv /venv
ENTRYPOINT ["/venv/bin/mlat-client"]
