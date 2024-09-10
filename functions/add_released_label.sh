# Function to add "released" label to referenced PRs and issues

add_released_label() {
    local from_tag=$1
    local to_tag=$2
    local repo=$(git config --get remote.origin.url | sed 's/.*:\(.*\).git/\1/')
    
    # Get all PR numbers and issue numbers from commit messages
    local items=$(git log --pretty=format:"%s" $from_tag..$to_tag | grep -oP '#\K\d+' | sort -u)
    
    for item in $items; do
        # Try to add label to PR first, if it fails, try adding to issue
        curl -X POST "https://api.github.com/repos/$repo/issues/$item/labels" \
             -H "Authorization: token $GITHUB_TOKEN" \
             -H "Accept: application/vnd.github.v3+json" \
             -d '{"labels":["released"]}' || true
    done
}