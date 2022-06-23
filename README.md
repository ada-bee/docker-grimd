# grimd
Multi architecture builds of [looterz/grimd](https://github.com/looterz/grimd).

Compared to the official releases:
* Added builds for ARMv7 and ARMv8
* Persistent config volume
* Based on Google's [Distroless](https://github.com/GoogleContainerTools/distroless)

# Usage
      dns:
        image: ghcr.io/ada-bee/grimd
        container_name: grimd
        restart: unless-stopped
        volumes:
          - type: bind
            source: /opt/grimd
            target: /config
        ports:
          - "53:53/tcp"
          - "53:53/udp"
