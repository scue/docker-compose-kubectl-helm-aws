FROM docker/compose:debian-1.27.4

ENV HELM_VERSION="v3.3.4"
ENV KUBECTL_VERSION="v1.18.8"
ENV AWSCLI_VERSION="2.0.30"
ENV UPX_VERSION="3.96"

# net tools
RUN apt update \
    && apt install -y curl ca-certificates iputils-ping dnsutils net-tools iproute2 \
    && apt install -y make git unzip xz-utils \
    && rm -rf /var/lib/apt/lists/*

# upx compress
RUN curl -L https://github.com/upx/upx/releases/download/v${UPX_VERSION}/upx-${UPX_VERSION}-amd64_linux.tar.xz -o /tmp/upx.tar.xz \
    && tar xf /tmp/upx.tar.xz -C /tmp \
    && mv -vf /tmp/upx-${UPX_VERSION}-amd64_linux/upx /usr/local/bin/upx \
    && chmod 755 /usr/local/bin/upx \
    && rm -rvf /tmp/upx.tar.xz /tmp/upx-${UPX_VERSION}-amd64_linux

# kubectl
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod 755 /usr/local/bin/kubectl

# helm
RUN curl -L https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o /tmp/helm.tar.gz \
    && tar -xf /tmp/helm.tar.gz -C /tmp \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
    && chmod 755 /usr/local/bin/helm \
    && rm -rvf /tmp/helm.tar.gz /tmp/linux-amd64

# aws cli
RUN curl -L https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip -o /tmp/awscliv2.zip \
    && unzip /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/aws