# Stage 1: Building the binary
FROM golang:1.21-bullseye AS builder

# Set working directory
WORKDIR /build

# Clone the repository and checkout the desired version
RUN git clone https://github.com/yourusername/lspd.git . && \
    git checkout <your_desired_tag_or_branch>

# Install dependencies and build the plugin
RUN make release-plugin

# Stage 2: Setup the runtime container
FROM debian:bullseye-slim

# Copy the built binary from the builder stage
COPY --from=builder /build/lspd_cln_plugin /usr/local/bin/

# Set any environment variables needed by the plugin
ENV PLUGIN_VAR=value

# Command to run your application, adjust as needed
CMD ["lspd_cln_plugin"]
