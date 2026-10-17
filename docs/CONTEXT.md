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

1. Terraform and GitHub Actions work are completed and reviewed.
2. Automated Terraform checks pass.
3. Nelo runs Terraform locally and creates the empty resource group.
4. The resource group is confirmed to exist.
5. Nelo's partner has an appropriate Azure role if they need to view/manage the resource.
6. Only after this works should the project add shared remote state and automated Azure deployment.

---

## Current Repository

**GitHub repository:** `launchpad`

**Nelo's local path:**
`C:\Users\josee\Documents\GitHub\launchpad`

**Nelo's branch:**
`feature/terraform-foundation`

**Partner's initial branch:**
`feature/github-actions`

Do not assume the branches are currently synchronized.

Do not assume pending changes are committed.

The repository's current uploaded README contains only:

```text
# launchpad
```

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

### Intended first-test layout

Use:

```text
infra/main.tf
```

The simplified first-test design is to keep the Terraform settings, Azure provider configuration, and resource group definition in `infra/main.tf`.

Earlier, the project considered:

```text
infra/app/versions.tf
```

with:

```hcl
terraform {
  required_version = "= 1.16.6"
}
```

After simplifying the project, the intended layout became `infra/main.tf`.

**Before creating files, check the repository's current state. Do not create duplicate Terraform configurations if the existing files already contain the required configuration.**

### Required resource

The first Terraform test should define exactly one Azure resource group:

```text
rg-launchpad-dev
```

Nelo is responsible for the Terraform configuration.

---

## Terraform State and Git

A root `.gitignore` was discussed with:

```gitignore
**/.terraform/*
*.tfstate
*.tfstate.*
*.tfplan
```

Status still needs confirmation: **has `.gitignore` actually been created?**

Terraform state must remain out of Git.

The generated:

```text
.terraform.lock.hcl
```

should be committed.

For this first test, Nelo keeps Terraform state locally.

Do not delete the local state.

Do not commit Terraform state.

Remote/shared state will be introduced later, after the first test succeeds.

---

## Division of Duties — First Test

### Nelo — Terraform

Deliverables:

1. Write `infra/main.tf`.
2. Configure the Azure provider.
3. Define the resource group `rg-launchpad-dev`.
4. Get the Terraform code through the partner's automated checks.
5. Run Terraform locally to plan and create the resource group.
6. Keep the local Terraform state for this first test.

Only Nelo runs `terraform plan` / `terraform apply` for this first test.

### Partner — GitHub Actions

Deliverable:

```text
.github/workflows/terraform-check.yml
```

The workflow should:

- Run on pull requests targeting `main`.
- Install Terraform **1.16.6** on the GitHub runner.
- Run from the `infra` directory.
- Run these commands in order:

```text
terraform fmt -check
terraform init -backend=false
terraform validate
```

The workflow:

- Does not need Azure authentication.
- Must not deploy Azure resources.

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

### CI failure test

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

Continue to explain Git operations rather than assuming they are familiar.

Do not assume either branch is currently up to date.

---

## Current Known Unknowns / Things to Verify

Before giving instructions that depend on these, verify them:

- Where the existing Terraform files currently are.
- Whether `infra/main.tf` already exists.
- Whether the older `infra/app/versions.tf` still exists.
- Whether `.gitignore` exists and contains the intended Terraform exclusions.
- Whether `.terraform.lock.hcl` exists.
- Whether there are uncommitted changes.
- Whether the two feature branches are synchronized with `main`.
- Whether the partner's Terraform and Azure CLI versions are confirmed.
- Whether the HashiCorp Terraform VS Code extension is installed.
- Exact Azure subscription offer and current spending-limit status.
- Azure role assignments for `grp-launchpad-contributors`.

---

## Current Next Step

**Do not expand the project.**

The next task is to inspect the existing repository/Terraform files and determine the current Terraform layout.

Specifically, confirm where the existing Terraform file is so the simplified `infra/main.tf` layout can be used correctly without creating duplicate configurations.

After that, continue with **one manageable step at a time**.
