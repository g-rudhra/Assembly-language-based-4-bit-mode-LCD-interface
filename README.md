# ATmega328P 16×2 LCD Distance & Angle Display (4-bit Mode) — AVR Assembly

This project drives a standard HD44780-compatible **16×2 character LCD** using an **ATmega328P** in **4-bit parallel mode**, and continuously displays:

- Line 1: `Distance = XXXm`
- Line 2: `Angle = X'`

The code is written in AVR Assembly and targets the ATmega328P.

---

## Features

- HD44780 LCD interface in **4-bit mode**
- LCD initialization sequence (`0x33 → 0x32 → 0x28`)
- Prints constant text from **program memory (LPM)**
- Converts a numeric distance value (0–255) into **ASCII hundreds/tens/units**
- Converts a 1-digit angle value into ASCII
- Simple software delay routine
- Refreshes the display repeatedly in an infinite loop

---

## Hardware Connections

### LCD (HD44780) ↔ ATmega328P

The firmware assumes these wiring mappings:

| LCD Pin | Function | ATmega328P Pin |
|--------:|----------|----------------|
| RS      | Register Select | **PB0** |
| E       | Enable | **PB1** |
| D4      | Data bit 4 | **PD4** |
| D5      | Data bit 5 | **PD5** |
| D6      | Data bit 6 | **PD6** |
| D7      | Data bit 7 | **PD7** |
| RW      | Read/Write | **GND** (write-only) |
| VSS     | GND | GND |
| VDD     | +5V | +5V |
| VO      | Contrast | Potentiometer wiper |
| A / K   | Backlight | As per LCD module (often via resistor) |

> Notes  
> - RW must be tied to **GND** because the code does not read the busy flag.  
> - Use a **10k pot** for VO (contrast) between +5V and GND.

---

## Code Overview

### Entry Point
- Reset vector jumps to `displayDistance`.

### `displaySetup`
Configures LCD-related pins as outputs and sends initialization commands:
- `0x02` (return home / 4-bit related command used here)
- `0x33` then `0x32` to force 4-bit mode
- `0x28` (4-bit, 2-line, 5×7 font)
- `0x0C` (display on, cursor off)
- `0x01` (clear display)
- `0x06` (entry mode set)

### Line 1: Distance
- Prints `distanceString` from flash (`"Distance = "`).
- Calls `asciiConversionOfDistance`:
  - Input distance is expected in **R18** before calling.
  - Produces ASCII digits:
    - `R18` = hundreds ASCII
    - `R17` = tens ASCII
    - `R16` = units ASCII
- Sends digits + `'m'`.

### Line 2: Angle
- Moves to second line using `0xC0`.
- Prints `angleString` from flash (`"Angle = "`).
- Calls `asciiConversionOfAngle`:
  - Angle is expected in **R28** (single digit).
  - Output ASCII digit in `R16`
- Prints the digit and a `'` character.

### LCD Send Routines
- `sendCmd` sends command in 4-bit transfers (high nibble then low nibble).
- `sendData` sends data similarly, but with RS set.

---

## Registers Used (Key Ones)

| Register | Purpose |
|---------:|---------|
| `R16` | Main working register / byte to send to LCD |
| `R17` | Tens digit (ASCII) for distance conversion |
| `R18` | Input distance (binary) → output hundreds digit (ASCII) |
| `R28` | Angle value (binary, 0–9 expected) |
| `R20–R22` | Delay / temporary storage |
| `Z (ZH:ZL)` | Program memory pointer for strings |

---

## How to Set Distance and Angle

### Distance
Before calling `asciiConversionOfDistance`, the code expects the **numeric distance** in `R18`.

Example (distance = 123):
```asm
ldi R18, 123
rcall asciiConversionOfDistance
ldi R28, 5
rcall asciiConversionOfAngle