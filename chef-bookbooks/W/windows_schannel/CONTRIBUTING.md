# Contributing to this Cookbook

We're glad you want to contribute to this cookbooks! The first step is the desire to improve the project.

## Submitting Issues

Please create an issue with this repo, please include as much detail as you can to help troubleshoot the issue

## Contribution Process

1. Commit changes to a git branch

2. Create a GitHub Pull Request for your change, following the instructions in the pull request template.
3. Perform a [Code Review](#code-review-process) with the cookbook maintainers on the pull request.

### Pull Request Requirements

All pull requests must meet these specifications:

1. **Tests:** To ensure high quality code and protect against future regressions, we require all cookbook code to be tested in some way. This can be either unit testing with ChefSpec or integration testing with Test Kitchen / InSpec. See the TESTING.md file for additional information on testing in Chef cookbooks and feel free to ask if you need help with the testing process.

Run the `rake` command to validate your work

### Code Review Process

Code review takes place in GitHub pull requests. See [this article](https://help.github.com/articles/about-pull-requests/) if you're not familiar with GitHub Pull Requests.

Once you open a pull request, cookbook maintainers will review your code using the built-in code review process in Github PRs. The process at this point is as follows:

1. A cookbook maintainer will review your code and merge it if no changes are necessary. Your change will be merged into the cookbooks's `master` branch and will be noted in the cookbook's `CHANGELOG.md` at the time of release.
2. If a maintainer has feedback or questions on your changes they they will set `request changes` in the review and provide an explanation.

## Release Cycle

The versioning for Cookbook projects is X.Y.Z.

- X is a major release, which may not be fully compatible with prior major releases
- Y is a minor release, which adds both new features and bug fixes
- Z is a patch release, which adds just bug fixes

