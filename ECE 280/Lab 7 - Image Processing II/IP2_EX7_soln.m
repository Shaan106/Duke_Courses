% x = imread('coins.png');
x = randi([0, 255], 399, 399);
x = x(2:end, 2:end);
figure(1); clf
image(x); axis equal; colormap gray; colorbar

X = fft2(x);
Xs = fftshift(X);
figure(2); clf
imagesc(log10(abs(Xs))); axis equal; colormap gray; colorbar

[rows, cols] = size(x);
max_size = max(rows, cols);
rnorm = rows/max_size; cnorm = cols/max_size;
[v, u] = meshgrid(linspace(-cnorm, cnorm, cols),...
    linspace(-rnorm, rnorm, rows)) ;
% filter = (abs(u)<0.5) & (abs(v)<0.5);

ulim = [0.5 0.1 0.5 0.1];
vlim = [0.5 0.5 0.1 0.1];
for k=1:10
    filter = (abs(u)<ulim(k)) & (abs(v)<vlim(k));
    figure(3); clf
    imagesc(filter); axis equal; colormap gray; colorbar
    
    Xsfiltered = Xs.*filter;
    figure(4); clf
    imagesc(log10(abs(Xsfiltered))); axis equal; colormap gray; colorbar
    
    
    Xfiltered = ifftshift(Xsfiltered);
    xfiltered = ifft2(Xfiltered);
    figure(5); clf
    imagesc(real(xfiltered), [0, 255]); axis equal; colormap gray; colorbar
    title(sprintf('Rectangular LPF Applied to Coins, u = %g, v = %g (ay140)', ulim(k),vlim(k)))

    eval(sprintf('print -dpng IP2_EX7_Plot%0.0f.png', k))
end

% % figure(3); clf
% % imagesc(filter); axis equal; colormap gray; colorbar

% Xsfiltered = Xs.*filter;
% figure(4); clf
% imagesc(log10(abs(Xsfiltered))); axis equal; colormap gray; colorbar

% Xfiltered = ifftshift(Xsfiltered);
% xfiltered = ifft2(Xfiltered);
% figure(5); clf
% imagesc(xfiltered, [0, 255]); axis equal; colormap gray; colorbar