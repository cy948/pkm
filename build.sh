#!/usr/bin/env bash
# dendron-publish-site.sh
# This script should exist in the root of your workspace

# Remove docs directory if present
rm -rf docs

# Uncomment if wishing to remove cache
# Recommended: Leave cache alone to increase speed of deployments
#rm -rf .next
#rm -rf node_modules

# Install latest version of Dendron
# yarn add @dendronhq/dendron-cli@latest
# OPTIONALLY
# Install version of Dendron from yarn.lock in workspace root
# To use:
# Uncomment the next line, and comment out the other `yarn install ...` line
yarn

# Update Dendron Next.js if needed
# do not update!!!!
# (test -d .next) && (echo 'updating dendron next...' && cd .next && git reset --hard && git pull && yarn && cd ..) || (echo 'init dendron next' && yarn dendron publish init)

# Generate static site with nextjs
echo 'init dendron next' && yarn dendron publish init
yarn dendron publish export

# Move generated website to docs directory in workspace root
cp .next/out docs