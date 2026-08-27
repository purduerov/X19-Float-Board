# X19 Float Board

Schematic and PCB layout for the Purdue ROV X19 Float subsystem. This board manages motor/actuator control, power regulation, sensor data acquisition, STM32 microcontroller logic, and RF telemetry for the float mechanism.

## Schematic Architecture

The design is split into hierarchical sheets:
- `stm32.kicad_sch`: STM32 microcontroller, clock generation, debug/programming interfaces, and I/O routing.
- `pwr.kicad_sch`: Voltage regulation, input protection, and power distribution rails.
- `Motor.kicad_sch`: Motor driver circuitry and actuator outputs.
- `switch.kicad_sch`: Power switching and control logic.
- `sensor.kicad_sch`: Subsystem sensor interfaces and signal conditioning.
- `rf.kicad_sch`: RF communication circuitry and RF front-end routing.

## Getting Started

### 1. Clone the Repository
Clone recursively so the central component library submodule is included:
```bash
git clone --recursive https://github.com/purduerov/X19-Float-Board.git
cd X19-Float-Board
```

If you cloned without `--recursive`:
```bash
git submodule update --init --recursive
```

### 2. Configure Git Clean Filters
Run the setup script so volatile KiCad GUI metadata (window coordinates, zoom states) is automatically stripped before commits:

- **Windows (PowerShell):**
  ```powershell
  .\setup_git_filters.ps1
  ```
- **macOS / Linux:**
  ```bash
  ./setup_git_filters.sh
  ```

### 3. Open in KiCad
Open `X19-Float-Board.kicad_pro` in KiCad.

## Local Validation (KiBot / Docker)

Run automated ERC, DRC, and manufacturing output generation (PDF schematics, interactive BOMs, Gerbers) locally:

- **Windows:**
  ```powershell
  .\run_validation.ps1
  ```
- **macOS / Linux:**
  ```bash
  ./run_validation.sh
  ```

Generated files are placed in `Generated_Outputs/`.

## Design Rules & Constraints

- Isolation rules are specified in `custom_rules.kicad_dru` (maintaining spacing between high-power motor lines and sensitive logic).
- All components must be sourced from the central library (`libs/purdue-rov-kicad-lib`) with complete MPN, Manufacturer, and Datasheet fields.
