#docker build . -t bosschaert/rde_dc:1
docker buildx build --platform linux/arm64,linux/amd64 --tag bosschaert/rde_dc:1 .
