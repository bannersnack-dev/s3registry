
**Docker registry with s3 bucket storage**

> You need to create an s3 bucket, and credentials for it.

 - generate a username/password for the registry:

    **htpasswd -Bc htpasswd username** *(you will be prompted for the password)*

- Copy the htpasswd file with to s3-bucket input as *HTPASSWD_PATH*. 
- The object path would be ***bucket-name/htpasswd***

**Example docker-compose file:**

    services:
      registry:
        image: bannersnack/s3registry:latest
        container_name: registry
        ports:
          - "5000:5000"
        environment:
          - AWS_BUCKET=registry-example.net
          - AWS_ACCESS_KEY_ID=<enter>
          - AWS_SECRET_ACCESS_KEY=<enter>
          - AWS_REGION=<us-east-1>
          - HTPASSWD_REALM=<registry-example.net>
          - HTPASSWD_PATH=<registry-example.net (s3 bucket name)>
          - STORAGE_PATH=/registry
        networks: 
          - registry
        restart: always