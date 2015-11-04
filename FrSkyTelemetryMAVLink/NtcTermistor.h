#ifndef NTC_TERMISTOR_H
#define NTC_TERMISTOR_H

class NtcTermistor {
public:
	NtcTermistor(float ntcB25, float ntcR25, float R1, int analogPinn);
	int GetTemperature();
private:
	float ntcTempCoeficentB25;
	float ntcResistanceAt25;
	float Resistor_1; 
	int analogNtcPin; 
};
#endif