FROM tensorflow/tensorflow:1.10.0-gpu-py3

COPY installer.sh /tmp/installer.sh
RUN sh /tmp/installer.sh && \
    rm /tmp/installer.sh && \
    mkdir /app/

COPY runner.sh /app/runner.sh
COPY tsv_to_csv.py /app/tsv_to_csv.py
COPY time_it.sh /time_it.sh

WORKDIR /app
ENTRYPOINT ["bash", "runner.sh"]
