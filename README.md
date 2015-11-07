# MAVLinkSmartPort
MAVLink information and additional temperature sensors are displayed on FrSky Taranis using Arduino.
This solution uses Arduino to convert MAVLink telemetry protocol to FrSky smart port protocol.
Arduino plays a role of bridge between the telemetry UART port of APM and smart port of FrSky radio receiver (X8R, X6R, X4R).
Communication between Arduino and MAVLink source (APM) is implemented via hardware UART of Arduino.
FrSky smart port is connected to a digital pin that SoftwareSerial drives.
Besides MAVLink, Arduino provides 2 temperatures for smart port. Temperature is measured with NTC termistors.
MAVLink and temperatures are displayed on FrSky Taranis LCD using Lua scripts.      
There is a schematic drawing of Arduino pins, NTC termistors, MAVLink and smart port.
There are some Arduino boards (for instance NANO) having the UART RX pin connected to USB-serial chip with 1k resistor.
This resistor must be removed so that Arduino RX pin can be used. 
Otherwise this RX pin is continuously driven by USB chip which would prevent the MAVLink serial communication.      

