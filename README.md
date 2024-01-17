# GitHub Actions Statistics

This bash script utilizes the GitHub CLI (gh) to gather statistics about GitHub Actions workflows in all repositories within a specified GitHub organization. It calculates the average time for the longest-running workflow and the average cost (consumed processing power) of workflows.

## Features

- Fetches statistics for GitHub Actions workflows in all repositories of a specified GitHub organization.
- Calculates the average time for the longest-running workflow.
- Calculates the average cost (consumed processing power) of workflows.
- Provides logging statements for better understanding and debugging.

## Prerequisites

- Github CLI `gh` installed and authenticated

## Installation

1. Copy the script content from github_actions_statistics.sh to a file named github_actions_statistics.sh.
2. Make the script executable: 
```bash
chmod +x github_actions_statistics.sh
```
3. Optionally, move the script to a directory included in your $PATH to use it as a global command.

## Usage

1. Set your GitHub organization by modifying the ORG_NAME variable in the script:
```bash
ORG_NAME="your_organization"
```
2. Run the script:
```bash
./github_actions_statistics.sh
```
3. View the generated statistics, including the average time for the longest-running workflow and the average cost of workflows.

## Logging

The script includes logging statements to provide information about the current stage of processing, including the repository and workflow being processed. This facilitates debugging and understanding the script's execution flow.

## Example Output

```bash
Fetching statistics for GitHub Actions workflows in organization: your_organization
Processing repository: repo1
  Processing workflow: workflow1
    ...
    (Output for each workflow run)
    ...
  Processing workflow: workflow2
    ...
    (Output for each workflow run)
    ...
Processing repository: repo2
  Processing workflow: workflow3
    ...
    (Output for each workflow run)
    ...
...

===========================
Summary for organization: your_organization
===========================
Average time for longest-running workflow: <average_time> minutes
Average cost of workflows: <average_cost> credits
```

## Notes

- Ensure that the GitHub CLI (gh) is installed and authenticated.
- Customize the ORG_NAME variable in the script with your GitHub organization name.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

