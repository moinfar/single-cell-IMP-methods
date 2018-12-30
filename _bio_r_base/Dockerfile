ARG rver
FROM r-base:$rver

RUN apt-get update -y && \
    apt-get install libcurl4-openssl-dev libssl-dev -y && \
    apt-get clean -y

# install devtools and bioconductor
COPY installer.R /tmp/installer.R
RUN Rscript /tmp/installer.R && \
    rm /tmp/installer.R


