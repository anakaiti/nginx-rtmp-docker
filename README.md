# nginx-rtmp-docker

```sh
docker run \
    -p 80:80 \
    -p 1935:1935 \
    -e STATS_USER=admin \
    -e STATS_PASSWORD=secret \
    -e PUBLISH_KEY=secret \
    anakaiti/nginx-rtmp-docker
```