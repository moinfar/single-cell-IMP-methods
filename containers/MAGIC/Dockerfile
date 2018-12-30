FROM moinfar/bio-py-base:3.6

COPY installer.sh /tmp/installer.sh
RUN sh /tmp/installer.sh && \
    rm /tmp/installer.sh

RUN mkdir /app/
COPY runner.py /app/runner.py

WORKDIR /app
ENTRYPOINT ["python", "runner.py"]
