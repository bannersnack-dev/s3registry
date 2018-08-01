FROM registry:2.6.2

LABEL org.label-schema.vendor="bannersnack" \
    org.label-schema.name="bs-registry-s3" \
    org.label-schema.description="Registry image with S3 storage" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.docker.cmd.devel="" \
    org.label-schema.docker.params="AWS_BUCKET=S3 bucket name,\
    AWS_REGION=AWS Region to use,\
    AWS_ACCESS_KEY_ID=Your account key,\
    AWS_SECRET_ACCESS_KEY=Your account secret,\
    STORAGE_PATH=S3 bucket directory to use" \
    org.label-schema.build-date=$build_date

ENV STORAGE_PATH="/" ENCRYPT=true SECURE=false

COPY ./distr-s3/docker-entrypoint.sh  /

RUN apk update && apk add bash
RUN chmod +x /docker-entrypoint.sh

RUN apk add --update python py-pip python-dev

RUN pip install awscli

ENTRYPOINT ["/docker-entrypoint.sh"]

COPY ./distr-s3/etc/docker/registry/config.yml /etc/docker/registry/config.yml

CMD ["/etc/docker/registry/config.yml"]
