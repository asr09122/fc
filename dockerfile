FROM n8nio/n8n

USER root

# Install Python and yt-dlp dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    curl \
    git

# Install yt-dlp
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

# Install the community node (published version)
RUN cd /usr/local/lib/node_modules/n8n && \
    npm install @endcycles/n8n-nodes-youtube-transcription@latest

USER node
