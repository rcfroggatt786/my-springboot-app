#!/bin/bash

# Setup script for Ubuntu 24.04 LTS Lightsail instance
# Run this after launching your instance

set -e  # Exit on any error

echo "🚀 Setting up Spring Boot deployment environment..."

# Update system
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Docker
echo "🐳 Installing Docker..."
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Install Docker Compose
echo "🐳 Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Add user to docker group
echo "👤 Adding user to docker group..."
sudo usermod -aG docker $USER

# Install useful tools
echo "🛠️ Installing useful tools..."
sudo apt install -y curl wget unzip tree htop

# Install certbot for Let's Encrypt
echo "🔒 Installing certbot for SSL certificates..."
sudo apt install -y certbot

# Create project directory
echo "📁 Creating project directory..."
mkdir -p ~/myapp/{nginx,ssl,data}

# Create basic nginx html directory
mkdir -p ~/myapp/nginx/html

# Set up firewall
echo "🔥 Configuring firewall..."
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw --force enable

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Logout and login again to apply docker group changes"
echo "2. Clone your repository to ~/myapp"
echo "3. Copy .env.template to .env and set your database password"
echo "4. Run: docker-compose up -d"
echo ""
echo "💡 To test Docker: docker --version && docker-compose --version"
