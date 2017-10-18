# GitHub Team's Repositories Resource

Tracks the commits for Git repositories belonging to a GitHub Team. The resource will also track addition/removal of repositories to the team.

## Resource Type Configuration

Since this resource-type is not shipped as a built-in concourse resource-type, it needs to be configured as a custom resource-type in your concourse pipeline like so:

```yml
resource_types:
- name: github-team-repos
  type: docker-image
  source:
    repository: maliksalman/github-team-repos-resource
    tag: "1.0"
```

## Resource Configuration

The following parameters are involved when configuring such a resource. 

* `org`: *Required.* The GitHub organization. If your team's repositories page is located at `https://github.com/orgs/pivotalservices/teams/app-0/repositories` then the org value to use is `pivotalservices`

* `team`: *Required.* The team name belonging to the above organization.If your team's repositories page is located at `https://github.com/orgs/pivotalservices/teams/app-0/repositories` then the team value to use is `app-0`

* `auth_token`: *Required.* A GitHub authorization token that has access to list all repositories for the given GitHub team. Also, the token needs to have read access (clone, pull) to all the repositories belonging to the team.

* `repos_excluded`: *Optional.* List of the repository names that should NOT be tracked. The name is in the format of `{org-name}/{repo-name}` - for example `pivotalservices/modernization-cookbook-template`

### Example

Sample Resource configuration:

``` yaml
resources:
- name: my-team-repos
  type: github-team-repos
  source:
    auth_token: {{GITHUB_AUTH_TOKEN}}
    org: pivotalservices
    team: app-0
    repos_excluded:
    - pivotalservices/modernization-cookbook-template
    - pivotalservices/transformation-recipes-aggregator
```

## Behavior

### `check`: Check for new commits.

All repositories belonging to GitHub team are cloned (or pulled if already present), and refs
for `HEAD` are returned for each repository. Since concourse can only deal with version information as a single string value, and we need to return refs for multiple repos, the information is formatted as a JSON string and passed through `base64` to get a single value 

### `in`: Clone the repositories, at the given refs.

Clones the repositories to the destination, and locks them down to the given refs.
It will return the same given base64'd refs as version.

### `out`: Undefined and not implemented

This resource does not support pushing back any changes to the team's repositories
