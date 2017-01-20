FROM ubuntu:16.10

RUN apt-get update
RUN apt-get install apt-utils
RUN apt-get dist-upgrade -y
RUN apt-get install language-pack-en -y
RUN locale -a
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN update-locale
RUN locale
RUN apt-get install -y snapcraft make tree xvfb wget snapd
