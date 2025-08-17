FROM n8nio/n8n

USER root

# Install Python, pip, and curl
RUN apk add --no-cache \
    python3 \
    py3-pip \
    curl

# Install yt-dlp
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
    -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

# Install the community node
RUN cd /usr/local/lib/node_modules/n8n && \
    npm install @endcycles/n8n-nodes-youtube-transcript

USER node
