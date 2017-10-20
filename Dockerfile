FROM alpine:3.5
RUN apk add --no-cache bash jq git curl 
COPY assets/* /opt/resource/
