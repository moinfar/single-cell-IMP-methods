FROM moinfar/bio-r-base:3.5.1

COPY installer.R /tmp/installer.R
RUN apt-get install -y libgsl-dev && \
    Rscript /tmp/installer.R && \
    rm /tmp/installer.R && \
    mkdir /app/

COPY runner.R /app/runner.R

WORKDIR /app
ENTRYPOINT ["Rscript", "runner.R"]
