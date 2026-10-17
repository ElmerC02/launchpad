# Launchpad — Required Tools

Both contributors should install the following tools on Windows.

## 1. Git

Download and install: https://git-scm.com/downloads/win

Verify in PowerShell:

```powershell
git --version
```

## 2. GitHub Desktop

Download and install: https://desktop.github.com/

Sign in with your own GitHub account and clone the shared repository.

## 3. Visual Studio Code

Download and install: https://code.visualstudio.com/

## 4. Terraform

Run in PowerShell:

```powershell
winget install --id Hashicorp.Terraform --exact --version 1.16.6 --source winget
```

Restart VS Code, then verify:

```powershell
terraform version
```

Both contributors should use version **1.16.6**.

## 5. Terraform Extension for VS Code

1. Open VS Code and press **Ctrl + Shift + X**.
2. Search for **HashiCorp Terraform**.
3. Install the extension published by **HashiCorp**.

The extension is separate from the Terraform CLI; install both.

## 6. Azure CLI

Run in PowerShell:

```powershell
winget install --exact --id Microsoft.AzureCLI --source winget
```

Restart VS Code, then verify:

```powershell
az version
```