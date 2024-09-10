# Function to create a GitHub release

create_github_release() {
    local tag=$1
    local release_notes=$2
    local repo=$(git config --get remote.origin.url | sed 's/.*:\(.*\).git/\1/')
    
    curl -X POST "https://api.github.com/repos/$repo/releases" \
         -H "Authorization: token $GITHUB_TOKEN" \
         -H "Accept: application/vnd.github.v3+json" \
         -d "{
              \"tag_name\": \"$tag\",
              \"name\": \"Release $tag\",
              \"body\": \"$release_notes\",
              \"draft\": false,
              \"prerelease\": false
            }"
}