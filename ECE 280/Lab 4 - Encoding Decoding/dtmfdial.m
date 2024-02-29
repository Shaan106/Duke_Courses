% Define the sampling frequency
fs = 8000;

% Generate the DTMF signals for keys 1, 5, and 9 & the rest
keys = ['1', '5', '9'];
PhoneNum1 = dtmf_soundgen('1', fs);
PhoneNum2 = dtmf_soundgen('2', fs);
PhoneNum3 = dtmf_soundgen('3', fs);
PhoneNum4 = dtmf_soundgen('4', fs);
PhoneNum5 = dtmf_soundgen('5', fs);
PhoneNum6 = dtmf_soundgen('6', fs);
PhoneNum7 = dtmf_soundgen('7', fs);
PhoneNum8 = dtmf_soundgen('8', fs);
PhoneNum9 = dtmf_soundgen('9', fs);

% Plot the generated DTMF signals
figure;

subplot(3,1,1);
plot(PhoneNum1, 'Color', [0, 0, 0.5]); % Dark Blue
title('DTMF Signal for Key 1');
xlabel('Time (samples)');
ylabel('Amplitude');

subplot(3,1,2);
plot(PhoneNum5, 'Color', [0, 0.5, 0.5]); % Dark Turquoise
title('DTMF Signal for Key 5');
xlabel('Time (samples)');
ylabel('Amplitude');

subplot(3,1,3);
plot(PhoneNum9, 'Color', [0, 0.5, 0]); % Dark Green
title('DTMF Signal for Key 9');
xlabel('Time (samples)');
ylabel('Amplitude');

% ------------------------- ex2 part 2 -------------------------

% Define the individual tones
tones = [697, 770, 852, 941, 1209, 1336, 1477];

plot_cross_correlation_with_phone_numbers(tones, PhoneNum1, PhoneNum5, PhoneNum9, fs);

% ------------------------- ex2 part 3 -------------------------

tones = [697, 770, 852, 941, 1209, 1336, 1477];

plot_cross_correlation_with_unknownKey(tones, UnknownKey, fs);

% ANSWER IS 3 for which note is played

% ------------------------- ex2 part 4 -------------------------

sinWaveFreq = 852;
sinWaveTime = 1;
SinWave = sin(2*pi*sinWaveFreq*(0:(1/fs):sinWaveTime));

% ------------------------- ex2 part 5 -------------------------

PhoneNum = dtmf_soundgen(['1', '2', '1', '2', '5', '7', '9', '1', '1', '0'], fs);


function plot_cross_correlation_with_phone_numbers(tones, PhoneNum1, PhoneNum5, PhoneNum9, fs)
    % Generate the individual tone signals
    tone_signals = cell(1, length(tones));
    for i = 1:length(tones)
        tone_signals{i} = sin(2*pi*tones(i)*(0:(1/fs):0.1));
    end

    % Compute and plot the cross-correlation of each DTMF signal with each tone signal
    figure;
    for i = 1:length(tones)
        subplot(length(tones), 1, i);

        % Compute the cross-correlation
        [corr1] = xcorr(PhoneNum1, tone_signals{i});
        [corr5] = xcorr(PhoneNum5, tone_signals{i});
        [corr9] = xcorr(PhoneNum9, tone_signals{i});

        % Plot the cross-correlation
        plot(linspace(0, length(corr1)/fs, length(corr1)), corr1, 'Color', [1, 0, 0]); hold on;
        plot(linspace(0, length(corr5)/fs, length(corr5)), corr5, 'Color', [0, 1, 0]); 
        plot(linspace(0, length(corr9)/fs, length(corr9)), corr9, 'Color', [0, 0, 1]); 
        title(['Cross-Correlation of 1,5,9 with ', num2str(tones(i)), ' Hz Tone']);
        xlabel('Time');
        ylabel('Cross-Correlation');
        legend('1', '5', '9');
        hold off;
    end
end

% ------------------------- ex2 part 3 -------------------------

% UnknownKey is in workspace already

function plot_cross_correlation_with_unknownKey(tones, unknownKey, fs)
    % Generate the individual tone signals
    tone_signals = cell(1, length(tones));
    for i = 1:length(tones)
        tone_signals{i} = sin(2*pi*tones(i)*(0:(1/fs):0.1));
    end

    % Compute and plot the cross-correlation of each DTMF signal with each tone signal
    figure;
    for i = 1:length(tones)
        subplot(length(tones), 1, i);

        % Compute the cross-correlation
        [corr1] = xcorr(unknownKey, tone_signals{i});

        % Plot the cross-correlation
        plot(linspace(0, length(corr1)/fs, length(corr1)), corr1, 'Color', [0.5, 0, 0.7]); hold on;
        title(['Cross-Correlation of 1,5,9 with ', num2str(tones(i)), ' Hz Tone']);
        xlabel('Time');
        ylabel('Cross-Correlation');
        legend('1', '5', '9');
        hold off;
    end
end


function PhoneNum = dtmf_soundgen(KeyNames , fs)
    % DTMFDIAL Create a signal vector of tones which will dial a
    % DTMF telephone system.
    %
    % usage: PhoneNum = dtmfdial(KeyNames , fs)
    % KeyNames = a vector of characters containing valid key names
    % fs = sampling frequency
    % PhoneNum = signal vector that is the concatenation of DTMF tones
    %

    playSound = 0;

    dtmf.Keys = ['1', '2', '3';
    '4', '5', '6';
    '7', '8', '9';
    '*', '0', '#'];


    dtmf.colTones = ones(4 ,1)*[1209 , 1336 , 1477];
    dtmf.rowTones = [697; 770; 852; 941]* ones (1 ,3);


    % I want to make a time vector from 0 to 0.5 seconds
    number_time_vec = [0:1/fs:(0.5 - 1/fs)];

    silence_time_vec = 0 * [0:1/fs:(0.05 - 1/fs)];

    PhoneNum = [];

    for i=1:length(KeyNames)
        [R,C] = find(dtmf.Keys == KeyNames(i));
        
        currentNumTone = sin(2*pi*dtmf.rowTones(R,C)*number_time_vec) + sin(2*pi*dtmf.colTones(R,C)*number_time_vec);
        PhoneNum = [PhoneNum, currentNumTone, silence_time_vec];
    end
    
    if playSound
        soundsc(PhoneNum, fs);
    end

end



