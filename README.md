# 🚦 4-Way Traffic Light Controller (Verilog)

This project implements a 4-way traffic signal system using a finite state machine (FSM) in Verilog.

---

## 🧠 Traffic Logic

Each road (North, South, East, West) has:
- `*_forward`: for vehicles going straight or turning right
- `*_left`: for protected left turns

Right turns are allowed during forward green. Left turns are handled using separate protected phases. Yellow is applied **only** to forward signals, not left turns.

---

## 🧾 FSM States

| State | Active Lights |
|-------|----------------|
| `S0`  | North & South forward → GREEN |
| `S0Y` | North & South forward → YELLOW |
| `S1`  | East & West forward → GREEN |
| `S1Y` | East & West forward → YELLOW |
| `S2`  | North→West and South→East (protected left) |
| `S3`  | East→North and West→South (protected left) |
| `S4`  | All directions → RED |

Each state lasts for **3 clock cycles**. The FSM loops through all 7 states in order.

---

## 🎯 Signal Encoding

Each signal is 2 bits wide:
- `00` = RED  
- `01` = YELLOW  
- `10` = GREEN
