
x = [1, 5, 2, 3, 1];

% A_exp, B_exp, X_exp = analysis(x);

[A_exp, B_exp, X_exp] = analysis(x)

function [A, B, X] = analysis(x)

    M = length(x);

    A = zeros(1, M);
    B = zeros(1, M);
    X = zeros(1, M);

    for k = 1:M
        for m = 1:M
            A(k) = A(k) + x(m) * cos( ((2*pi)/(M)) * m * k);
            B(k) = B(k) + x(m) * sin( ((2*pi)/(M)) * m * k);
            X(k) = X(k) + x(m) * exp( -1i * ((2*pi)/(M)) * m * k);
        end
    end

    disp(A);
    disp(B);
    disp(X);
    % Your code here
    
end