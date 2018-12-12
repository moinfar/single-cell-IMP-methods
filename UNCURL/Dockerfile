FROM moinfar/bio-py-base:2.7

COPY installer.sh /tmp/installer.sh
RUN sh /tmp/installer.sh
RUN rm /tmp/installer.sh

RUN mkdir /app/
COPY runner.py /app/runner.py

WORKDIR /app
ENTRYPOINT ["python", "runner.py"]
