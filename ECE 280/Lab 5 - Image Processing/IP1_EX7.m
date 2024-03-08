x = imread('coins.png');

filter_size = 5;
sigma = 1.5;

% Create a 5x5 Gaussian filter
h = 1/256 * [1 4 6 4 1]' * [1 4 6 4 1];

prewittOperator_X = [1 0 -1; 
                     1 0 -1; 
                     1 0 -1];

prewittOperator_Y = [1 1 1; 
                     0 0 0; 
                     -1 -1 -1];

eightEdgeKernel = [-1 -1 -1; 
                    -1 8 -1; 
                    -1 -1 -1];

y = conv2(x, h, 'valid');

coinsEdgeX = conv2(x, prewittOperator_X, 'valid');
coinsEdgeY = conv2(x, prewittOperator_Y, 'valid');

eightEdge = conv2(x, eightEdgeKernel, 'valid');

figure(1); clf
image(x)
axis equal; colormap gray; colorbar
title('Original (ay140)')
figure(2); clf
image(y)
axis equal; colormap gray; colorbar
title('Coin Gaussian Blur (ay140)')

figure(3); clf
imagesc(coinsEdgeX)
axis equal; colormap gray; colorbar
title('Coin Vertical Edges (ay140)')

figure(4); clf
imagesc(coinsEdgeY)
axis equal; colormap gray; colorbar
title('Coin Horizontal Edges (ay140)')

% Calculate the square root of the sum of squares
sumOfSq = sqrt(coinsEdgeX.^2 + coinsEdgeY.^2);

figure(5); clf
imagesc(sumOfSq)
axis equal; colormap gray; colorbar
title('Coin Edges (ay140)')

figure(6); clf
imagesc(eightEdge)
axis equal; colormap gray; colorbar
title('Alternate Coin Edges (ay140)')

