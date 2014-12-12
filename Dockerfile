FROM ubuntu:14.04.1

RUN apt-get update
RUN apt-get install -y python-pip groff
RUN pip install awscli