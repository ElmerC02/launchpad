# Contributing to Launchpad

Thanks for contributing to Launchpad. We are learning Terraform, Azure, Git, and GitHub Actions together, so keep changes focused and explainable. Work in small steps and ask questions when something is unclear.

## Branch naming

Use this format:

```text
<type>/<short-description>
```

Use a lowercase type and a short, descriptive, lowercase name with hyphens between words. Branches describe the work, not the person doing it.

| Type | Use for | Example |
| --- | --- | --- |
| `feature/` | New functionality or infrastructure | `feature/terraform-foundation` |
| `fix/` | Fixing a problem | `fix/terraform-validation` |
| `chore/` | Maintenance, tooling, or configuration | `chore/update-terraform-version` |
| `docs/` | Documentation-only changes | `docs/branching-guide` |
| `refactor/` | Restructuring without changing behavior | `refactor/terraform-layout` |

Keep names concise. Do not use spaces, underscores, personal names, or ticket numbers unless the project adopts an issue tracker and agrees to include its IDs. Keep the shared branch named `main`; do work on a branch and open a pull request to `main`. Existing feature branches such as `feature/terraform-foundation` and `feature/github-actions` already follow this convention and do not need renaming.

## Make a change

1. Start from an up-to-date `main` branch, then create a branch using the convention above. If you are unsure how to update or branch safely in GitHub Desktop, ask before discarding or overwriting local work.
2. Keep each branch and pull request focused on one piece of work. Avoid mixing unrelated infrastructure, workflow, and documentation changes.
3. Make small commits with clear messages describing the change. Do not commit credentials, access tokens, Terraform state, plan files, or other generated or sensitive files.
4. Push your branch and open a pull request targeting `main`. Use the repository pull request template, describe what changed and why, and call out infrastructure impact where relevant.
5. Review the diff and address review comments. Merge only after required checks pass and the change has been reviewed by the other contributor.

## Terraform changes

Terraform configuration currently lives in `infra/app/`. Run Terraform commands from that directory so Terraform uses the intended configuration. Do not create a second configuration in another directory without agreeing on a layout change first.

Before proposing Terraform changes, format and validate them from `infra/app/`:

```powershell
terraform fmt -recursive
terraform init -backend=false
terraform validate
```

The GitHub Actions workflow checks formatting, initializes without a backend, and validates configuration. These checks do not authenticate to Azure or deploy resources. Do not run `terraform apply` or change Azure resources unless the project task explicitly calls for it and the responsible contributor has confirmed the intended change.

Commit `.terraform.lock.hcl` when it changes. Do not commit `.terraform/`, `*.tfstate`, `*.tfstate.*`, or `*.tfplan`; keep local state safe and do not delete it as cleanup.

## Pull request checklist

- [ ] Branch name follows the convention above.
- [ ] The change is focused and its purpose is clear.
- [ ] No secrets or Terraform state/plan files are included.
- [ ] Relevant checks pass, or the pull request explains what could not be checked.
- [ ] Documentation is updated when instructions or behavior change.
- [ ] Terraform impact is described for infrastructure changes.
