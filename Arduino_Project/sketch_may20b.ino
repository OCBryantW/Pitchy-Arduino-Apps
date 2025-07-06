#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <WiFi.h>
#include <DHT.h>
#include <Ticker.h>
#include <FirebaseESP32.h>  // LATEST VERSION

// Sensor dan koneksi
#define DHTPIN 26
#define DHTTYPE DHT11
#define WATER_SENSOR_PIN 34  
#define SOIL_MOISTURE_PIN 35

#define SDA_PIN 21
#define SCL_PIN 22

// WiFi & Firebase
#define WIFI_SSID "Galaxy A05s 3555"              
#define WIFI_PASSWORD "bryant@3042005"         
#define FIREBASE_HOST "pitchy-4c459-default-rtdb.asia-southeast1.firebasedatabase.app"
#define FIREBASE_AUTH "mMefoygFxCSF4ErnaISI46rX6vkXoAWqTiBpacwK" // Your database secret here

FirebaseData firebaseData;   
FirebaseConfig config;     
FirebaseAuth auth;         

// LED indikator
#define LED_MERAH 14
#define LED_KUNING 27
#define LED_HIJAU 25

// Kalibrasi sensor
#define WATER_SENSOR_MIN 0    
#define WATER_SENSOR_MAX 4095 
#define SOIL_MOISTURE_MIN 4095
#define SOIL_MOISTURE_MAX 0

DHT dht(DHTPIN, DHTTYPE);
LiquidCrystal_I2C lcd(0x27, 16, 2);
Ticker timer;
Ticker sensor;

// --- NEW: flags for safe Ticker use
volatile bool updateSensorsFlag = false;
volatile bool readTempFlag = false;

// --- NEW: minimal Ticker callbacks
void setUpdateSensorsFlag() { updateSensorsFlag = true; }
void setReadTempFlag() { readTempFlag = true; }

void setup() {
  Serial.begin(115200);
  delay(1000);

  Wire.begin(SDA_PIN, SCL_PIN);
  lcd.init();
  lcd.backlight();
  lcd.print("System Loading");

  dht.begin();
  pinMode(WATER_SENSOR_PIN, INPUT);
  pinMode(SOIL_MOISTURE_PIN, INPUT);
  pinMode(LED_MERAH, OUTPUT);
  pinMode(LED_KUNING, OUTPUT);
  pinMode(LED_HIJAU, OUTPUT);

  lcd.setCursor(1, 0);
  delay(2000);
  lcd.clear();

  // === WIFI SETUP ===
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nConnected to WiFi!");

  // === FIREBASE SETUP (NEW WAY) ===
  config.host = FIREBASE_HOST;
  config.signer.tokens.legacy_token = FIREBASE_AUTH;
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  // --- NEW: set Ticker to trigger flags, not real functions
  timer.attach(2, setReadTempFlag);
  sensor.attach(2, setUpdateSensorsFlag);
}

void loop() {
  // --- NEW: run functions in loop only when flag is set
  if (readTempFlag) {
    readTempFlag = false;
    readTemperature();
  }
  if (updateSensorsFlag) {
    updateSensorsFlag = false;
    updateSensorData();
  }
}

void readTemperature() {
  float temperature = dht.readTemperature();
  if (isnan(temperature)) {
    Serial.println("Failed to read from DHT sensor!");
    return;
  }
  Serial.print("Temperature: ");
  Serial.print(temperature);
  Serial.println("°C");
}

void updateSensorData(){
  int soilValue = analogRead(SOIL_MOISTURE_PIN);
  int soilPercentage = map(soilValue, SOIL_MOISTURE_MIN, SOIL_MOISTURE_MAX, 0, 100);
  soilPercentage = constrain(soilPercentage, 0, 100);

  int waterValue = analogRead(WATER_SENSOR_PIN);
  int waterPercentage = map(waterValue, WATER_SENSOR_MIN, WATER_SENSOR_MAX, 0, 100);
  waterPercentage = constrain(waterPercentage, 0, 100);

  float temperature = dht.readTemperature();
  if (isnan(temperature)) {
    temperature = -999; // just in case
  }

  Serial.print("Soil: ");
  Serial.print(soilPercentage);
  Serial.print("% | Water: ");
  Serial.print(waterPercentage);
  Serial.println("%");

  lcd.setCursor(0, 0);
  lcd.print("Soil: ");
  lcd.print(soilPercentage);
  lcd.print("%   ");
  lcd.setCursor(0, 1);
  lcd.print("Water: ");
  lcd.print(waterPercentage);
  lcd.print("%   ");

  updateIndicators(soilValue, waterPercentage);

  // ==== PUSH TO FIREBASE ====
  Firebase.setFloat(firebaseData, "/sensor/temperature", temperature);
  Firebase.setInt(firebaseData, "/sensor/soil", soilPercentage);
  Firebase.setInt(firebaseData, "/sensor/water", waterPercentage);
}

void updateIndicators(int soilValue, int waterPercentage){
  if ((soilValue >= 0) && waterPercentage <= 0) {
    digitalWrite(LED_MERAH, HIGH);
    digitalWrite(LED_KUNING, LOW);
    digitalWrite(LED_HIJAU, LOW);
  }
  else if ((soilValue >= 0) && waterPercentage <= 10) {
    digitalWrite(LED_MERAH, LOW);
    digitalWrite(LED_KUNING, HIGH);
    digitalWrite(LED_HIJAU, LOW);
  }
  else if (soilValue > 650 && waterPercentage > 10) {
    digitalWrite(LED_MERAH, LOW);
    digitalWrite(LED_KUNING, HIGH);
    digitalWrite(LED_HIJAU, LOW);
  }
  else if (soilValue <= 650 && waterPercentage > 10) {
    digitalWrite(LED_MERAH, LOW);
    digitalWrite(LED_KUNING, LOW);
    digitalWrite(LED_HIJAU, HIGH);
  } else {
    digitalWrite(LED_MERAH, LOW);
    digitalWrite(LED_KUNING, LOW);
    digitalWrite(LED_HIJAU, LOW);
  }
}
