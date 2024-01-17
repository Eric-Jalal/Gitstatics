#!/bin/bash

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it first."
    exit 1
fi

# Set your GitHub organization
ORG_NAME="your_organization"

# Get a list of repositories in the organization
repositories=$(gh repo list "$ORG_NAME" --json name --limit 1000 | jq -r '.[].name')

# Initialize variables for average time and cost
total_time=0
total_cost=0
workflow_count=0

echo "Fetching statistics for GitHub Actions workflows in organization: $ORG_NAME"

for repo in $repositories; do
    echo "Processing repository: $repo"
    
    # Get the list of workflows for the repository
    workflows=$(gh workflow list --repo "$ORG_NAME/$repo" --json name --limit 1000 | jq -r '.[].name')

    for workflow in $workflows; do
        echo "  Processing workflow: $workflow"
        
        # Get the details of the workflow run
        run_details=$(gh run view latest -R "$ORG_NAME/$repo" -w "$workflow" --json status,conclusion,created_at,updated_at,run_duration_ms)

        # Check if the workflow run is completed successfully
        conclusion=$(echo "$run_details" | jq -r '.conclusion')
        if [ "$conclusion" == "success" ]; then
            # Calculate the time the workflow took to run (in minutes)
            created_at=$(echo "$run_details" | jq -r '.created_at')
            updated_at=$(echo "$run_details" | jq -r '.updated_at')
            duration_ms=$(echo "$run_details" | jq -r '.run_duration_ms')
            duration_min=$((duration_ms / 60000))
            
            # Calculate the processing power consumed by the workflow (in credits)
            cost=$(gh run view "$ORG_NAME/$repo" -w "$workflow" --json billable)

            # Update the total time and cost
            total_time=$((total_time + duration_min))
            total_cost=$((total_cost + cost))
            ((workflow_count++))
        fi
    done
done

# Calculate average time and cost
average_time=$((total_time / workflow_count))
average_cost=$((total_cost / workflow_count))

echo "==========================="
echo "Summary for organization: $ORG_NAME"
echo "==========================="
echo "Average time for longest-running workflow: $average_time minutes"
echo "Average cost of workflows: $average_cost credits"

