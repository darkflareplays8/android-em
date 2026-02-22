FROM gitpod/workspace-full

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jre-headless xvfb \
    libgl1 libgles2 libpulse0 libnss3 \
    libxss1 libxtst6 libxrandr2 libasound2 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER gitpod
