% Sige Wu
% ssysw20@nottingham.edu.cn


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [5 MARKS]
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


%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

% Insert answers here

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here