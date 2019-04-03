FROM tiangolo/nginx-rtmp

RUN apt update && apt-get install apache2-utils

COPY rootfs /

CMD [ "/start.sh" ]