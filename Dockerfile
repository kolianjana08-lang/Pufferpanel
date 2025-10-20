# Base image
FROM ubuntu:22.04

# Install dependencies
RUN apt update && apt install -y curl apt-transport-https ca-certificates gnupg lsb-release

# Add PufferPanel repository and install
RUN curl -fsSL https://packagecloud.io/pufferpanel/pufferpanel/gpgkey | gpg --dearmor -o /usr/share/keyrings/pufferpanel-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/pufferpanel-archive-keyring.gpg] https://packagecloud.io/pufferpanel/pufferpanel/ubuntu/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/pufferpanel.list && \
    apt update && apt install -y pufferpanel

# Create admin user (default: admin@example.com / admin123)
RUN pufferpanel user add --email admin@example.com --password admin123 --name Admin

# Expose the web port
EXPOSE 8080

# Run PufferPanel
CMD ["pufferpanel", "run", "--port", "8080"]
