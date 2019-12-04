FROM ohoareau/ci-aws:latest

RUN apt-get update -y && \
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
    (curl -sL https://deb.nodesource.com/setup_13.x | bash -) && \
    (curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -) && \
    (echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list) && \
    apt-get update -y && \
    apt-get install -y git build-essential zip unzip nodejs yarn && \
    hash -r -d npm && \
    apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/.npm/cache/*

ENV TERRAFORM_VERSION 0.12.17

RUN mkdir /tmp/terraform && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o /tmp/terraform/terraform.zip && \
    cd /tmp/terraform && \
    unzip terraform.zip && \
    mv terraform /bin/terraform && \
    chmod +x /bin/terraform && \
    rm -rf /tmp/terraform

COPY ./scripts/terraform-cloud-api-token-set.sh /usr/local/bin/terraform-cloud-api-token-set

WORKDIR /code
