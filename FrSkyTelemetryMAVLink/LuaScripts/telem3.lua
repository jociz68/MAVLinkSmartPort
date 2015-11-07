
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

-- becuase of memory restriction, a few temperature values are stored
local tempMaxPoints = 30
local lastTime = 0
local maxTemp = 0
local minTemp = 0
-- Taranis has an LCD display width of 212 pixels and height of 64 pixels.
-- Position (0,0) is at top left. Y axis is negative, top line is 0, bottom line is 63.
local yAxisHeight = 50
local xAxisWidth = 90
local yStartPos = 10
local xStartPos = 25
local motorTemp = 0
local escTemp = 0

local temp1      = {}
local temp2     = {}

local function init()
   for i=0,tempMaxPoints-1 do
     temp1[i] = 0
	 temp2[i] = 0
   end
end
---------------------------------------------------------------------------------------------------
local function readTemp()
	motorTemp = getValue("temp1")
	escTemp = getValue("temp2")
	-- For only test 
	-- motorTemp = getValue("s1")
	-- escTemp = getValue("s2")
end

local function readMaxMinTemp()
	maxTemp = getValue("gvar1")
	minTemp = getValue("gvar2")
	if maxTemp == 0 then
		maxTemp = 120
    end
    if minTemp == 0 then
		minTemp = 0
    end
end

local function drawMotorTemp()
	lcd.drawText(xStartPos,     1,"Motor: "  , SMLSIZE)
	lcd.drawText(lcd.getLastPos(),     1,motorTemp  , SMLSIZE)
	lcd.drawText(xStartPos + 52,     1,"max: "  , SMLSIZE)
	lcd.drawText(lcd.getLastPos(),     1,getValue("temp1-max")  , SMLSIZE)
	local yPos = 0
	local yScale = yAxisHeight / (maxTemp - minTemp)
	local tempIndex = 0
	for i=0,xAxisWidth - 1 do
		tempIndex = math.floor(i / 3)
		yPos = yStartPos + yAxisHeight + minTemp * yScale -  temp1[tempIndex] * yScale
		lcd.drawLine(xStartPos + i, yStartPos + yAxisHeight, xStartPos + i, yPos, SOLID, GREY_DEFAULT)
		lcd.drawPoint(xStartPos + i, yPos, SOLID, FORCE)
	end
end

local function drawEscTemp()
	lcd.drawText(100 + xStartPos,     1,"ESC: "  , SMLSIZE)
	lcd.drawText(lcd.getLastPos(),     1,escTemp  , SMLSIZE)
	lcd.drawText(100 + xStartPos + 40,     1," max: "  , SMLSIZE)
	lcd.drawText(lcd.getLastPos(),     1,getValue("temp2-max")  , SMLSIZE)
	local yPos = 0
	local xPos = 0
	local yScale = yAxisHeight / (maxTemp - minTemp)
	local tempIndex = 0
	for i=0,xAxisWidth - 1 do
		tempIndex = math.floor(i / 3) 
		xPos = xStartPos + xAxisWidth + 5 + i
		yPos = yStartPos + yAxisHeight + minTemp * yScale -  temp2[tempIndex] * yScale
		lcd.drawLine(xPos, yStartPos + yAxisHeight, xPos, yPos, SOLID, GREY_DEFAULT)
		lcd.drawPoint(xPos, yPos, SOLID, FORCE)
	end
end

local function drawYaxis()
	lcd.drawText(1, 1 , "Temp" , SMLSIZE)
	lcd.drawText(1, yStartPos + yAxisHeight - 5 , minTemp , SMLSIZE)
	lcd.drawText(1, yStartPos + yAxisHeight / 2 - 2, maxTemp - (maxTemp - minTemp) / 2, SMLSIZE)
	lcd.drawText(1, yStartPos , maxTemp , SMLSIZE)
end
local function background()
	local currtime = getTime()
	if currtime > (lastTime + 300) then
		readTemp()
		lastTime = currtime
		-- shift graph left
		for i=0,tempMaxPoints - 2 do
			temp1[i] = temp1[i + 1]
			temp2[i] = temp2[i + 1]
		end
		temp1[tempMaxPoints - 1] = motorTemp
		temp2[tempMaxPoints - 1] = escTemp
	end
end

local function run(event)
    lcd.clear()
	readTemp()
	readMaxMinTemp()
	background()
    drawMotorTemp()
	drawEscTemp()
	drawYaxis()
end

return { init=init, background=background, run=run }
