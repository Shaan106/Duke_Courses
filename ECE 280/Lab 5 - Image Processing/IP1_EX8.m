x = imread('Philips_PM5544.png');

figure(1); clf
image(x)
axis equal; colorbar
title('Original Test Card (ay140)')


boxBlurkernelSize = 21;
boxBlurKernel = ones(boxBlurkernelSize) / (boxBlurkernelSize^2);

y1(:,:,1) = conv2(x(:,:,1), boxBlurKernel, 'valid');
y1(:,:,2) = conv2(x(:,:,2), boxBlurKernel, 'valid');
y1(:,:,3) = conv2(x(:,:,3), boxBlurKernel, 'valid');

y1_show = uint8(y1);

figure(2); clf
image(y1_show)
axis equal; colorbar
title('Box Blur Test Card (ay140)')


gaussianBlurKernal = 1/256 * [1 4 6 4 1]' * [1 4 6 4 1];

y2(:,:,1) = conv2(x(:,:,1), gaussianBlurKernal, 'valid');
y2(:,:,2) = conv2(x(:,:,2), gaussianBlurKernal, 'valid');
y2(:,:,3) = conv2(x(:,:,3), gaussianBlurKernal, 'valid');

y2_show = uint8(y2);

figure(3); clf
image(y2_show)
axis equal; colorbar
title('Gaussian Blur Test Card (ay140)')


SobelXKernel = [1 0 -1;
                2 0 -2;
                1 0 -1];

SobelYKernel = [1 2 1;
                0 0 0;
                -1 -2 -1];

y3(:,:,1) = conv2(x(:,:,1), SobelXKernel, 'valid');
y3(:,:,2) = conv2(x(:,:,2), SobelXKernel, 'valid');
y3(:,:,3) = conv2(x(:,:,3), SobelXKernel, 'valid');

y3_show = uint8(y3);

figure(4); clf
image(y3_show)
axis equal; colorbar
title('Sobel Vertical Edges Test Card (ay140)')


y4(:,:,1) = conv2(x(:,:,1), SobelYKernel, 'valid');
y4(:,:,2) = conv2(x(:,:,2), SobelYKernel, 'valid');
y4(:,:,3) = conv2(x(:,:,3), SobelYKernel, 'valid');

y4_show = uint8(y4);

figure(5); clf
image(y4_show)
axis equal; colorbar
title('Sobel Horizontal Edges Test Card (ay140)')


sobelResult = sqrt(y3.^2 + y4.^2);
sobelResult = uint8(sobelResult);


figure(6); clf
image(sobelResult)
axis equal; colorbar
title('Sobel Edges Test Card (ay140)')
