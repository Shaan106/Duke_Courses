% EXAMPLE 7: 1D Convolution Using ’same’

x = [ 1 , 2 , 4 , 8 , 7 , 5 , 1 ];
h = [ 1 , -1];
y = conv(x , h , 'same');