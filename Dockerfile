FROM teddysun/xray:latest AS xray-bin
FROM openresty/openresty:alpine-fat

# Ibutang ang Xray
COPY --from=xray-bin /usr/bin/xray /usr/local/bin/xray
RUN chmod +x /usr/local/bin/xray

# Ibutang ang mga config
COPY config.json /etc/xray/config.json
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

# Ibutang ang port nga gamiton
ENV PORT=8080
EXPOSE 8080

# Saktong pagsugod: Xray una, dayon Nginx
CMD ["/bin/sh", "-c", "set -e; xray run -c /etc/xray/config.json & sleep 2; openresty -g 'daemon off;'"]
