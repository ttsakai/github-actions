# syntax=docker/dockerfile:1
FROM us-docker.pkg.dev/spinnaker-community/docker/halyard:stable AS halyard

FROM google/cloud-sdk:360.0.0
COPY --from=halyard /opt/halyard /opt/halyard

RUN apt install -y kubectl kubectx fzf jq openjdk-11-jre-headless gettext-base
RUN useradd -ms /bin/bash spinnaker

RUN echo 'alias kc="kubectl"' >> /home/spinnaker/.bashrc
RUN echo 'alias kx="kubectx"' >> /home/spinnaker/.bashrc
ENV PATH="/opt/halyard/bin:${PATH}"

USER spinnaker

WORKDIR /home/spinnaker
