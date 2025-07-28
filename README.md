# Dual-Fan Temperature Control System (Arduino + MATLAB PID)

This project implements a **dual-fan temperature regulation system** using **Arduino Nano**, **DHT21 temperature sensor**, and **MATLAB-based PID control**. The system was physically tested in a **foam box environment** to simulate thermal dynamics and validate real-world response.

## 🛠️ Components

- Arduino Nano  
- DHT21 Temperature Sensor  
- 2x 5V Brushless Fans  
- 2x 2N2222 NPN Transistors  
- 2x 1N4007 Flyback Diodes  
- 2x 330Ω Base Resistors  
- 10KΩ Pull-up Resistor  
- 5V Adapter (external fan power)  
- Foam Box (for thermal insulation during testing)

## 🧠 How It Works

1. Arduino reads the temperature from DHT21 sensor.
2. A **median filter** smooths out temperature noise.
3. Temperature is sent to MATLAB via serial.
4. MATLAB calculates the appropriate **PWM** signal using a PID algorithm.
5. The PWM signal is sent back to Arduino.
6. Arduino controls **two cooling fans** using transistor-based circuits.

## 🧪 Real-World Testing

The system was tested inside a **foam box** to mimic a small enclosed environment. The dual fans react in real-time to temperature changes and stabilize the internal conditions based on the MATLAB-calculated PID output.

## 📁 Files Included

- `sketch_jul22a.ino`: Arduino code with serial communication and dual-PWM fan control.
- `matlabcode.docx`: MATLAB code implementing PID and live plotting.
- `Circuit_Diagram.png`: Full schematic of the hardware setup.

## 📈 Live Output Example

- Real-time graphing of temperature and PWM in MATLAB.
- Sample logs demonstrate proper fan response to heating/cooling cycles.

## 🔒 License

MIT License — Feel free to use, modify, and build upon this project with proper attribution.

---

**Built by Samet Can Unç 🚀 | Tested in the real world, not just on paper.**
