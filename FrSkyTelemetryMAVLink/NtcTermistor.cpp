#include "NtcTermistor.h"
#include "Arduino.h"

NtcTermistor::NtcTermistor(float ntcB25, float ntcR25, float R1, int analogPin)
{
	ntcTempCoeficentB25 = ntcB25;
	ntcResistanceAt25 = ntcR25;
	Resistor_1 = R1;
	analogNtcPin = analogPin;
}


int NtcTermistor::GetTemperature()
{
	float resistanceOfTermistor = 0;
	//float Vout = 0;
	float T0 = 273.15;
	float T25 = T0 + 25;
	float temperature = T0;
	int rawAnalog = 0;
	rawAnalog = analogRead(analogNtcPin);
	if (rawAnalog)
	{
		//Vout = (rawAnalog * inputVoltage) / 1024.0;
		//resistanceOfTermistor = R1 * (inputVoltage / Vout - 1);
		resistanceOfTermistor = Resistor_1 *  1024.0 / rawAnalog - Resistor_1;
		// NTC termisztor
		temperature = 1 / ((log(resistanceOfTermistor / ntcResistanceAt25) / ntcTempCoeficentB25) + (1 / T25)) - T0;
		// rounding
		if (temperature > 0)
		{
			temperature += 0.5;
		}
		else if (temperature < 0)
		{
			temperature -= 0.5;
		}
	}
	return temperature;
}
