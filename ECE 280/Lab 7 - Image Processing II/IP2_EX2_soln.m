
A = [-3.4271, -0.0729, -0.0729, -3.4271, 12.0000];

B = [-0.1388, -4.0287, 4.0287, 0.1388, -0.0000];

X = [-3.4271 + 0.1388i,  -0.0729 + 4.0287i,  -0.0729 - 4.0287i,  -3.4271 - 0.1388i, 12.0000 + 0.0000i]

trig_synth(A, B);

exp_synth(X);

function x = trig_synth(A, B)

    x = zeros(1, 5);

    M = 5;

    for m = 1:5
        for k = 1:5
            x(m) = x(m) + (1/M) * (A(k) * cos(((2*pi)/M)*k*m) + B(k) * sin(((2*pi)/M)*k*m));
        end
    end

    disp(x);
end


function x = exp_synth(X)

    x = zeros(1, 5);

    M = 5;

    for m = 1:5
        for k = 1:5
            x(m) = x(m) + (1/M) * X(k) * exp(1i * (2*pi/M) * k * m);
        end
    end

    x = real(x);

    disp(x);

end