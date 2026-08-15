# 4-bit Counter on AUP-ZU3 FPGA

A simple **4-bit synchronous counter** implemented and tested on the **AUP-ZU3 FPGA development board** using **Verilog HDL** and **AMD/Xilinx Vivado 2023.2**.

This project was developed as a hands-on exercise to understand the complete FPGA design flow, from RTL simulation to synthesis, implementation, constraints, and hardware testing.


## 🛠️ Tools & Hardware

* **FPGA Board:** AUP-ZU3
* **FPGA:** Zynq UltraScale+ MPSoC
* **HDL:** Verilog
* **EDA Tool:** Vivado 2023.2
* **Clock:** 100 MHz differential PL clock
* **Output:** 4 user LEDs

## 📌 Design Overview

The design consists of:

1. **Differential clock input**
2. **IBUFDS differential clock buffer**
3. **Clock divider**
4. **4-bit counter**
5. **Reset and enable control**
6. **LED output**

The incoming 100 MHz differential clock is converted into a single-ended internal clock using `IBUFDS`. A clock divider then generates a much slower clock so that the counter transitions can be observed through the LEDs.

### Block Flow

```text
100 MHz Differential Clock
          │
          ▼
       IBUFDS
          │
          ▼
    Clock Divider
          │
          ▼
      4-bit Counter
       ▲       ▲
       │       │
     Reset   Enable
          │
          ▼
      4 User LEDs
```

## ⏱️ Clock Management

The AUP-ZU3 provides a **100 MHz differential PL clock**.

The differential clock inputs are handled using the FPGA's `IBUFDS` primitive:

```verilog
IBUFDS clk_buf (
    .I (clk_p),
    .IB(clk_n),
    .O (clk)
);
```

A clock divider is then used to reduce the clock frequency to a rate suitable for observing the counter output on LEDs.

## 🔢 Counter

The counter is a simple 4-bit synchronous counter with reset and enable inputs.

```verilog
always @(posedge clk or posedge rst)
begin
    if (rst)
        count <= 4'b0000;
    else if (en)
        count <= count + 1'b1;
end
```

When enabled, the counter follows:

```text
0000 → 0001 → 0010 → 0011 → 0100
  ↓
...
  ↓
1111 → 0000
```

The four counter bits are connected to the four user LEDs on the board.

## 📐 XDC Constraints

The FPGA design uses an **XDC constraint file** to define the physical pin assignments and I/O standards.

The constraints include:

* Differential clock pin assignments
* 100 MHz clock constraint
* LED pin assignments
* Reset push-button pin assignment
* Enable switch pin assignment
* Appropriate I/O standards

Example clock constraint:

```tcl
set_property PACKAGE_PIN D7 [get_ports clk_p]
set_property PACKAGE_PIN D6 [get_ports clk_n]

set_property IOSTANDARD LVDS [get_ports {clk_p clk_n}]

create_clock -period 10.00 [get_ports clk_p]
```

The `10.00 ns` clock period corresponds to:

```text
Frequency = 1 / 10 ns = 100 MHz
```

## 🧪 Verification

The design was first verified using **Vivado behavioral simulation**.

Simulation was used to verify:

* Counter reset operation
* Enable functionality
* Clock-driven counting
* Binary count sequence
* Counter rollover from `1111` to `0000`

After simulation, the design was synthesized, implemented, and tested on the **AUP-ZU3 development board**.

## 📁 Project Structure

```text
AUP-ZU3-4bit-counter/
│
├── counter.v        # 4-bit counter RTL
├── top.v            # Top-level module
├── pin.xdc          # FPGA pin and timing constraints
├── counter_tb.v     # Testbench
└── README.md        # Project documentation
```

## 🚀 Vivado Flow

The project follows the standard FPGA implementation flow:

```text
Verilog RTL
    ↓
Simulation
    ↓
Synthesis
    ↓
Implementation
    ↓
Bitstream Generation
    ↓
FPGA Programming
    ↓
Hardware Verification
```

## 🎯 Learning Outcomes

Through this project, we gained practical experience with:

* Verilog RTL design
* Testbench-based simulation
* Differential clock inputs
* `IBUFDS`
* Clock division
* XDC pin constraints
* Timing constraints
* Vivado synthesis and implementation
* FPGA bitstream generation
* Hardware debugging and verification

## 📹 Hardware Demonstration

The repository includes a hardware demonstration showing the **4-bit counter operating on the AUP-ZU3 board**, with the count displayed through the user LEDs.

---


A simple counter, but a useful first step toward larger **FPGA, RTL, and digital system designs**.
