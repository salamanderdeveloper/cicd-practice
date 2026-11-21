# 🚀 CI/CD with GitHub Actions — From Scratch

A hands-on, practical guide to learning Continuous Integration and Continuous Deployment (CI/CD) using GitHub Actions.

---

## 📚 Curriculum Summary

| Lesson | Topic | Key Syntax & Concepts |
| :--- | :--- | :--- |
| **01** | [Hello World](#lesson-1-hello-world) | `name`, `on: [push, workflow_dispatch]`, `jobs`, `runs-on: ubuntu-latest`, `steps`, `run` |
| **02** | [Variables & Context](#lesson-2-variables-and-github-context) | `${{ github.actor }}`, `env:` scopes (workflow, job, step), `$GITHUB_OUTPUT` |
| **03** | [Code Checkout & Exit Codes](#lesson-3-checkout-and-exit-codes-ci-heart) | `actions/checkout@v4`, Unix exit codes (`exit 0` = Pass, `exit 1` = Fail) |
| **04** | [Multi-Job Pipelines](#lesson-4-multi-job-pipelines-and-dependencies) | Parallel jobs, sequential dependencies with `needs: [jobA, jobB]` |
| **05** | [Selective Triggers](#lesson-5-selective-triggers-paths--branches) | Path filtering with `paths:` to avoid unnecessary workflow runs |
| **06** | [Encrypted Secrets](#lesson-6-github-secrets--security) | `${{ secrets.SECRET_NAME }}`, log masking (`***`), security isolation |
| **07** | [Matrix Builds](#lesson-7-matrix-builds-multi-os) | `strategy.matrix`, running across `ubuntu-latest` and `macos-latest` in parallel |
| **08** | [Build Artifacts](#lesson-8-build-artifacts-upload--download) | `actions/upload-artifact@v4`, `actions/download-artifact@v4` |

---

## Lesson 1: Hello World
- **File:** [`.github/workflows/01-hello-world.yml`](.github/workflows/01-hello-world.yml)
- **Key Takeaways:**
  - GitHub Actions workflows are stored as YAML files inside `.github/workflows/`.
  - `on: push` triggers the workflow automatically when code is pushed.
  - `on: workflow_dispatch` adds a manual **"Run workflow"** button in GitHub's web interface.
  - `runs-on: ubuntu-latest` instructs GitHub to spin up a clean Ubuntu Linux virtual machine for the job.

---

## Lesson 2: Variables and GitHub Context
- **File:** [`.github/workflows/02-variables.yml`](.github/workflows/02-variables.yml)
- **Key Takeaways:**
  - **GitHub Context:** Built-in information available via `${{ github.actor }}`, `${{ github.ref_name }}`, `${{ github.sha }}`, etc.
  - **Environment Variables:** Can be scoped at three levels:
    - *Workflow level:* Visible to all jobs.
    - *Job level:* Visible to all steps in that job.
    - *Step level:* Visible only to that specific step.
  - **Dynamic Step Outputs:** Use `echo "key=value" >> "$GITHUB_OUTPUT"` to pass dynamic values from one step to later steps using `${{ steps.<step_id>.outputs.key }}`.

---

## Lesson 3: Checkout and Exit Codes (The Heart of CI)
- **File:** [`.github/workflows/03-checkout-and-tests.yml`](.github/workflows/03-checkout-and-tests.yml)
- **Key Takeaways:**
  - Runner VMs start completely empty. You **must** use `actions/checkout@v4` to clone your repository code into the runner workspace.
  - **Deterministic Quality Gates:** GitHub does **not** look for words like "FAILED" or emojis like ❌; it strictly checks **Unix Exit Codes**:
    - `exit 0` $\rightarrow$ Passed ✅
    - `exit 1` (or any non-zero) $\rightarrow$ Failed ❌ and stops pipeline execution immediately.
  - When tests fail, CI flags the commit and blocks broken Pull Requests from merging.

---

## Lesson 4: Multi-Job Pipelines and Dependencies
- **File:** [`.github/workflows/04-multi-job-pipeline.yml`](.github/workflows/04-multi-job-pipeline.yml)
- **Key Takeaways:**
  - Workflows can contain multiple distinct jobs (e.g. `lint`, `test`, `deploy`).
  - **By default, jobs run in parallel** on different virtual machines to save time.
  - Use `needs: [lint, test]` to create dependency orders. A deployment job will only run if all dependent jobs finish with success.

---

## Lesson 5: Selective Triggers (Paths & Branches)
- **File:** [`.github/workflows/05-selective-triggers.yml`](.github/workflows/05-selective-triggers.yml)
- **Key Takeaways:**
  - Without filters, every push runs every workflow in the repository.
  - Use `paths:` to specify which file modifications should trigger a workflow (e.g., only trigger documentation builds when `docs/**` changes).
  - Use `paths-ignore:` to skip CI runs on non-essential changes like `**.md`.

---

## Lesson 6: GitHub Secrets & Security
- **File:** [`.github/workflows/06-secrets.yml`](.github/workflows/06-secrets.yml)
- **Key Takeaways:**
  - Never commit passwords, tokens, or API keys directly to git.
  - Secrets are encrypted in GitHub's vault and accessed via `${{ secrets.SECRET_NAME }}`.
  - **Automatic Masking:** GitHub automatically intercepts secret values in terminal output and replaces them with `***` in the logs.
  - The runner script still has access to the real decrypted value in memory.

---

## Lesson 7: Matrix Builds (Multi-OS)
- **File:** [`.github/workflows/07-matrix-build.yml`](.github/workflows/07-matrix-build.yml)
- **Key Takeaways:**
  - Matrix builds allow testing across multiple operating systems or runtime versions without repeating YAML code.
  - Syntax:
    ```yaml
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest]
    runs-on: ${{ matrix.os }}
    ```
  - Spawns concurrent runners (e.g. Linux x86_64 and Apple Silicon arm64 macOS) from a single job specification.

---

## Lesson 8: Build Artifacts (Upload & Download)
- **File:** [`.github/workflows/08-artifacts.yml`](.github/workflows/08-artifacts.yml)
- **Key Takeaways:**
  - Runners are destroyed after jobs finish, and different jobs run on isolated machines.
  - **`actions/upload-artifact@v4`**: Saves files/packages (binaries, tarballs, test reports) into GitHub's cloud storage.
  - **`actions/download-artifact@v4`**: Fetches the uploaded artifact into another job or enables manual download via the GitHub Actions UI.

---

## 🛠 Useful GitHub CLI Commands
```bash
# List all workflow runs
gh run list

# Watch a run in real-time
gh run watch <run-id>

# View logs for a run
gh run view <run-id> --log

# View failed step logs only
gh run view <run-id> --log-failed

# Set an encrypted repository secret
echo "my-token" | gh secret set MY_SECRET_NAME
```
