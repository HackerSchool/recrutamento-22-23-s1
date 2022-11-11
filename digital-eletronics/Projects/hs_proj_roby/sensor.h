// sensor.h


/// represents a sensor identifier, in our case, we only have 2
enum SensorID {
    A,
    B
};

/// represents a sensor, with its id & pins
typedef struct Sensor {
    SensorID id;
    const int pin_echo;
    const int pin_trig;
} sensor_t;


/// returns [sensor]'s calculated distance hit
int get_distance(sensor_t* sensor) {
    digitalWrite(sensor->pin_trig, LOW);
    delayMicroseconds(2);

    // sets the trig pin to HIGH for 10 microseconds
    digitalWrite(sensor->pin_trig, HIGH);
    delayMicroseconds(10);
    digitalWrite(sensor->pin_trig, LOW);

    // reads the echo pin (sound wave travel time in microseconds)
    long travel_time = pulseIn(sensor->pin_echo, HIGH);

    // Distance = (Time/2) x (Speed of sound)
    return (travel_time / 2) * 0.034;
}
