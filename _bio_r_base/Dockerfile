ARG rver
# rocker/tidyverse has bioconductor and devtools installed
FROM rocker/tidyverse:$rver

# install base packages
COPY installer.R /tmp/installer.R
RUN Rscript /tmp/installer.R && \
    rm /tmp/installer.R
