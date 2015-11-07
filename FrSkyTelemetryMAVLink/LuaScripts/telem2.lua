-- 	This program is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  A copy of the GNU General Public License is available at <http://www.gnu.org/licenses/>.
--

BatteryCapacity={}
local lastTime = 0

BatteryCapacity[-1024] = 2200
BatteryCapacity[0] = 4000
BatteryCapacity[1024] = 0

initialize()

local function background()
end

local function run(event)
    lcd.clear()
    checkForNewMessage()
	drawTopPanel()
	lcd.drawText(5, 11, "CNSP", SMLSIZE) 
	lcd.drawChannel(80, 11, "consumption", DBLSIZE)
	
	lcd.drawText(5, 30, "CUR", SMLSIZE)
	lcd.drawChannel(80, 30, "current", MIDSIZE)
	
	lcd.drawText(130, 14, "Batt Volt", SMLSIZE)
	lcd.drawChannel(205, 11, "vfas", DBLSIZE)
	lcd.drawText(130, 30, "MINIMUM", SMLSIZE)
	lcd.drawChannel(182, 30, "vfas-min", LEFT)
	
	local scValue = getValue("sc")
	local consumption = getValue("consumption")
	local remainPctBattcap = 0
	local batteryCapacity = 0
	batteryCapacity = BatteryCapacity[scValue]
	if batteryCapacity == 0 then
		batteryCapacity = getValue("rs") * 10
	end
	if batteryCapacity ~= 0 then
		remainPctBattcap = 100 - 100 * consumption / batteryCapacity
	end
	local doBlink = 0
	if remainPctBattcap < 20 then
		doBlink = BLINK
	end
	if remainPctBattcap < 60 then
		local loopStartTime = getTime()
		if loopStartTime > (lastTime + 20 * 100) then
			playNumber(remainPctBattcap, 8, 0)
			lastTime = loopStartTime
			if remainPctBattcap < 20 then
				playFile("/SOUNDS/en/lowbat.wav")
			end
		end 
		
	end
	lcd.drawText(5, 50, "Batt", SMLSIZE)
	lcd.drawNumber(80, 45	,batteryCapacity,DBLSIZE)
	lcd.drawText(lcd.getLastPos(), 45, "mAh",0)
	
	lcd.drawText(110, 46, "Battery", doBlink + MIDSIZE)
	lcd.drawNumber(170, 43, remainPctBattcap, LEFT+DBLSIZE)
	lcd.drawText(lcd.getLastPos(), 44, "%", MIDSIZE)
	lcd.drawGauge(100, 38, 110, 25, remainPctBattcap, 100)
end

return {run=run, background=background}
