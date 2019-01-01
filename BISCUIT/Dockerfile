FROM moinfar/bio-r-base:3.5.1

COPY installer.R /tmp/installer.R
RUN Rscript /tmp/installer.R && \
    rm /tmp/installer.R && \
    mkdir /app/

RUN git clone https://github.com/sandhya212/BISCUIT_SingleCell_IMM_ICML_2016.git /app/
COPY runner.R /app/runner.R

WORKDIR /app
ENTRYPOINT ["Rscript", "runner.R"]
