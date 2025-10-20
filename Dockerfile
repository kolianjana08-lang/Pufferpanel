FROM ubuntu:22.04

# Install dependencies
RUN apt update && apt install -y curl apt-transport-https ca-certificates gnupg lsb-release

# Add PufferPanel repository and install
RUN curl -fsSL https://packagecloud.io/pufferpanel/pufferpanel/gpgkey | gpg --dearmor -o /usr/share/keyrings/pufferpanel-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/pufferpanel-archive-keyring.gpg] https://packagecloud.io/pufferpanel/pufferpanel/ubuntu/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/pufferpanel.list && \
    apt update && apt install -y pufferpanel

# Ensure data directories exist
RUN mkdir -p /var/lib/pufferpanel/email \
    && mkdir -p /var/lib/pufferpanel/servers \
    && mkdir -p /var/lib/pufferpanel/settings

# Environment variables
ENV PUFFERPANEL_PORT=8080
ENV PUFFERPANEL_DATA_DIR=/var/lib/pufferpanel

# Create admin user
RUN pufferpanel user add --email admin@example.com --password admin123 --name Admin

# Expose port
EXPOSE 8080

# Start PufferPanel
CMD ["pufferpanel", "run"]
