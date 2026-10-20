# Launchpad Project Context

## Purpose of This File

This file is the working context for the Launchpad project.

Update it as the project progresses so future work can continue from the current state instead of restarting, repeating setup, or expanding the scope prematurely.

When updating this file:
- Keep the current state accurate.
- Record important decisions and changes.
- Record completed work and known pending work.
- Do not assume branches, files, permissions, or changes are synchronized unless confirmed.
- Keep the immediate goal and current phase clear.

---

## Project

**Name:** Launchpad

Nelo and a friend are learning Terraform, Azure, Git, and GitHub Actions through this shared project.

The long-term goal is to build a live Azure-hosted webpage with infrastructure defined in Terraform and changes deployed through GitHub Actions. Later, the project can expand into an application.

Everything will run in Azure; there is no home lab.

### Learning approach

- Work one manageable step at a time.
- Explain what each command/file does and why it is needed.
- Do not assume Terraform or Git terminology is understood.
- Keep explanations conversational.
- Do not generate README content unless explicitly requested.
- Use sensible enterprise-style practices, but introduce complexity gradually.
- Continue from the current project state rather than restarting or expanding scope unnecessarily.

---

## Current Phase

### Immediate goal

Create **one empty Azure resource group using Terraform**, and have **GitHub Actions check the Terraform code**.

For this first test, do **not** add:

- VM
- Webpage
- Database
- Remote Terraform state
- Automated Azure deployment

### First-test completion criteria

1. ✅ Terraform and GitHub Actions work are completed and merged to `main`.
2. ⏳ Automated Terraform checks pass — the workflow runs `fmt -check`, `init -backend=false` and `validate`; confirm the latest run on `main` is green in the GitHub Actions tab.
3. ❓ Nelo runs Terraform locally and creates the empty resource group — not yet confirmed.
4. ❓ The resource group is confirmed to exist — not yet confirmed.
5. ❓ Nelo's partner has an appropriate Azure role if they need to view/manage the resource — not yet done.
6. Only after this works should the project add shared remote state and automated Azure deployment.

---

## Current Repository

**GitHub repository:** `ElmerC02/launchpad` (https://github.com/ElmerC02/launchpad)

**Nelo's local path:**
`C:\Users\josee\Documents\GitHub\launchpad`

### Files on `main` (as of 2026-10-19)

```text
.github/pull_request_template.md   PR template
.github/workflows/terraform.yml    Terraform CI checks
.gitignore                         Terraform exclusions (state, plans, .terraform/)
README.md                          Required-tools install guide (Windows)
docs/CONTEXT.md                    This file
infra/app/main.tf                  Terraform settings, azurerm provider, resource group
infra/app/.terraform.lock.hcl      Provider lock file (azurerm 4.81.0)
requirements.txt                   Empty — not used yet
```

The README is no longer just `# launchpad`; it is now a setup guide for Git, GitHub Desktop, VS Code, Terraform 1.16.6, the HashiCorp Terraform VS Code extension, and Azure CLI.

### Branches on GitHub

| Branch | Status vs `main` |
| --- | --- |
| `main` | Shared branch. Terraform config and CI workflow are merged (PRs #1–#15). |
| `feature/terraform-foundation` | 1 unmerged commit, `Test`, that deliberately breaks `main.tf` (`source = "hashico rp/azurerm"`, `loca tion = ...`). Appears to be the CI failure test — **must not be merged**. |
| `docs/contributing` | 2 unmerged commits: adds `docs/CONTRIBUTING.md` and updates the PR template. Needs a PR (see Known Issues). |
| `Terraform-Workflow-Init` | Fully merged; can be deleted. |
| `chore/pr-template`, `docs/context-init` | Older branches, already merged; can be deleted. |

The partner's planned `feature/github-actions` branch does not exist on GitHub. The workflow work was done instead on `Terraform-Workflow-Init` and a series of `ElmerC02-patch-*` branches edited directly on GitHub (PRs #10–#15).

Do not assume local branches match GitHub. Do not assume pending changes are committed.

---

## Current Tooling

Both contributors use Windows.

Available tools:

- Git
- GitHub Desktop
- VS Code

### Nelo's confirmed versions

- Terraform: **1.16.6**
- Azure CLI: **2.91.0**

The VS Code **HashiCorp Terraform** extension was instructed as part of setup; confirm whether it is installed if relevant.

### Partner

The partner is following the same setup, but their Terraform/Azure CLI versions have not yet been confirmed.

---

## Azure Status

Nelo created an Azure subscription through the Azure free-account signup process.

Nelo successfully signed in locally with:

```text
az login
```

### Tenant and users

- One shared Microsoft Entra tenant/subscription is being used.
- Each contributor has their own individual login.
- Nelo invited the partner into the Microsoft Entra tenant.
- The partner accepted the invitation.

### Security group

Created:

`grp-launchpad-contributors`

Current configuration:

- Membership type: **Assigned**
- Nelo is an owner.
- Both contributors are members.
- “Microsoft Entra roles can be assigned to the group”: **No**

### Important permission status

The group **has not yet been assigned Azure resource permissions**.

Accepting the Microsoft Entra invitation does **not** automatically give the partner permission to view or manage project resources.

---

## Azure Budget

The project intends to remain within the **$200 free credit**, which expires after 30 days.

Agreed:

- Do not upgrade to pay-as-you-go.
- Do not remove the trial spending limit.
- Verify the exact subscription offer and spending-limit status.
- Remember that budget alerts do not stop spending.

For the first test, only an empty resource group should be created. The resource group itself has no charge.

---

## Terraform Layout

### Decided layout (confirmed on `main`)

```text
infra/app/main.tf
```

The project briefly planned to simplify to `infra/main.tf`, but the configuration stayed in **`infra/app/`**, and the CI workflow's working directory is `./infra/app`. This is the single Terraform configuration. Do not create `infra/main.tf` or another configuration elsewhere without agreeing on a layout change first.

`infra/app/versions.tf` no longer exists; its `required_version` setting was folded into `main.tf`.

### Current `infra/app/main.tf` contents

- `terraform` block: `required_version = "= 1.16.6"`, provider `hashicorp/azurerm` `~> 4.0`
- `provider "azurerm"` with an empty `features {}` block
- One resource: `azurerm_resource_group.launchpad`
  - name: `rg-launchpad-dev`
  - location: `westus2`

No backend is configured, so state is local.

Nelo is responsible for the Terraform configuration.

---

## Terraform State and Git

The root `.gitignore` **exists** on `main` and contains:

```gitignore
**/.terraform/*
*.tfstate
*.tfstate.*
*.tfplan
```

`infra/app/.terraform.lock.hcl` **is committed** (azurerm provider 4.81.0). Commit it again whenever it changes.

For this first test, Nelo keeps Terraform state locally.

Do not delete the local state.

Do not commit Terraform state.

Remote/shared state will be introduced later, after the first test succeeds.

---

## Division of Duties — First Test

### Nelo — Terraform

Deliverables:

1. ✅ Write `infra/app/main.tf`.
2. ✅ Configure the Azure provider.
3. ✅ Define the resource group `rg-launchpad-dev`.
4. Get the Terraform code through the partner's automated checks.
5. Run Terraform locally to plan and create the resource group.
6. Keep the local Terraform state for this first test.

Only Nelo runs `terraform plan` / `terraform apply` for this first test.

### Partner — GitHub Actions

Planned deliverable was `.github/workflows/terraform-check.yml`. What actually exists is:

```text
.github/workflows/terraform.yml
```

It was built from GitHub's Terraform starter workflow and trimmed down. Current behavior:

- Runs on **pull requests** (any target branch) and on **pushes to `main`**.
- Uses `environment: production` (GitHub creates this environment automatically; it is not needed for checks only).
- Runs from `./infra/app`.
- Installs Terraform **1.16.6** with `hashicorp/setup-terraform@v4` (wrapper off).
- Steps, in order:
  1. Show Terraform Files (debug step — see Known Issues)
  2. `terraform fmt -check`
  3. `terraform init -backend=false`
  4. `terraform validate`
  5. `terraform version`
- `terraform plan` and `terraform apply` are present but **commented out**.

The workflow:

- Does not authenticate to Azure.
- Does not deploy Azure resources.

---

## What the CI Checks Mean

### `terraform fmt -check`

Checks whether Terraform files follow Terraform's expected formatting.

It checks without modifying the files.

### `terraform init -backend=false`

Initializes the Terraform working directory and installs provider dependencies needed for validation, while skipping backend initialization.

This is preparation for the validation step.

### `terraform validate`

Checks the Terraform configuration for structural/configuration problems such as invalid arguments, configuration structure, and value types.

### Important limitation

These checks do **not** prove:

- Azure credentials work.
- Azure permissions are correct.
- The resource group can actually be created.
- The Terraform deployment will succeed.

CI validation and actual infrastructure deployment are separate concerns.

---

## First-Test Workflow

The intended workflow is:

1. Nelo creates/updates Terraform configuration.
2. Partner creates the GitHub Actions check workflow.
3. Both work is committed and pushed on their respective feature branches.
4. A pull request is opened toward `main`.
5. GitHub Actions runs the Terraform checks.
6. Both contributors review each other's work.
7. Merge the approved changes.
8. Nelo runs Terraform locally.
9. Nelo creates `rg-launchpad-dev`.
10. Confirm the resource group exists.
11. Confirm the partner has an appropriate Azure role if needed.
12. Only then move to remote state and automated Azure deployment.

Steps 1–7 are done (via PRs #1–#15). Steps 8–12 are not yet confirmed.

### CI failure test

Possibly in progress: the `Test` commit on `feature/terraform-foundation` introduces broken Terraform. Confirm whether a PR was opened and the checks failed as expected. Note that this commit breaks validation (bad provider source and argument name), not only formatting — a pure formatting test would be, e.g., misaligning the `=` signs.

After the workflow exists:

1. Deliberately introduce a Terraform formatting issue.
2. Push the change and confirm the formatting check fails.
3. Run `terraform fmt` locally.
4. Commit the formatting fix.
5. Push again.
6. Confirm the GitHub Actions checks pass.

---

## Git Practices Already Discussed

The contributors have practiced:

- Commits
- Pushes
- Pull requests
- Merging updated `main` into a feature branch
- Editing files directly on GitHub (`ElmerC02-patch-*` branches)

A PR template (`.github/pull_request_template.md`) is in use. Its checklist references a CONTRIBUTING guide that is only on the `docs/contributing` branch so far. That draft sets the branch naming convention `<type>/<short-description>` with types `feature/`, `fix/`, `chore/`, `docs/`, `refactor/`.

Continue to explain Git operations rather than assuming they are familiar.

Do not assume either branch is currently up to date.

---

## Known Issues in the Repository

- **"Show Terraform Files" step doesn't do what it looks like.** In `terraform.yml` the `run:` value is multi-line but lacks `|`, so YAML folds the lines together and the step just echoes text instead of running `pwd`, `ls -la` and `cat main.tf`. Either add `run: |` or remove the step (it was for debugging the working directory, which is now fixed).
- Step name typo: `Validate Terriform`.
- `environment: production` is unnecessary for a check-only workflow and may be confusing later, when a real production deployment is added.
- Leftover starter-template comments in `terraform.yml` describe Terraform Cloud and auto-apply, which this project doesn't use.
- The `docs/contributing` branch changes PR template checkboxes from `- [ ]` to `- []`. GitHub only renders `- [ ]` (with a space) as a checkbox; fix this before merging.
- PR template checklist links to CONTRIBUTING.md, which isn't on `main` yet.
- `requirements.txt` is empty and unused (there is no Python code). Decide whether to keep it.

---

## Current Known Unknowns / Things to Verify

Resolved (2026-10-19): Terraform lives in `infra/app/main.tf`; `infra/main.tf` and `infra/app/versions.tf` do not exist; `.gitignore` exists with the intended exclusions; `.terraform.lock.hcl` is committed; `main` is clean and matches GitHub.

Still to verify:

- Whether the latest GitHub Actions run on `main` passes.
- Whether Nelo has run `terraform apply` and `rg-launchpad-dev` exists in Azure.
- Whether the CI failure test (`Test` commit on `feature/terraform-foundation`) has been run and what happened.
- Whether local branches on each contributor's machine match GitHub.
- Whether the partner's Terraform and Azure CLI versions are confirmed.
- Whether the HashiCorp Terraform VS Code extension is installed.
- Exact Azure subscription offer and current spending-limit status.
- Azure role assignments for `grp-launchpad-contributors`.

---

## Current Next Step

**Do not expand the project.**

The repository layout is now confirmed (`infra/app/main.tf`), and the CI checks are on `main`. Next:

1. Confirm the latest GitHub Actions run on `main` is green.
2. Finish the CI failure test with the `Test` commit on `feature/terraform-foundation`, then revert it (do not merge the broken code).
3. Nelo runs `terraform init`, `terraform plan`, and `terraform apply` locally from `infra/app/` to create `rg-launchpad-dev`, then confirms it exists in the Azure portal or with `az group show --name rg-launchpad-dev`.
4. Assign an Azure role to `grp-launchpad-contributors` (e.g., Reader or Contributor scoped to the resource group).
5. Clean up: fix the Known Issues above, open a PR for `docs/contributing`, delete merged branches.

After that, continue with **one manageable step at a time**.
