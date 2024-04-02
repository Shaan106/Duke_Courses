% x = imread('coins.png');

% 399x399 matrix of random numbers
x = randi([0,255],399,399);
x = x(2:end, 2:end);
figure(1); clf
image(x); axis equal; colormap gray; colorbar
title('Original (ay140)');

X = fft2(x);
Xs = fftshift(X);
figure(2); clf
imagesc(log10(abs(Xs))); axis equal; colormap gray; colorbar
title('2(ay140)');

[rows, cols] = size(x);
max_size = max(rows, cols);
rnorm = rows/max_size; cnorm = cols/max_size;
[v, u] = meshgrid(linspace(-cnorm, cnorm, cols),...
    linspace(-rnorm, rnorm, rows)) ;
% filter = sqrt(u.^2+v.^2)<0.006;
filter = (abs(u)<0.006) & (abs(v)<0.006);

figure(3); clf
imagesc(filter); axis equal; colormap gray; colorbar
title('3 (ay140)');

Xsfiltered = Xs.*filter;

figure(4); clf
imagesc(log10(abs(Xsfiltered))); axis equal; colormap gray; colorbar
title('4(ay140)');

Xfiltered = ifftshift(Xsfiltered);
xfiltered = ifft2(Xfiltered);
figure(5); clf
imagesc(real(xfiltered), [0, 255]); axis equal; colormap gray; colorbar
title('Filtered Image (ay140)');

figure(6); clf
imagesc(real(xfiltered)); axis equal; colormap gray; colorbar
title('Filtered Image (ay140)');

figure (7); clf
title('Filtered Image (ay140)');
surfc ( real(xfiltered) ); colormap gray ; shading interp ; colorbar