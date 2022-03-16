#!/bin/bash

# Copy pre-commit file to git folder
cp pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit