% Sige Wu
% ssysw20@nottingham.edu.cn


function temp_monitor(a)
    % This function continuously monitors and records the temperature, and 
    % also supports displaying temperature status using LEDs.
    % Input: a: Arduino object.
    % This function has no output.
    % This function reads the sensor voltage from pin A0, converts it to
    % temperature in Celsius and displays the result on a live plot.
    % The red, yellow, and green LEDs is connected to terminals D2, D3, and
    % D4 respectively.
    % LEDs display rules:
    % T < 18 degrees Celsius: the yellow LED blinks every 0.5 seconds.
    % T > 24 degrees Celsius: the red LED blinks every 0.25 seconds.
    % 18 < T < 24 degrees Celsius: the green LED remains constantly lit.

    % Define constants
    T_C = 10; % Coefficient T_C (mV/°C)
    V_0_Cel = 500; % Zero-degree voltage (mV)

    % Define variabels
    time = 0;
    times = [];
    temperatures = [];

    % Draw live plot
    figure;

    % Start monitoring
    while true
        % Read raw data in volts
        raw_voltage = readVoltage(a, 'A0');
    
        % Convert volts to millivolts
        milli_voltage = raw_voltage*1000;
    
        % Calculate temperature and save
        temperature = (milli_voltage-V_0_Cel)/T_C;
        
        % Draw live plot
        times(time+1) = time+1;
        temperatures(time+1) = temperature;
        plot(times, temperatures);
        title('Temperature vs Time');
        xlabel('Time (s)');
        ylabel('Temperature (°C)');
        drawnow;

        % Handle LEDs (D2-Red D3-Yellow D4-Green)
        if temperature>24
            % Turn on the red LED and turn off any other LEDs
            writeDigitalPin(a,'D2',1);
            writeDigitalPin(a,'D3',0);
            writeDigitalPin(a,'D4',0);
            % Wait for 0.25 seconds
            pause(0.25);
            % Turn off the red LED
            writeDigitalPin(a,'D2',0);
            % Wait for 0.25 seconds
            pause(0.25);
            % Turn on the red LED
            writeDigitalPin(a,'D2',1);
            % Wait for 0.25 seconds
            pause(0.25);
            % Turn off the red LED
            writeDigitalPin(a,'D2',0);
            % Wait for 0.25 seconds
            pause(0.25);
        elseif temperature<18
            % Turn on the yellow LED and turn off any other LEDs
            writeDigitalPin(a,'D2',0);
            writeDigitalPin(a,'D3',1);
            writeDigitalPin(a,'D4',0);
            % Wait for 0.5 seconds
            pause(0.5);
            % Turn off the yellow LED
            writeDigitalPin(a,'D3',0);
            % Wait for 0.5 seconds
            pause(0.5);
        else
            % Turn on the green LED and turn off any other LEDs
            writeDigitalPin(a,'D2',0);
            writeDigitalPin(a,'D3',0);
            writeDigitalPin(a,'D4',1);
            % Wait for 1 second
            pause(1);
        end

        % Track time
        time = time+1;
    end
end