FROM node:latest as builder

WORKDIR /yacd
RUN git clone https://github.com/haishanh/yacd.git .
RUN yarn && yarn run build


FROM alpine:latest
COPY --from=builder /yacd/public /www
RUN apk update && apk add mini_httpd
EXPOSE 80
ENTRYPOINT ["mini_httpd", "-d", "/www", "-p", "80", "-D"]
