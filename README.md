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
The location of the removed resistance on a board of NANO can be seen on arduino_nano_resistance_removed.jpg.
Otherwise this RX pin is continuously driven by USB chip which would prevent the MAVLink serial communication.      

Telemetry Lua scripts depict MAVLink information and values 2 NTC temperature sensors. 
One of NTC sensors is mounted to the bottom of a brushless motor and other one is placed on ESC. 
Temperature sources work as FrSky smart port T1 and T2 sensors.
Temperatures are depicted on a telemetry screen and continuously collected to show on another screen in a diagram.   
