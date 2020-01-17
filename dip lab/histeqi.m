%Image Histogram Equilization
clc;
close all;
format long g;
format compact;
fontSize = 20;
grayImage = imread('Unequalized_Hawkes_Bay_NZ.jpg');
% Get the dimensions of the image.
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);
ah=uint8(zeros(rows,columns));
n=rows*columns;
f=zeros(256,1);
pdf=zeros(256,1);
cdf=zeros(256,1);
out=zeros(256,1);
for i=1:rows
for j=1:columns
value=grayImage(i,j);
f(value+1)= f(value+1)+1;
pdf(value+1)= f(value+1)/n;
end
end
sum=0; l=255;
for i=size(pdf)
sum=sum+f(i);
cum(i)=sum;
cdf(i)=cum(i)/n;
out(i)=round(cdf(i)*l);
end
for i=1:rows
for j=1:columns
ah(i,j)=out(grayImage(i,j)+1);
end
end
subplot(1,2,1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
drawnow;
he=histeq(grayImage);
subplot(1,2, 2);
imshow(he, []);
title('Histogram Equalized Image', 'FontSize', fontSize);