function temp_prediction(a)
    % This function continuously monitors temperature and predicts future
    % temperature trend, and includes an LED indicator.
    % Input: a: Arduino object.
    % This function has no output.
    % It reads sensor voltage from pin A0, converts it to Celsius, stores
    % recent temperature data, and estimates the rate of change using
    % linear fitting over the latest 20 samples.
    % The function prints the current temperature, temperature change rate,
    % and predicted temperature after 5 minutes.
    % LEDs connected to D2, D3, and D4 indicate rapid heating, rapid
    % cooling, or stable comfort conditions respectively.

    % Define constants
    T_C = 10; % Coefficient T_C (mV/°C)
    V_0_Cel = 500; % Zero-degree voltage (mV)

    % Number of temperature points sampled for rate calculation
    % Compared to the 10 data points defined in the flowchart, 20 data
    % points are used here to reduce the impact of noise
    sampling_number = 20;

    % Define variabels
    time = 0;
    temperatures = [];

    % Start monitoring
    while true
        % Read raw data in volts
        raw_voltage = readVoltage(a, 'A0');
    
        % Convert volts to millivolts
        milli_voltage = raw_voltage*1000;
    
        % Calculate temperature and save
        temperature = (milli_voltage-V_0_Cel)/T_C;
        
        % Record history temperatures
        temperatures(time+1) = temperature;

        % Calculate the rate of temperature change
        
        % Get the data points that need to be calculated.
        current_number = length(temperatures);
        if current_number < sampling_number
            temperature_sample = temperatures;
        else
            temperature_sample = temperatures(end-sampling_number+1:end);
        end

        % Time corresponding to data points
        times = 0:length(temperature_sample)-1;

        % Use linear fitting to estimate the temperature change rate
        if isscalar(times)
            rate = 0;
        else
            p = polyfit(times,temperature_sample,1);
            rate = p(1);
        end
        rate_per_min = rate*60;

        % Handle LEDs (D2-Red D3-Yellow D4-Green)
        if rate_per_min > 4
            % Turn on the red LED only
            writeDigitalPin(a,'D2',1);
            writeDigitalPin(a,'D3',0);
            writeDigitalPin(a,'D4',0);
        else
            if rate_per_min < -4
                % Turn on the yellow LED only
                writeDigitalPin(a,'D2',0);
                writeDigitalPin(a,'D3',1);
                writeDigitalPin(a,'D4',0);
            else
                if temperature <= 24 && temperature >= 18
                    % Turn on the green LED only
                    writeDigitalPin(a,'D2',0);
                    writeDigitalPin(a,'D3',0);
                    writeDigitalPin(a,'D4',1);
                else
                    % Turn off all LEDs
                    writeDigitalPin(a,'D2',0);
                    writeDigitalPin(a,'D3',0);
                    writeDigitalPin(a,'D4',0);
                end
            end
        end

        % Predict temperature
        predicted_temperature = temperature + rate * 5 * 60;

        % Print results
        fprintf('\nTime: %d second\nCurrent temperature: %.2f °C\nRate of change: %.2f °C/min\nPredicted temperature in 5 minutes: %.2f °C\n',time,temperature,rate_per_min,predicted_temperature);

        % Track time
        time = time+1;

        % Wait for 1 second
        pause(1);
    end
end