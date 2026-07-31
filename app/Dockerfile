# Stage 1: Build dependencies in a virtual environment
FROM python:3.12-slim AS builder

# Install system dependencies needed for compiling Python packages if necessary
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        build-essential && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Create a virtual environment to keep dependencies isolated and small
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade \
    pip \
    setuptools \
    wheel && \
    pip install --no-cache-dir -r requirements.txt

# Stage 2: Create the minimal runner image
FROM python:3.12-slim AS runner

LABEL org.opencontainers.image.title="Flask Demo"
LABEL org.opencontainers.image.vendor="Vinay"
LABEL org.opencontainers.image.source="https://github.com/<your-repo>"

# Create a non-privileged system user and group
RUN groupadd -g 10001 -r appgroup && \
    useradd -u 10001 -g appgroup -r -d /app -s /usr/sbin/nologin appuser

WORKDIR /app

# Copy the virtual environment from the builder stage
COPY --from=builder --chown=appuser:appgroup /opt/venv /opt/venv

# Copy the application source code
COPY --chown=appuser:appgroup app.py .

# Update PATH to use the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Set the environment to run in unbuffered mode (good for logs)
ENV PYTHONUNBUFFERED=1

# Expose the service port
EXPOSE 8080

# Switch to the non-root user
USER 10001

CMD ["python", "app.py"]
