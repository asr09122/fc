FROM n8nio/n8n

USER root

# Install Python, pip, curl, git
RUN apk add --no-cache \
    python3 \
    py3-pip \
    curl \
    git

# Install yt-dlp
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
    -o /usr/local/bin/yt-dlp && chmod a+rx /usr/local/bin/yt-dlp

# Clone and install the node directly from GitHub
RUN git clone https://github.com/endcycles/n8n-nodes-youtube-transcription /tmp/youtube-transcription && \
    cd /usr/local/lib/node_modules/n8n && \
    npm install /tmp/youtube-transcription && \
    rm -rf /tmp/youtube-transcription

USER node
