FROM alpine:3.17.2

RUN apk --no-cache add curl

WORKDIR /root/

ADD src ./ 

CMD ["/bin/sh", "./test.sh"]
