FROM node:14-alpine

# By default, this container runs as root.
# If desired, you can uncomment USER node to run as the non-root 'node' user (UID/GID 1000:1000).
# On Linux, to match host UID/GID and avoid permission issues with mounted volumes,
# consider building the image with custom ARGs for USER_ID and GROUP_ID.
# UID/GID 1000:1000 usually maps to your first Linux user (e.g., "ilona" in my case).
#
# 🔧 Quick fix used during development:
# If permission errors occur when writing to mounted volumes,
# add write permissions to the project directory:
# chmod -R a+w /path/to/your/project
#
# ⚠ Note: Matching the container user to your local Linux user (UID/GID)
# makes the image less portable across different environments.
# For local Utility Containers, this trade-off is usually acceptable.

# USER node

WORKDIR /app

ENTRYPOINT [ "npm" ]