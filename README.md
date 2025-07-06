# Pitchy Projects
## 🔍 Pitchy (Arduino)
#### This Arduino project are maked using ESP32 for the module, using DHT11, Soil Moisture & Water Level for the sensors.
#### This is the picture of the circuit of this Arduino
![Circuit Picture](./images/Circuit%20AOL%20ME%20Smt4.png)

## 🪴 Pitchy (App)
#### This application aims to bring monitoring features to your plants from anywhere and anytime. By bringing Arduino technology and its sensors, as well as using Firebase as a database and Flutter as a medium for creating applications, we expect convenience for users. This Pitchy will also help you to find out the water content, soil moisture, and ambient temperature needed.
### ⚙️ Features provided by this application: 
#### Live monitoring of temperature, soil moisture, and water level. Addition of charts as a form of history of the data taken. Real-time plant status such as Good, Caution, or Bad (color-coded).
### 💡 How It Works
#### Arduino/ESP32 collects data from plant sensors. Sends data to Firebase every second (customizable). Flutter app retrieves and displays live sensor data on your phone.
### 📲 Getting Started
#### Flash the Arduino code (see /arduino folder). Set up Firebase and add your credentials. Run the Flutter app (flutter run) and connect your device.
