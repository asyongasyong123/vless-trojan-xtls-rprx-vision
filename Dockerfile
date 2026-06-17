FROM ghcr.io/xtls/xray-core:latest AS xray

FROM openresty/openresty:alpine

COPY --from=xray /usr/bin/xray /usr/local/bin/xray
RUN chmod +x /usr/local/bin/xray && \
    apk add --no-cache ca-certificates

COPY config.json /etc/xray/config.json
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

ENV PORT=8080
EXPOSE 8080

CMD ["/bin/sh", "-c", "set -e; xray run -c /etc/xray/config.json & sleep 6; openresty -g 'daemon off;'"]
