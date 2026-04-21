% Sige Wu
% ssysw20@nottingham.edu.cn


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [5 MARKS]
%{
clear;

% Connect the UNO arduino device through the COM8 port
a = arduino("COM8","Uno");

% LED blink loop
while true
    % Turn on the LED connected to digital channel 2
    writeDigitalPin(a,'D2',1);
    % Wait for 0.5 seconds
    pause(0.5);
    % Turn off the LED connected to digital channel 2
    writeDigitalPin(a,'D2',0);
    % Wait for 0.5 seconds
    pause(0.5);
end
%}


%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
clear;

% Define constants
duration = 600; % Acquisition time (second)
T_C = 10; % Coefficient T_C (mV/°C)
V_0_Cel = 500; % Zero-degree voltage (mV)

% Define variabels
voltages = zeros(1, duration+1); % To save raw voltage data read form UNO
temperatures = zeros(1, duration+1); % To save temperature data read form UNO

% Connect the UNO arduino device through the COM8 port
a = arduino("COM8","Uno");

% Open log file
log_file = fopen('capsule_temperature.txt','w');

% Print log
log = sprintf('Data logging initiated - %s\nLocation - Nottingham\n', datetime('now','TimeZone','local','Format','M/d/yyyy'));
fprintf(log); % Print to screen
fprintf(log_file,log); % Print to log file

% Start recording
for n = 0:duration
    % Read raw data in volts
    voltages(n+1) = readVoltage(a, 'A0');

    % Convert volts to millivolts
    raw_milli_voltage = voltages(n+1)*1000;

    % Calculate temperature and save
    temperatures(n+1) = (raw_milli_voltage-V_0_Cel)/T_C;

    % Print when minute change
    if mod(n,60)==0
        log = sprintf('\n%-15s%d\n%-15s%.2f °C\n','Minute',floor(n/60),'Temperature',temperatures(n+1));
        fprintf(log); % Print to screen
        fprintf(log_file,log); % Print to log file
    end

    % Wait for 1 second
    pause(1);
end

% Calculate minimum, maximum and average temperature
min_temperature = min(temperatures);
max_temperature = max(temperatures);
ave_temperature = mean(temperatures);

% Print minimum, maximum and average temperature
log = sprintf('\n%-15s%.2f °C\n%-15s%.2f °C\n%-15s%.2f °C\n\nData logging terminated\n','Max temp',max_temperature,'Min temp',min_temperature,'Average temp',ave_temperature);
fprintf(log); % Print to screen
fprintf(log_file,log); % Print to log file

% Close log file
fclose(log_file);

% Draw a temperature/time plot
figure;
plot(0:duration, temperatures);
title('Temperature vs Time');
xlabel('Time (s)');
ylabel('Temperature (°C)');

% Save plot as PNG file.
saveas(gcf, 'temperature_vs_time_plot.png');


%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here