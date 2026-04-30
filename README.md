# Sige_Wu_20719618_CW2

This is a matlab coursework.

Remote repository:
https://github.com/MarkCup-Official/Sige_Wu_20719618_CW2

## Files

- `Sige_Wu_20719618.m`: main matlab script.
- `Sige_Wu_20719618.docx`: report document.
- `capsule_temperature.txt`: temperature log file (task 1).
- `temperature_vs_time_plot.png`: saved temperature plot (task 1).
- `temp_monitor.m`: function used in task 2.
- `temp_prediction.m`: function used in task 3.

## Function descriptions

### temp_monitor

This function continuously monitors and records the temperature, and also supports displaying temperature status using LEDs.
Input: a: Arduino object.
This function has no output.
This function reads the sensor voltage from pin A0, converts it to temperature in Celsius and displays the result on a live plot. The red, yellow, and green LEDs is connected to terminals D2, D3, and
D4 respectively. LEDs display rules:
T < 18 degrees Celsius: the yellow LED blinks every 0.5 seconds.
T > 24 degrees Celsius: the red LED blinks every 0.25 seconds.
18 < T < 24 degrees Celsius: the green LED remains constantly lit.

### temp_prediction

This function continuously monitors temperature and predicts future temperature trend, and includes an LED indicator.
Input: a: Arduino object.
This function has no output.
It reads sensor voltage from pin A0, converts it to Celsius, stores recent temperature data, and estimates the rate of change using linear fitting over the latest 20 samples. The function prints the current temperature, temperature change rate, and predicted temperature after 5 minutes. LEDs connected to D2, D3, and D4 indicate rapid heating, rapid cooling, or stable comfort conditions respectively.