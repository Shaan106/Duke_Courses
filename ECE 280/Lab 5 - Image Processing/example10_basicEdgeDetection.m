[x, y] = meshgrid(linspace(-1, 1, 200));
z1 = (.7<sqrt(x.^2+y.^2)) & (sqrt(x.^2+y.^2)<.9);
z2 = (.3<sqrt(x.^2+y.^2)) & (sqrt(x.^2+y.^2)<.5);
zimg = 100*z1+200*z2;
figure(1); clf
image(zimg); 
axis equal; colormap gray; colorbar; title('Original')

hx = [1 -1; 1 -1];
edgex = conv2(zimg, hx, 'valid');
figure(2); clf
imagesc(edgex, [-512, 512]); 
axis equal; colormap gray; colorbar; title('Vertical Edges')

hy = hx';
edgey = conv2(zimg, hy, 'valid');
figure(3); clf
imagesc(edgey, [-512, 512]); 
axis equal; colormap gray; colorbar; title('Horizontal Edges')

edges = sqrt(edgex.^2 + edgey.^2);
figure(4); clf
imagesc(edges); 
axis equal; colormap gray; colorbar; title('Edges')