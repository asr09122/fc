FROM n8nio/n8n

USER root

# Install Python + pip + curl + bash on Alpine
RUN apk add --no-cache \
    python3 \
    py3-pip \
    curl \
    bash \
    && python3 -m ensurepip \
    && pip3 install --no-cache --upgrade pip setuptools wheel

# Install yt-dlp
RUN curl -L "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp" -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

# Install the community node
RUN cd /usr/local/lib/node_modules/n8n && \
    npm install --omit=dev @endcycles/n8n-nodes-youtube-transcript

USER node
