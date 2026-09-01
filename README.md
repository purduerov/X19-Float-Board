# X19 Float Board

The Float Board manages buoyancy systems, motor drivers, sensor telemetry, and power distribution for the Purdue ROV X19 vehicle.

---

## 🚀 Quickstart: Opening the Project (Recommended)

**Always open the project using the 1-click launcher:**

* **Windows:** Double-click `LAUNCH_KICAD.bat`
* **macOS / Linux:** Run `./LAUNCH_KICAD.sh`

### What the Launcher Does Automatically:
1. ⚙️ **Configures Git Hooks & Clean Filters:** Sets up Git to strip volatile viewport/zoom coordinates on every commit, preventing merge conflicts.
2. 🔄 **Auto-Updates Component Library:** Pulls the freshest symbols, footprints, and 3D models from `purdue-rov-kicad-lib` before opening.
3. 📐 **Opens KiCad:** Launches `X19-Float-Board.kicad_pro` with all 6 central library categories pre-linked.

---

## Cloning the Repository
Clone recursively to ensure the central component library is initialized:
```bash
git clone --recursive https://github.com/purduerov/X19-Float-Board.git
cd X19-Float-Board
```

## Central Component Library & Manager GUI

The project links to the central `purdue-rov-kicad-lib` submodule mapped across 6 categories in `sym-lib-table` and `fp-lib-table`:
- `rov_passives`: Resistors, capacitors, inductors, crystals
- `rov_power`: Voltage regulators, buck/boost converters, MOSFETs, diodes
- `rov_logic`: MCUs, logic ICs, op-amps, drivers, level shifters
- `rov_connectors`: Power terminals, XT60, headers, USB, JST connectors
- `rov_sensors`: IMUs, temperature, pressure sensors
- `rov_mech`: Mounting holes, standoffs, test points

### Launching the Library Manager GUI
To browse parts, inspect footprints, edit properties, or add/delete components in the shared library:
- **Windows:** Double-click `libs\purdue-rov-kicad-lib\LIBRARY_MANAGER.bat`
- **macOS / Linux:** Run `./libs/purdue-rov-kicad-lib/LIBRARY_MANAGER.sh`

## Schematic Hierarchy

The schematic is organized across functional sub-sheets:
- `X19-Float-Board.kicad_sch`: Root top-level sheet.
- `pwr.kicad_sch`: Power regulation and distribution.
- `stm32.kicad_sch`: Main microcontroller circuit and programming interface.
- `Motor.kicad_sch`: Motor driver stages and control signals.
- `sensor.kicad_sch`: Environmental and diagnostic sensor telemetry.
- `rf.kicad_sch`: Wireless/radio transceiver circuitry.
- `switch.kicad_sch`: Power switching logic.

## Design Rules & Clearances

- High-voltage / high-current motor traces maintain isolation rules configured in `custom_rules.kicad_dru`.
- All symbols must adhere to central library guidelines.

## Automated CI/CD & DevOps Preflight Checks

All CI/CD automation and tooling are centralized in [`purduerov/pcb-devops`](https://github.com/purduerov/pcb-devops):
1. **Automated Git Clean Filters:** Configured automatically by `.githooks/pre-commit` to prevent viewport/zoom merge noise.
2. **KiCad Symbol Linting:** Validates mandatory fields (`MPN`, `Manufacturer`, `Category`, `DigiKey`, `Datasheet`, `Temp_Range`) on all library components.
3. **ERC & DRC Validation:** Executes Electrical and Design Rules Checks via KiBot in GitHub Actions.
4. **Artifact Generation:** Automatically exports Schematic PDFs, Board Layout PDFs, and Interactive HTML BOMs on every pull request.
