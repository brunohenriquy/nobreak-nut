FROM debian

## Set the user and group IDs inside the container
#ARG USER_ID
#ARG GROUP_ID
#
## Create a non-root user with the specified IDs
#RUN groupadd -g $GROUP_ID nut && \
#    useradd -u $USER_ID -g $GROUP_ID -m -s /bin/bash nut

# Install dependencies and NUT packages
RUN apt-get update && \
    apt-get install -y nut-client nut-server && \
    rm -rf /var/lib/apt/lists/*

# Copy the custom files
COPY ups.conf /etc/nut/ups.conf
COPY upsd.conf /etc/nut/upsd.conf
COPY nut.conf /etc/nut/nut.conf

# Entry point
CMD ["./startup.sh"]
