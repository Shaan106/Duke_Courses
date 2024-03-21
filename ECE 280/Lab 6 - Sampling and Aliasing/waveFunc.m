

function [t, x] = generate_sinusoidal(f0, A, fs)
    % generate_sinusoidal generates samples of a sinusoidal signal.
    % Inputs:
    %   f0: frequency of the sinusoidal signal
    %   A: amplitude of the sinusoidal signal
    %   fs: sampling rate
    % Outputs:
    %   t: time vector
    %   x: sinusoidal signal vector
    
    T = 1/fs;            % Sampling period
    t = 0:T:0.01-T;      % Time vector from 0 to 10 ms
    x = A * sin(2 * pi * f0 * t);  % Sinusoidal signal
end