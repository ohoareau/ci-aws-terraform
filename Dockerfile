FROM ohoareau/ci-aws:latest

RUN apt-get update -y && \
    apt-get install -y curl unzip git && \
    apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV TERRAFORM_VERSION 0.12.13

RUN mkdir /tmp/terraform && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o /tmp/terraform/terraform.zip && \
    cd /tmp/terraform && \
    unzip terraform.zip && \
    mv terraform /bin/terraform && \
    chmod +x /bin/terraform && \
    rm -rf /tmp/terraform
