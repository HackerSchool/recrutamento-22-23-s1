/*
 * HackerSchool Eletronics Project
 * november 2022, roby
 */

#include "sensor.h"
#include "const.h"
#include "SevSeg.h"

// sensor "a" (that starts the counter)
sensor_t sensor_a{.id = SensorID::A, .pin_echo = 2, .pin_trig = 3};

// sensor "a" (that resets the counter)
sensor_t sensor_b{.id = SensorID::B, .pin_echo = 4, .pin_trig = 5};

// 7 segment controller object
SevSeg sevseg;

void setup() {
    pinMode(sensor_a.pin_trig, OUTPUT);
    pinMode(sensor_b.pin_trig, OUTPUT);
    pinMode(sensor_a.pin_echo, INPUT);
    pinMode(sensor_b.pin_echo, INPUT);

    constexpr byte digit_pins[]   = {6, 7, 8, 9};
    constexpr byte segment_pins[] = {10, 12, A3, A1, A0, 11, A4, A2};
    sevseg.begin(COMMON_CATHODE, sizeof(digit_pins), digit_pins, segment_pins);
    sevseg.setBrightness(1);

    Serial.begin(9600);
    Serial.println("Starting...");
}

void loop() {
    static bool is_counting   = false;
    static ulong timer        = millis();
    static int deci_seconds   = 0;
    static double last_result = -1.0; // m/s

    sevseg.setNumber(last_result != -1.0 ? last_result * 1000 : 0, 3);

    while (!is_counting) {
        int distance = get_distance(&sensor_a);
        if (distance <= TRIGGER_DISTANCE) {
            is_counting = true;
            break;
        }
        sevseg.refreshDisplay();
    }

    while (is_counting) {
        int distance = get_distance(&sensor_b);
        if (distance <= TRIGGER_DISTANCE) {
            is_counting = false;
            last_result = SENSOR_DISTANCE / (deci_seconds / 10); // V = D / T
            Serial.print("Velocity: ");
            Serial.print(last_result, 3);
            Serial.println(" m/s");
            timer        = millis();
            deci_seconds = 0;
            break;
        }

        if (millis() - timer >= 100) { // if 100 ms elapsed (1 decisecond)
            deci_seconds++;
            timer += 100;
            if (deci_seconds == MAX_DECI_SECONDS) {
                deci_seconds = 0;
            }
            sevseg.setNumber(deci_seconds, 1);
        }

        sevseg.refreshDisplay();
    }
}
