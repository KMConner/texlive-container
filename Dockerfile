FROM ubuntu:20.04

RUN --mount=type=cache,target=/var/lib/apt/lists \
    apt-get update && \
    apt-get install -y --no-install-recommends wget ghostscript ca-certificates libparent-perl build-essential && \
    apt-get -y autoclean

RUN cpan -i App::cpanminus && cpanm Log::Log4perl Log::Dispatch::File YAML::Tiny File::HomeDir Unicode::GCString

WORKDIR /texlive-install
COPY ./texlive.profile ./
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar xvf install-tl-unx.tar.gz --strip-components=1 && \
    perl ./install-tl --profile=texlive.profile && rm -rf /texlive-install

WORKDIR /
RUN ln -sf /usr/local/texlive/*/bin/* /usr/local/bin/texlive
ENV PATH /usr/local/bin/texlive:$PATH
