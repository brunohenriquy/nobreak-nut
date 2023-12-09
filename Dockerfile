FROM debian

# Install dependencies and NUT packages
RUN apt-get update && \
    apt-get install -y nut-client nut-server && \
    rm -rf /var/lib/apt/lists/*q:q!:q!

# Copy the custom files
COPY ups.conf /etc/nut/ups.conf
COPY upsd.conf /etc/nut/upsd.conf
COPY nut.conf /etc/nut/nut.conf

# Entry point
CMD ["/bin/bash"]
