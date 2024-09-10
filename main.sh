#!/bin/bash

# Source all function files
source functions/add_released_label.sh
source functions/determine_next_version.sh
source functions/create_tag.sh
source functions/create_github_release.sh
source functions/generate_release_notes.sh

set -e

# Main script
if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN environment variable is not set."
    exit 1
fi

# Determine next version
next_version=$(determine_next_version)
echo "Next version: $next_version"

# Get the current (previous) tag
current_tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "")

# Generate release notes
release_notes=$(generate_release_notes "$current_tag" "HEAD")

# Create new tag
create_tag "$next_version"

# Create GitHub release
create_github_release "$next_version" "$release_notes"

# Add "released" label to referenced PRs and issues
add_released_label "$current_tag" "$next_version"

echo "Release $next_version created successfully!"