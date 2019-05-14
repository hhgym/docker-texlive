#
# hhgym/docker-texlive
#
# This is an image with a full TeX Live installation and several
# fonts and tools.
# Source: http://github.com/hhgym/docker-texlive/
# License: GNU GENERAL PUBLIC LICENSE, Version 3, 29 June 2007
# The license applies to the way the image is built, while the
# software components inside the image are under the respective
# licenses chosen by their respective copyright holders.
#
FROM ubuntu:19.04
MAINTAINER Marcel Pietschmann <marcel.pietschmann@hhgym.de>

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /home

# RUN apt-get clean
# RUN apt-get update 
# RUN apt-get autoclean -y
# RUN apt-get autoremove -y
RUN apt-get update

RUN apt-get install -y apt-utils

# install utilities
RUN apt-get install -f -y curl wget gnuplot default-jre tex-common texinfo equivs perl-tk perl-doc
    
# install TeX Live and ghostscript as well as other tools
RUN curl -sL http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | tar zxf - && \
    mv install-tl-20* install-tl && \
    cd install-tl && \
    echo "selected_scheme scheme-full" > texlive.profile && \
    chmod +x install-tl && \
    ./install-tl --profile=texlive.profile
