ARG IMAGE_TAG_FFMPEG=latest \
    VERSION_UV=latest
FROM ghcr.io/astral-sh/uv:${VERSION_UV} AS uv
FROM linuxserver/ffmpeg:${IMAGE_TAG_FFMPEG}
# For compatibility with Visual Studio Code
WORKDIR /workspace
# - Using uv in Docker | uv
#   https://docs.astral.sh/uv/guides/integration/docker/#installing-uv
COPY --from=uv /uv /uvx /bin/
# - Using uv in Docker | uv
#   https://docs.astral.sh/uv/guides/integration/docker/#caching
ENV UV_LINK_MODE=copy
ENTRYPOINT [ "uv", "run" ]
CMD ["pytest"]
