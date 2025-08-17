FROM n8nio/n8n:latest

USER root

# Install Python and yt-dlp dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install yt-dlp
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
        -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

# Install the YouTube-Transcript community node
RUN cd /usr/local/lib/node_modules/n8n \
    && npm install @endcycles/n8n-nodes-youtube-transcript

# Render-specific n8n settings
ENV N8N_HOST=0.0.0.0
ENV N8N_PROTOCOL=https
ENV N8N_PORT=${PORT:-5678}

USER node
EXPOSE 5678
CMD ["n8n"]
