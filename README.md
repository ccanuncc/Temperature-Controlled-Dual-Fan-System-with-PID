# Dual-Fan Temperature Control System (Arduino + MATLAB PID)

This project implements a **dual-fan temperature regulation system** using **Arduino Nano**, a **DHT21 temperature sensor**, and **MATLAB-based PID control**. The system was physically tested in a **foam box environment** to simulate thermal dynamics and validate real-world performance.

## 🛠️ Components

- Arduino Nano  
- DHT21 Temperature Sensor  
- 2× 5V Brushless Fans  
- 2× 2N2222 NPN Transistors  
- 2× 1N4007 Flyback Diodes  
- 2× 330Ω Base Resistors  
- 10KΩ Pull-up Resistor  
- 5V Adapter (for external fan power)  
- Foam Box (for thermal insulation during testing)

## 🧠 How It Works

1. Arduino reads the temperature from the DHT21 sensor.
2. A **median filter** smooths out sensor noise.
3. Temperature data is sent to MATLAB via serial communication.
4. MATLAB calculates a **PWM control signal** using a PID algorithm.
5. The PWM signal is sent back to the Arduino.
6. Arduino adjusts **two cooling fans** using transistor circuits based on the received PWM value.

## 🔁 Control Logic (MATLAB)

The PID control loop is implemented in MATLAB using the script `temperature_pid_control.m`. Key features include:

- Real-time serial communication with Arduino.
- On-the-fly plotting of temperature and PWM values.
- Integral reset logic to avoid wind-up during cool-down cycles.
- PWM output clamped between 0–255 to match Arduino analogWrite limits.

> ⚠️ **Important:** Directly running the `.m` file might lead to issues in some MATLAB setups.  
> For best results, copy and paste the contents of `temperature_pid_control.m` into the **MATLAB Command Window** and execute from there.

## 🧪 Real-World Testing

The system was tested in a closed foam box environment to simulate real-world temperature control scenarios. The fans respond dynamically to temperature changes and effectively stabilize the internal environment.

## 📁 Files Included

- `sketch_jul22a.ino` — Arduino code for temperature reading, filtering, and dual-fan control.
- `temperature_pid_control.m` — MATLAB script for PID computation, communication, and live plotting.
- `Circuit_Diagram.png` — Full schematic of the hardware setup.

## 📈 Live Output Example

- Real-time plots of temperature vs. PWM in MATLAB.
- Console logs displaying feedback at every iteration.
- Accurate fan modulation in response to heating or cooling trends.

## 🔒 License

MIT License — Use, modify, and build upon this project freely with proper attribution.

---

**Developed by Samet Can Unç 🚀 | Field-tested — not just simulated.**
