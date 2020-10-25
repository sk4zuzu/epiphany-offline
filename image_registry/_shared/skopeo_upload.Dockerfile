FROM alpine:3

RUN : INSTALL CURL, JQ AND SKOPEO \
 && apk --no-cache add \
    curl jq skopeo
