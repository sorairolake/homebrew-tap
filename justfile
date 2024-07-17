# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

alias all := lint-github-actions

# Run default recipe
default: lint-github-actions

# Run the linter for GitHub Actions workflow files
@lint-github-actions:
    actionlint -verbose
