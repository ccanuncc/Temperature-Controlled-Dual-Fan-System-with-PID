% temperature_pid_control.m
% Real-time temperature PID controller with Arduino communication
% Developed by Can Unç
% License: MIT

% Clear serial connections
delete(instrfind);

% Open serial connection to Arduino
arduinoObj = serial('COM3', 'BaudRate', 9600);
fopen(arduinoObj);
pause(2);  % Allow Arduino to initialize

% PID parameters
Kp = 120;
Ki = 20;
Kd = 8;

% Setpoint input
setPoint = input('Enter the target temperature (°C): ');

% Initialize PID variables
integral = 0;
prevError = 0;

% Data containers for plotting
temperatureData = [];
pwmData = [];
time = [];

% Plot setup
figure;

subplot(2,1,1);
sicPlot = plot(NaN, NaN, 'b');
ylabel('Temperature (°C)');
ylim([20 50]);
grid on;

subplot(2,1,2);
pwmPlot = plot(NaN, NaN, 'r');
ylabel('PWM');
xlabel('Time (s)');
ylim([0 260]);
grid on;

% Main loop
for i = 1:6000
    temperatureStr = fgetl(arduinoObj);
    temperature = str2double(temperatureStr);

    if ~isnan(temperature)

        % Reset integral if significantly below setpoint
        if temperature < (setPoint - 0.2)
            integral = 0;
            prevError = 0;
        end

        % PID calculation
        error = temperature - setPoint;
        integral = integral + error;
        derivative = error - prevError;

        pwm_raw = Kp*error + Ki*integral + Kd*derivative;

        % Clamp PWM between 0 and 255
        pwm = round(min(max(pwm_raw, 0), 255));

        % Send to Arduino
        fprintf(arduinoObj, '%d\n', pwm);

        % Console feedback
        fprintf('Temperature: %.2f °C → PWM: %d (Raw: %.2f)\n', ...
                temperature, pwm, pwm_raw);

        % Update plot data
        temperatureData(end+1) = temperature;
        pwmData(end+1) = pwm;
        time(end+1) = i;

        % Update plots
        set(sicPlot, 'XData', time, 'YData', temperatureData);
        set(pwmPlot, 'XData', time, 'YData', pwmData);
        drawnow;

        % Update error
        prevError = error;

    else
        disp('Invalid data received.');
    end

    pause(1);  % 1-second sample rate
end

% Cleanup
fclose(arduinoObj);
delete(arduinoObj);
clear arduinoObj;
