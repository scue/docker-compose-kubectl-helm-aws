FROM docker/compose:debian-1.27.4

ENV HELM_VERSION="v3.3.4"
ENV KUBECTL_VERSION="v1.18.8"

# net tools
RUN apt update \
    && apt install -y curl ca-certificates iputils-ping dnsutils net-tools iproute2 \
    && apt install -y python3 python3-pip make git upx \
    && rm -rf /var/lib/apt/lists/*

# kubectl
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod 755 /usr/local/bin/kubectl

# helm
RUN curl -L  https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o /tmp/helm.tar.gz \
    && tar -xf /tmp/helm.tar.gz -C /tmp \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
    && chmod 755 /usr/local/bin/helm \
    && rm -rvf /tmp/helm.tar.gz /tmp/linux-amd64

# aws cli
RUN pip3 install awscli