[x, y] = meshgrid(linspace(0, 2*pi, 201));
z = cos(x).*cos(2*y);
figure(1); clf
imagesc(z)
axis equal; colormap gray; colorbar