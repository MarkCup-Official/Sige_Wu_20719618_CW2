function temp_monitor(a)
    % Define constants
    T_C = 10; % Coefficient T_C (mV/°C)
    V_0_Cel = 500; % Zero-degree voltage (mV)

    % Start monitoring
    while true
        % Read raw data in volts
        raw_voltage = readVoltage(a, 'A0');
    
        % Convert volts to millivolts
        milli_voltage = raw_voltage*1000;
    
        % Calculate temperature and save
        temperature = (milli_voltage-V_0_Cel)/T_C;

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
    end
end