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

Finish the first test: **one empty Azure resource group created with Terraform**, with **GitHub Actions checking the Terraform code**.

At the same time, work has started on **`infra/bootstrap`**, which will hold the storage for shared remote Terraform state. This is the first step after the first test, and was started before the first test is fully confirmed.

Still do **not** add yet:

- VM
- Webpage
- Database
- Automated Azure deployment (CD)

### First-test completion criteria

1. Terraform and GitHub Actions work are completed and reviewed. **Done** (merged to `main`).
2. Automated Terraform checks pass. **Done** (the latest runs on `main` pass).
3. Nelo runs Terraform locally and creates the empty resource group. **Not yet confirmed.**
4. The resource group is confirmed to exist. **Not yet confirmed.**
5. Nelo's partner has an appropriate Azure role if they need to view/manage the resource. **Not yet done.**
6. Only after this works should the project add shared remote state and automated Azure deployment.

---

## Current Repository

**GitHub repository:** `ElmerC02/launchpad` (https://github.com/ElmerC02/launchpad)

**Nelo's local path:**
`C:\Users\josee\Documents\GitHub\launchpad`

### Files on `main` (as of 2026-10-21)

```text
.github/pull_request_template.md     PR template
.github/workflows/terraform.yml      Terraform CI checks
.gitignore                           Terraform exclusions (state, plans, .terraform/)
README.md                            Required-tools install guide (Windows)
docs/CONTEXT.md                      This file
docs/CONTRIBUTING.md                 Branch naming and contribution guide
infra/app/main.tf                    Terraform settings, azurerm provider, rg-launchpad-dev
infra/app/.terraform.lock.hcl        Provider lock file (azurerm 4.81.0)
infra/bootstrap/main.tf              Terraform settings, azurerm provider, rg-state-storage
infra/bootstrap/.terraform.lock.hcl  Provider lock file (azurerm 4.81.0)
requirements.txt                     Empty — not used yet
```

The README is a setup guide for Git, GitHub Desktop, VS Code, Terraform 1.16.6, the HashiCorp Terraform VS Code extension, and Azure CLI.

### Recently merged

- PR #16 (`docs/contributing`): added `docs/CONTRIBUTING.md` and updated the PR template.
- PR #17 (`docs/update-context`): updated this file.
- PR #18 (`feature/terraform-foundation`): ran the CI failure test (`Test` commit), fixed it (`Update main.tf`), and added `infra/bootstrap`.

### Branches on GitHub

- `main`: shared branch.
- `chore/add-bootstrap-to-ci`: open as PR #19. Adds a CI matrix so both `infra/app` and `infra/bootstrap` are checked, fixes the `Validate Terriform` typo, and removes the leftover starter-template comments. Both checks pass. Linked to issue #20 (`Closes #20`).
- `docs/update-context`: this CONTEXT.md update.
- `Terraform-Workflow-Init`, `chore/pr-template`, `docs/context-init`, `docs/contributing`, `feature/terraform-foundation`: already merged; can be deleted (issue #34).

The partner's planned `feature/github-actions` branch was never created. The workflow work was done on `Terraform-Workflow-Init`, a series of `ElmerC02-patch-*` branches edited directly on GitHub (PRs #10–#15), and now `chore/add-bootstrap-to-ci`.

### Branch protection on `main`

- 1 approving review required.
- **No required status checks**, so a PR with failing CI can still be merged (issue #26).

### GitHub Project board

Board: **launchpad project** (https://github.com/users/ElmerC02/projects/5)

- Status columns: Todo, In Progress, Done.
- Custom fields: **Area** (Terraform, CI/CD, Azure, Docs) and **Phase** (This sprint, Next, Later, Housekeeping).
- Issues #20–#36 hold the planned work (see Current Next Step).
- Earlier PRs (#2–#18) are on the board as Done. PR #19 is In Progress.
- Workflow: create the issue, then the branch, then the PR with `Closes #N` in the description, so merging the PR closes the issue.

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
infra/app/        rg-launchpad-dev   the app's infrastructure
infra/bootstrap/  rg-state-storage   storage for future remote Terraform state
```

Each folder is a separate Terraform configuration (a "root module"), with its own provider settings, lock file, and state. Terraform commands only read the `.tf` files in the folder they run from; they do not look in subfolders. Run commands from inside the folder you are working on.

Do not create `infra/main.tf` or another configuration elsewhere without agreeing on a layout change first.

### Current `infra/app/main.tf` contents

- `terraform` block: `required_version = "= 1.16.6"`, provider `hashicorp/azurerm` `~> 4.0`
- `provider "azurerm"` with an empty `features {}` block
- One resource: `azurerm_resource_group.launchpad`
  - name: `rg-launchpad-dev`
  - location: `westus2`

### Current `infra/bootstrap/main.tf` contents

- Same `terraform` block and `provider "azurerm"` as `infra/app`
- One resource: `azurerm_resource_group.State_Storage`
  - name: `rg-state-storage`
  - location: `westus2`

Still to add: a storage account and blob container for state (issue #27).

Neither folder has a backend configured, so state is local.

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

`infra/app/.terraform.lock.hcl` and `infra/bootstrap/.terraform.lock.hcl` **are committed** (azurerm provider 4.81.0). Commit them again whenever they change.

For this first test, Nelo keeps Terraform state locally.

Do not delete the local state.

Do not commit Terraform state.

Remote/shared state will be introduced later, after the first test succeeds:

1. Add the state storage to `infra/bootstrap` and apply it locally.
2. Point `infra/app` at it with a `backend "azurerm"` block and migrate the local state.

`infra/bootstrap` is applied by hand, not by a workflow. It creates the storage that remote state lives in, so it can't keep its own state there first, and it rarely changes.

---

## Division of Duties — First Test

### Nelo — Terraform

Deliverables:

1. Write `infra/app/main.tf`. **Done.**
2. Configure the Azure provider. **Done.**
3. Define the resource group `rg-launchpad-dev`. **Done.**
4. Get the Terraform code through the partner's automated checks. **Done.**
5. Run Terraform locally to plan and create the resource group.
6. Keep the local Terraform state for this first test.

Only Nelo runs `terraform plan` / `terraform apply` for this first test.

### Partner — GitHub Actions

Planned deliverable was `.github/workflows/terraform-check.yml`. What actually exists is:

```text
.github/workflows/terraform.yml
```

It was built from GitHub's Terraform starter workflow and trimmed down. Current behavior on `main`:

- Runs on **pull requests** (any target branch) and on **pushes to `main`**.
- Uses `environment: production` (not needed for checks only; see Known Issues).
- Runs from `./infra/app` only.
- Installs Terraform **1.16.6** with `hashicorp/setup-terraform@v4` (wrapper off).
- Steps, in order:
  1. Show Terraform Files (debug step — see Known Issues)
  2. `terraform fmt -check`
  3. `terraform init -backend=false`
  4. `terraform validate`
  5. `terraform version`
- `terraform plan` and `terraform apply` are present but **commented out**.

PR #19 changes this so the job runs once per folder using a **matrix**:

```yaml
strategy:
  fail-fast: false
  matrix:
    dir: [infra/app, infra/bootstrap]
```

with `working-directory: ${{ matrix.dir }}`. PRs then show two checks, "Terraform infra/app" and "Terraform infra/bootstrap". `fail-fast: false` lets both jobs finish even if one fails. To check a new Terraform folder later, add it to the `dir` list.

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

Steps 1–7 are done. Steps 8–12 are not yet confirmed.

### CI failure test

A first test was done in PR #18: the `Test` commit broke `infra/app/main.tf` (`source = "hashico rp/azurerm"`, `loca tion = ...`) and the next commit fixed it. That test broke two things at once (provider source and an argument name), so it didn't show which step catches which mistake.

The fuller test is tracked in issue #22: break **one** thing at a time and confirm the right step fails with the expected error.

- Bad formatting: `fmt -check` should fail.
- Bad provider source: `init` should fail.
- Bad argument name: `validate` should fail.
- Break only `infra/bootstrap`: only the bootstrap job should fail.

A check that has never failed isn't proven to work. A green tick can also mean a step checked nothing. Read each step's log, not just the result.

---

## CI/CD Decisions

These were discussed and agreed as the direction for the project:

- **CI and CD are separate workflows.** CI runs on pull requests and only checks code. CD runs after merge to `main` and changes Azure with `terraform apply`.
- **CI can read from Azure, never write.** `fmt` and `validate` don't touch Azure. A later `terraform plan` step in CI needs read-only Azure access. Only CD gets write access.
- **One CI workflow covers all Terraform folders** using the matrix, instead of a separate workflow per folder. Setting the working directory to `infra/` doesn't work, because Terraform doesn't look in subfolders and the checks would pass while checking nothing.
- **`infra/bootstrap` has no CD workflow.** It is applied locally by hand.
- **`terraform plan` in CI waits** until remote state exists and GitHub can sign in to Azure with OIDC. Without remote state, a plan in CI would always plan to create everything again.
- **GitHub Environments are for CD, not CI.** `environment: production` should be removed from the CI workflow. When CD is added, use a `dev` environment, and a `production` one with required reviewers only once a prod copy exists. Environment features on private repos can depend on the GitHub plan; the repo is currently public.
- **No prod Azure copy yet.** Keep the `-dev` naming so a prod copy can be added later without using up the credit now.
- **Testing workflow changes:** a PR that changes a workflow runs its own version of the workflow, so the PR itself is the first test. If a workflow file is invalid YAML (for example `fail-fast = false` instead of `fail-fast: false`), GitHub runs nothing and the PR shows no checks; the error only appears in the Actions tab. actionlint can catch this (issue #33).

Planned order:

1. CI checks for both folders (PR #19).
2. Add state storage to `infra/bootstrap` and apply it locally.
3. Migrate `infra/app` to the remote backend.
4. Set up OIDC between GitHub Actions and Azure.
5. Add `terraform plan` to CI on PRs.
6. Add a separate CD workflow that applies `infra/app` after merge, using a GitHub environment.

---

## Git Practices Already Discussed

The contributors have practiced:

- Commits
- Pushes
- Pull requests
- Merging updated `main` into a feature branch
- Editing files directly on GitHub (`ElmerC02-patch-*` branches)
- Moving a commit pushed to the wrong branch (cherry-pick onto the right branch, then revert or remove it from the wrong one)
- Linking PRs to issues with `Closes #N`

A PR template (`.github/pull_request_template.md`) is in use, and `docs/CONTRIBUTING.md` is on `main`. It sets the branch naming convention `<type>/<short-description>` with types `feature/`, `fix/`, `chore/`, `docs/`, `refactor/`. CI workflow changes use `chore/`.

Continue to explain Git operations rather than assuming they are familiar.

Do not assume either branch is currently up to date.

---

## Known Issues in the Repository

- **"Show Terraform Files" step doesn't do what it looks like.** In `terraform.yml` the `run:` value is multi-line but lacks `|`, so YAML folds the lines together and the step just echoes text instead of running `pwd`, `ls -la` and `cat main.tf`. Either add `run: |` or remove the step (issue #21).
- `environment: production` is unnecessary for a check-only workflow. It records every PR run as a production deployment, and would make CI wait for approval if approval rules are added to `production` later (issue #21).
- The PR template on `main` uses `- []` instead of `- [ ]`, so GitHub doesn't render clickable checkboxes (issue #25).
- `main` doesn't require CI checks to pass before merging (issue #26).
- `infra/bootstrap/main.tf` names its resource `State_Storage`. Terraform convention is lowercase snake_case (`state_storage`). This doesn't fail the checks.
- `requirements.txt` is empty and unused (there is no Python code). Decide whether to keep it (issue #35).

Fixed by PR #19 once merged: `infra/bootstrap` not checked by CI, the `Validate Terriform` typo, and the leftover Terraform Cloud starter comments.

---

## Current Known Unknowns / Things to Verify

Resolved (2026-10-21): CI runs on `main` pass; the first CI failure test was done in PR #18; `infra/bootstrap` passes `fmt -check` and `validate` (PR #19); CONTRIBUTING.md is on `main`.

Still to verify:

- Whether Nelo has run `terraform apply` and `rg-launchpad-dev` exists in Azure.
- Whether local branches on each contributor's machine match GitHub.
- Whether the partner's Terraform and Azure CLI versions are confirmed.
- Whether the HashiCorp Terraform VS Code extension is installed.
- Exact Azure subscription offer and current spending-limit status.
- Azure role assignments for `grp-launchpad-contributors`.
- Whether the project board's built-in workflows (item closed, PR merged) are turned on.

---

## Current Next Step

**Do not expand the project beyond the board.**

The work is tracked as issues on the project board. This sprint:

1. Merge PR #19 (CI matrix for both folders). Issue #20.
2. Finish the CI workflow cleanup. Issue #21.
3. Verify each CI step fails when it should. Issue #22.
4. Nelo applies `infra/app` locally and confirms `rg-launchpad-dev` exists (`az group show --name rg-launchpad-dev`). Issue #23.
5. Assign an Azure role to `grp-launchpad-contributors`. Issue #24.
6. Fix the PR template checkboxes. Issue #25.
7. Require the Terraform checks before merging to `main`. Issue #26. After PR #19, the check names are "Terraform infra/app" and "Terraform infra/bootstrap".

Next (remote state): issues #27–#29.

Later (CD): issues #30–#33.

Housekeeping: issues #34–#36. CONTEXT.md is updated at the end of each sprint.

After that, continue with **one manageable step at a time**.
