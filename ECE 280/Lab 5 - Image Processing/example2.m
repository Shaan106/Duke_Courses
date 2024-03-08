% FILEPATH: /Users/shaanyadav/Desktop/Duke Courses/ECE 280/Lab 5 - Image Processing/example2.m
% This code creates a grayscale image with intensity values ranging from 0 to 255.
% It displays the image using the 'gray' colormap and adds a colorbar.
b = 0:255;
figure(1); clf
image(b) 
colormap gray; colorbar