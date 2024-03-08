% Define the radius and delta values
rad = 100;
del = 10;

% Create a meshgrid of x and y values
[x, y] = meshgrid((-3*rad-del):(3*rad+del));

% Get the size of the meshgrid
[rows, cols] = size(x);

% --------change here--------
p = 0.005;
comp = @(x, y, xc, yc) (1 ./ (1 + (p * sqrt((x-xc).^2+(y-yc).^2))));

% Create an empty image matrix with the specified size
venn_img = zeros(rows, cols, 3);

% Set the red channel of the image based on the distance from the first circle center
venn_img(:,:,1) = (comp(x, y, rad.*cos(0), rad.*sin(0)));

% Set the green channel of the image based on the distance from the second circle center
venn_img(:,:,2) = (comp(x, y, rad.*cos(2*pi/3), rad.*sin(2*pi/3)));

% Set the blue channel of the image based on the distance from the third circle center
venn_img(:,:,3) = (comp(x, y, rad.*cos(4*pi/3), rad.*sin(4*pi/3)));

% Create a new figure and clear it
figure(1); clf

% Display the image
image(venn_img)

% Set the aspect ratio of the plot to be equal
axis equal% Add a title to the plot
title('IP1 EX1 Plot2 (ay140)')
