FROM n8nio/n8n

USER root

# Install Python, pip, curl, and bash on Alpine
RUN apk add --no-cache \
    python3 \
    py3-pip \
    curl \
    bash \
    && ln -sf python3 /usr/bin/python \
    && ln -sf pip3 /usr/bin/pip \
    && pip install --upgrade --break-system-packages pip setuptools wheel

# Install yt-dlp
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
    -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

# Install the community node directly from GitHub
RUN cd /usr/local/lib/node_modules/n8n && \
    npm install github:endcycles/n8n-nodes-youtube-transcript

USER node
