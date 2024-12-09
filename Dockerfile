FROM jenkins/jenkins:lts
USER root

# Install Docker and Docker Compose
RUN apt-get update && \
    apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release wget unzip && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin && \
    wget https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip -O terraform.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/terraform && \
    chmod +x /usr/local/bin/terraform && \
    rm terraform.zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# Add jenkins user to docker group
RUN usermod -aG docker jenkins
RUN chmod 666 /var/run/docker.sock || true

USER jenkins

