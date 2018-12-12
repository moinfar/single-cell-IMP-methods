FROM r-base

RUN apt-get update -y
RUN apt-get install libcurl4-openssl-dev libssl-dev -y
RUN apt-get clean -y

# install devtools and bioconductor
COPY installer.R /tmp/installer.R
RUN Rscript /tmp/installer.R
RUN rm /tmp/installer.R


