FROM moinfar/bio-r-base

RUN apt-get update -y
RUN apt-get install git -y
RUN apt-get clean -y

COPY installer.R /tmp/installer.R
RUN Rscript /tmp/installer.R
RUN rm /tmp/installer.R

RUN mkdir /app/
RUN git clone https://github.com/sandhya212/BISCUIT_SingleCell_IMM_ICML_2016.git /app/
COPY runner.R /app/runner.R

WORKDIR /app
ENTRYPOINT ["Rscript", "runner.R"]

