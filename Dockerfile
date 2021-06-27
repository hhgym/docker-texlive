#
# hhgym/docker-texlive
#
# This is an image with a full TeX Live installation and several
# fonts and tools (gnuplot, java for arara).
# Source: http://github.com/hhgym/docker-texlive/
# License: GNU GENERAL PUBLIC LICENSE, Version 3, 29 June 2007
# The license applies to the way the image is built, while the
# software components inside the image are under the respective
# licenses chosen by their respective copyright holders.
#
# tex package's version: 2021-06-27
#
FROM ubuntu:20.04
MAINTAINER Marcel Pietschmann <marcel.pietschmann@hhgym.de>

ENV DEBIAN_FRONTEND=noninteractive

COPY texlive.profile /

# install utilities
RUN apt-get clean && \
    apt-get update  && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    apt-get update && \
    apt-get install -y apt-utils && \
    apt-get install -f -y curl wget gnuplot default-jre

# install TeX Live
RUN curl -sL http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | tar zxf - && \
    mv install-tl-20* install-tl && \
    cd install-tl && \
    echo "selected_scheme scheme-full" > texlive.profile && \
    chmod +x install-tl && \
    ./install-tl --profile /texlive.profile

ENV PATH /usr/local/texlive/2021/bin/x86_64-linux:$PATH
CMD ["tlmgr", "--version"]
