%  EXERCISE 3: 1D Moving Average

tc = linspace(0, 1, 101);
xc = humps(tc);
td = linspace(0, 1, 11);
xd = humps(td);
figure(1); clf

plot(tc, xc, 'b-')
hold on
plot(td, xd, 'bo')


% defining the moving average filter
h_2 = ones(1,2)/2;
h_5 = ones(1,5)/5;

% applying the moving average filter
yd_2 = conv(xd, h_2, 'same');
yd_5 = conv(xd, h_5, 'same');

plot(td, yd_2, 'r-o');
plot(td, yd_5, 'g-o');

title('IP1 EX3 Plot1 (ay140)')

hold off
