# Function to create a new tag

create_tag() {
    local tag=$1
    git tag $tag
    git push origin $tag
}