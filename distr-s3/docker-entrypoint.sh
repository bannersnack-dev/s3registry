#! /bin/bash

# define the path for registry config
config_file=/etc/docker/registry/config.yml

# copy the htpasswd file from s3
aws s3 cp s3://$HTPASSWD_PATH/htpasswd /var/lib/htpasswd

# populate the config.yml woth proper values
cat $config_file | \
    sed "s@#STORAGE_PATH#@$STORAGE_PATH@g" |\
    sed "s@#AWS_BUCKET#@$AWS_BUCKET@g" |\
    sed "s@#AWS_REGION#@$AWS_REGION@g" |\
    sed "s@#AWS_ACCESS_KEY_ID#@$AWS_ACCESS_KEY_ID@g" |\
    sed "s@#AWS_SECRET_ACCESS_KEY#@$AWS_SECRET_ACCESS_KEY@g" |\
    sed "s@#ENCRYPT#@$ENCRYPT@g" |\
    sed "s@#SECURE#@$SECURE@g" |\
    sed "s@#HTPASSWD_REALM#@$HTPASSWD_REALM@g" > /tmp/config-registry.yml

mv /tmp/config-registry.yml $config_file

# Run the Docker CMD passed in
exec /entrypoint.sh "$@"