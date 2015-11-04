#include <SoftwareSerial.h>
#include <GCS_MAVLink.h>
#include "Arduino.h"
#include "FrSkyProcessor.h"
#include "MavlinkProcessor.h"

void setup() {
	uint8_t led_pin = 13;
	FrSkyProcessor frsky_processor(FrSkyProcessor::SOFT_SERIAL_PIN_12, led_pin);
	MavlinkProcessor mavlink_processor;
	Serial.begin(57600);
	pinMode(led_pin, OUTPUT);
	analogReference(DEFAULT);
	while (1) {
		// Check MavLink communication
		mavlink_processor.receiveTelemetry();
		// Check FrSky S.Port communication
		frsky_processor.process(mavlink_processor.getGatheredTelemetry(), mavlink_processor.isConnected());
		if (serialEventRun) serialEventRun();
	}
}

void loop()
{

}
