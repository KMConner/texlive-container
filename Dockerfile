FROM ubuntu:20.04

RUN --mount=type=cache,target=/var/lib/apt/lists \
    apt-get update && \
    apt-get install -y --no-install-recommends wget ghostscript ca-certificates libparent-perl && \
    apt-get -y autoclean

RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
RUN tar xvf install-tl-unx.tar.gz

COPY ./texlive.profile ./
RUN perl /install-tl-20*/install-tl --profile=texlive.profile

## x86_64-linux
