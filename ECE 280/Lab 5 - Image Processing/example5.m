[x, y] = meshgrid(linspace(0, 1, 256));
other = 0.5;
palette = zeros(256, 256, 3);
palette(:,:,1) = x;
palette(:,:,2) = y;
palette(:,:,3) = other;
figure(1); clf
imagesc(palette)
axis equal