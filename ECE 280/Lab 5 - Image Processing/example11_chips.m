
clear;

img = imread('coloredChips.png');
figure(1); clf
title('Original')
image(img); axis equal
vals = (0:255)'/255;
names = {'Red', 'Green', 'Blue'}
for k = 1:3
    figure(k+1); clf
    image(img(:,:,k)); axis equal
    colormap gray; colorbar
    title(names{k}+" as Gray")
    figure(k+4)
    image(img(:,:,k)); axis equal
    cmap = zeros(256, 3);
    cmap(:,k) = vals;
    colormap(cmap); colorbar
    title(names{k}+" as "+names{k})
end