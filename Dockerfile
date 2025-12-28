FROM debian:stable-slim

# Create nut system user
RUN groupadd -r nut && \
    useradd -r -g nut -m -s /usr/sbin/nologin nut && \
    usermod -aG dialout nut

# Install NUT and utilities
RUN apt update && \
    apt install -y \
        nut \
        nut-client \
        nut-server \
        net-tools \
        iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Startup script only
COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

# Entry point
CMD ["/usr/local/bin/startup.sh"]
