# Purdue ROV KiCad Board Template

This is the central base template for starting any new hardware project at Purdue ROV.

---

## Features
*   **Zero-Setup Library Loading**: Automatically references the central symbol and footprint libraries via the submodule in `libs/purdue-rov-kicad-lib`.
*   **Merge Conflict Prevention**: Pre-configured `.gitattributes` to filter out volatile KiCad UI metadata before commits.
*   **CI/CD Integration Ready**: Workflows configured to run automated Electrical Rules Check (ERC), Design Rules Check (DRC), and generate fabrication/assembly exports.

---

## How to Start a New Project

1.  Click the **"Use this template"** button at the top of the GitHub repository.
2.  Name your new repository (e.g., `depth-sensor-board`) and click **Create repository**.
3.  Clone your new repository locally using the recursive flag to pull in the central library submodule:
    ```bash
    git clone --recursive https://github.com/purduerov/YOUR-BOARD-REPO.git
    ```
    > [!TIP]
    > **Forgot the `--recursive` flag or seeing missing/question-mark symbols in KiCad?**
    > Run this command in your terminal inside the project directory to fetch the library:
    > ```bash
    > git submodule update --init --recursive
    > ```
4.  Open the template `.kicad_pro` project in KiCad and rename the files to match your project name.

---

## Local Git Clean Filters & Hooks (Automatic Setup)

To ensure volatile KiCad metadata (like window positions, zoom levels, and time stamps) does not cause git merge conflicts, this template uses a **self-healing Git hook** system:

### How it Works:
1.  **Automatic Setup on Validation**: Running `./run_validation.ps1` or `./run_validation.sh` checks for Git clean filters and automatically configures them if they are missing.
2.  **Pre-commit Verification**: We use a custom Git hook in `.githooks/pre-commit` mapped via `core.hooksPath`. When you make a commit, the hook verifies that the clean filters are active. If they are not, it automatically runs the setup script, configures them, and re-stages the cleaned KiCad files before completing the commit.

If you ever need to manually configure the Git clean filters once on your machine:
*   **Windows (PowerShell)**: Run `.\setup_git_filters.ps1`
*   **Linux/macOS (Bash)**: Run `./setup_git_filters.sh`

---

## Local One-Click Validation (Mock Jobset)

Instead of waiting for the GitHub Action to run, you can test your board locally with a single command. This runs the central KiBot script (ERC, DRC, and exports) inside a Docker container:

*   **Windows**: Run `.\run_validation.ps1` in PowerShell.
*   **Linux/macOS**: Run `./run_validation.sh` in your terminal.

All schematic PDFs, Interactive BOMs, and Gerbers will generate in the `Generated_Outputs/` folder.

---

## Custom DRC Rules

This template includes a [custom_rules.kicad_dru](custom_rules.kicad_dru) file that pre-defines electrical isolation boundaries. For example, it enforces a minimum **2.0mm clearance** between high-power thruster lines (`Power_Thruster` netclass) and low-voltage logic (`Logic_3V3` netclass) to prevent condensation or noise faults.

---

## Adding a Custom Central Part

If you need a new symbol or footprint:
1.  Open the submodule repository `libs/purdue-rov-kicad-lib` (or clone it separately).
2.  Save your new symbol/footprint to the central library.
3.  Commit your changes and open a Pull Request.
4.  Once merged, update the submodule in your project repository:
    ```bash
    git submodule update --remote --merge
    ```
