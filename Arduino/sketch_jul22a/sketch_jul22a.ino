#include <DHT.h>

#define DHTPIN 2
#define DHTTYPE DHT21
DHT dht(DHTPIN, DHTTYPE);

// PWM output pins
const int fan1Pin = 5;  // Fan 1 → D5
const int fan2Pin = 4;  // Fan 2 → D4

const int N = 5;              // Median filter window size
float window[N];              // Temperature samples

void setup() {
  Serial.begin(9600);
  dht.begin();
  pinMode(fan1Pin, OUTPUT);
  pinMode(fan2Pin, OUTPUT);
}

void loop() {
  // Take N temperature samples
  for (int i = 0; i < N; i++) {
    float t = dht.readTemperature();
    if (!isnan(t) && t > 5 && t < 50) {
      window[i] = t;
    } else {
      window[i] = (i > 0) ? window[i - 1] : 50.0;  // Use previous or default if invalid
    }
    delay(50);  // Small delay between readings
  }

  // Sort temperature values from smallest to largest (simple bubble sort)
  for (int i = 0; i < N - 1; i++) {
    for (int j = i + 1; j < N; j++) {
      if (window[j] < window[i]) {
        float temp = window[i];
        window[i] = window[j];
        window[j] = temp;
      }
    }
  }

  // Take the middle value (median)
  float medianTemp = window[N / 2];

  // Send to MATLAB
  Serial.println(medianTemp);

  // Wait for PWM value from MATLAB
  while (Serial.available() == 0) {
    // Wait until PWM value is received
  }

  // Read PWM value and apply it to both fans
  int pwmValue = Serial.parseInt();
  analogWrite(fan1Pin, pwmValue);
  analogWrite(fan2Pin, pwmValue);

  delay(250);  // Loop completion delay (total ~1 second)
}
