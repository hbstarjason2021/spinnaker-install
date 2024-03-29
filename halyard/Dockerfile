FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt upgrade -y && \
    apt install curl -y && \
    apt clean && \
    apt autoclean && \
    find /var/lib/apt/lists/ -maxdepth 1 -type f -print0 | xargs -0 rm

# INSTALL JAVA  & software-properties-common
RUN apt update && \
    apt-get install openjdk-11-jdk software-properties-common -y && \
    java -version && \
    apt clean && \
    apt autoclean && \
    find /var/lib/apt/lists/ -maxdepth 1 -type f -print0 | xargs -0 rm

WORKDIR /root/

# INSTALL HALYARD
RUN curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh && \
    adduser --system --uid 1000 --group spinnaker && \
    bash InstallHalyard.sh --user spinnaker -y && \
    echo ". /etc/bash_completion.d/hal" >> /root/.bashrc && \
    apt clean && \
    apt autoclean && \
    find /var/lib/apt/lists/ -maxdepth 1 -type f -print0 | xargs -0 rm

# INSTALL kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    kubectl version --client

ENV AWS_BINARY_RELEASE_DATE=2020-02-22
ENV AWS_CLI_VERSION=1.18.18

RUN curl -f -o /usr/local/bin/aws-iam-authenticator  https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x /usr/local/bin/aws-iam-authenticator

COPY entrypoint.sh /root/entrypoint.sh

# INSTALL WGET AND SYSTEMD
RUN apt update && \
    apt install wget systemd -y && \
    apt clean && \
    apt autoclean && \
    find /var/lib/apt/lists/ -maxdepth 1 -type f -print0 | xargs -0 rm && \
    chmod +x /root/entrypoint.sh

# INSTALL PACKER
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt update && apt install packer -y && \
    apt clean && \
    apt autoclean && \
    find /var/lib/apt/lists/ -maxdepth 1 -type f -print0 | xargs -0 rm

CMD ["/root/entrypoint.sh"]
WORKDIR /root
LABEL org.opencontainers.image.source="https://github.com/hbstarjason2021/spinnaker-install"
