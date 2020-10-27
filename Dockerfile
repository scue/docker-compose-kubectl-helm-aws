FROM docker/compose:1.27.4
ENV HELM_VERSION="v3.3.4"
ENV KUBECTL_VERSION="v1.18.8"

# awscli
RUN apk add --no-cache python3 py3-pip upx curl make
RUN pip3 install awscli

# kubectl
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod 755 /usr/local/bin/kubectl

# helm
RUN curl -L  https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o /tmp/helm.tar.gz \
    && tar -xf /tmp/helm.tar.gz -C /tmp \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
    && rm -rvf /tmp/helm.tar.gz /tmp/linux-amd64
