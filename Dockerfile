FROM ubuntu:18.04 AS basic
LABEL ruofan he

ENV DEBIAN_FRONTEND noninteractive
ENV PATH /usr/local/texlive/2022/bin/aarch64-linux:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR ~/
COPY install-tl-unx.tar.gz texlive.profile ./
RUN set -xe && \
    apt-get -y update && \
    apt-get install -y \
        make \
        wget \
        sudo \
        xzdec && \
    apt upgrade perl -y && \
    apt autoremove -y && \
    apt-get clean && \
    tar xvf install-tl-unx.tar.gz && \
    sudo ./install-tl-2*/install-tl -no-gui --profile texlive.profile
    
RUN mkdir /texsrc

WORKDIR /texsrc

VOLUME /texsrc

CMD ["/bin/bash"]

FROM basic AS addon
RUN tlmgr install subfiles multirow braket comment