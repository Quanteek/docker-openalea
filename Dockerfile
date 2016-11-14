FROM ubuntu:14.04
MAINTAINER quanteek

#dependencies
RUN apt-get update -y
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:christophe-pradal/openalea
RUN add-apt-repository ppa:christophe-pradal/vplants
RUN add-apt-repository ppa:christophe-pradal/alinea
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y python-openalea python-vplants python-alinea

#specific tasks
RUN alea_config

#create user
RUN useradd -ms /bin/bash user01
WORKDIR /home/user01

COPY install_packages.R /home/user01/
RUN Rscript install_packages.R
USER user01
RUN echo "library(\"sensitivity\")" > ~/.Rprofile
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/python2.7/dist-packages/lib/
