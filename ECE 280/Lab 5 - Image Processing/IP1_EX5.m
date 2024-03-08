x = imread('coins.png');

filter_rows = 50;
filter_cols = 2;

h = ones(filter_rows, filter_cols)/ (filter_rows * filter_cols);

y = conv2(x, h, 'same');
figure(1); clf
image(x)
axis equal; colormap gray; colorbar
title('Original (ay140)')
figure(2); clf
image(y)
axis equal; colormap gray; colorbar
title('50x2 Blur (ay140)')