# Function to determine the next version

determine_next_version() {
    local latest_tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "0.0.0")
    local next_version=$(gitversion /output json /showvariable SemVer)
    echo "$next_version"
}