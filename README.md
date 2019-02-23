# SQLServerRolesToYaml
PowerShell Script to iterate through databases and generate yaml files containing role members for each database

Idea is to control access via GIT pull requests where each database folder has a codeowners file to determine an approver.
People can request access by making a change, database owner approves it and a backend process then handles the provisioning

This script can be used to create the structure and populate existing permissions

