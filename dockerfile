FROM n8nio/n8n:latest

# ── root phase ──────────────────────────────────────────
USER root

# Install Python, pip and curl.
# • First try Debian/Ubuntu (apt); if that fails, fall back to Alpine (apk).
RUN (apt-get update && \
     apt-get install -y python3 python3-pip curl && \
     rm -rf /var/lib/apt/lists/*) || \
    (apk add --no-cache python3 py3-pip curl)

# Add yt-dlp binary
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
        -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

# Install the YouTube-Transcript community node
RUN cd /usr/local/lib/node_modules/n8n \
    && npm install @endcycles/n8n-nodes-youtube-transcript

# ── n8n runtime settings ───────────────────────────────
ENV N8N_HOST=0.0.0.0
ENV N8N_PROTOCOL=https
ENV N8N_PORT=${PORT:-5678}

USER node
EXPOSE 5678

CMD ["n8n"]
