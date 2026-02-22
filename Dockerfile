FROM oven/bun:1-alpine

WORKDIR /app

RUN apk add --no-cache bash tzdata

COPY scripts ./scripts
COPY deploy/run-digest.sh /usr/local/bin/run-digest.sh
COPY deploy/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/run-digest.sh /usr/local/bin/entrypoint.sh && \
    mkdir -p /app/output /app/logs

ENV DIGEST_HOURS=48
ENV DIGEST_TOP_N=15
ENV DIGEST_LANG=zh
ENV DIGEST_OUTPUT_DIR=/app/output
ENV DIGEST_CRON="0 8 * * *"
ENV TZ=Asia/Shanghai

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
