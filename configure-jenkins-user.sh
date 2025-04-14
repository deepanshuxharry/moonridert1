#!/bin/bash

# Exit on error
set -e

# ----- CONFIGURATION SECTION -----
# Jenkins user and Kubernetes configuration paths
JENKINS_HOME="/var/lib/jenkins"
JENKINS_KUBE="$JENKINS_HOME/.kube"
SUDOERS_FILE="/etc/sudoers.d/jenkins"
MINIKUBE_DIR="/root/.minikube"
# -------------------------------

# ----- CREATE JENKINS USER IF NOT EXISTS -----
if id "jenkins" &>/dev/null; then
    echo "[INFO] Jenkins user already exists."
else
    echo "[INFO] Creating Jenkins user..."
    useradd -m -s /bin/bash jenkins
fi

# ----- ADD JENKINS USER TO NECESSARY GROUPS -----
echo "[INFO] Adding Jenkins user to sudo, docker, and root groups..."

# Add Jenkins to the sudo group
usermod -aG wheel jenkins

# Add Jenkins to the docker group
usermod -aG docker jenkins

# Add Jenkins to the root group (for access to minikube configuration)
usermod -aG root jenkins

# Restart Jenkins service to apply changes
sudo systemctl restart jenkins

# ----- CREATE PASSWORDLESS SUDOERS ENTRY -----
echo "[INFO] Creating sudoers entry for passwordless sudo..."

# Create a sudoers file for Jenkins (allowing passwordless sudo)
echo "jenkins ALL=(ALL) NOPASSWD:ALL" > "$SUDOERS_FILE"
chmod 440 "$SUDOERS_FILE"

# ----- SET UP KUBERNETES CONFIGURATION FOR JENKINS -----
echo "[INFO] Setting up .kube config for Jenkins..."

# Create .kube directory for Jenkins if not exists
mkdir -p "$JENKINS_KUBE"

# Copy the root user's kube config to Jenkins
cp "/root/.kube/config" "$JENKINS_KUBE/config"

# Ensure Jenkins has ownership of the .kube config
chown -R jenkins:jenkins "$JENKINS_KUBE"

# ----- SET MINIKUBE CONFIG ACCESS FOR JENKINS -----
echo "[INFO] Configuring Minikube access for Jenkins..."

# Set proper ownership and permissions for the Minikube directory
chown -R root:root "$MINIKUBE_DIR"
chmod -R 770 "$MINIKUBE_DIR"

# ----- SET JENKINS SHELL TO BASH (OPTIONAL BUT RECOMMENDED) -----
echo "[INFO] Setting shell to bash for Jenkins..."

# Set Jenkins user shell to bash for ease of use
usermod -s /bin/bash jenkins

# ----- FINAL STATUS MESSAGE -----
echo "[✅ DONE] Jenkins user is now configured with sudo, docker, Kubernetes access, and Minikube configuration."
