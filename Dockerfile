FROM alpine:3.3

RUN apk update
RUN apk add python py-pip py-setuptools ca-certificates groff less
RUN pip install awscli
