clear
img = imread('coloredChips.png');
figure(1); clf
image(img); axis equal

h = [1 0 -1; 2 0 -2; 1 0 -1]
for k=1:3
    y(:,:,k) = conv2(img(:,:,k), h, 'valid');
    figure(1+k); clf
    imagesc(y(:,:,k), [-1020, 1020]); 
    axis equal; colormap gray; colorbar
    figure(4+k); clf
    imagesc(abs(y(:,:,k)), [0, 1020]); 
    axis equal; colormap gray; colorbar
end
%%
yx = (y+max(abs(y(:)))) / 2 / max(abs(y(:)));
figure(8); clf
image(yx); axis equal

yg = sqrt(y(:,:,1).^2 + y(:,:,2).^2 + y(:,:,3).^2);
ygs = abs(yg) / max(yg(:)) * 255;
figure(9); clf
image(ygs); colormap gray; axis equal