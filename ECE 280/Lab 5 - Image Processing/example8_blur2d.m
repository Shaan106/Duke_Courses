x = imread('coins.png');
h = ones(10, 10)/10^2;
y = conv2(x, h, 'same');
figure(1); clf
image(x)
axis equal; colormap gray; colorbar
title('Original')
figure(2); clf
image(y)
axis equal; colormap gray; colorbar
title('10x10 Blur')