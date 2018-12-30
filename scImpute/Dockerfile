FROM moinfar/bio-r-base

COPY installer.R /tmp/installer.R
RUN Rscript /tmp/installer.R && \
    rm /tmp/installer.R && \
    mkdir /app/

COPY runner.R /app/runner.R

WORKDIR /app
ENTRYPOINT ["Rscript", "runner.R"]
