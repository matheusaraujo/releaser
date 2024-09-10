# Function to generate release note

generate_release_notes() {
    local from_tag=$1
    local to_tag=$2
    git log --pretty=format:"- %s" $from_tag..$to_tag
}