# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

# Run default recipe
_default:
    just -l

# Run the linter for GitHub Actions workflow files
lint-github-actions:
    actionlint -verbose
