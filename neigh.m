
clc;
clear all;
close all;

I = imread('m.jpg');
I = rgb2gray(I);

[y,x] = size(I);
new = [zeros(y,1),I,zeros(y,1)];
new = [zeros(1,x+2);new;zeros(1,x+2)];


I_New = zeros(y,x);
for Row = 1:y
    for Col = 1:x
        ithrow = Row+1; %Save the current Row and Col Values
        ithcol = Col+1;
        
        ithpixel = new(ithrow,ithcol);
                
        newpixel = 1*(ithpixel<new(ithrow,ithcol+1))+ 2*(ithpixel<new(ithrow-1,ithcol+1))+...
            4*(ithpixel<new(ithrow-1,ithcol))+ 8*(ithpixel<new(ithrow-1,ithcol-1))+...
            16*(ithpixel<new(ithrow,ithcol-1))+ 32*(ithpixel<new(ithrow+1,ithcol-1))+...
            64*(ithpixel<new(ithrow+1,ithcol))+ 128*(ithpixel<new(ithrow+1,ithcol+1)); %Calculation of New Value of Pixel
        
        I_New(Row,Col) = newpixel;
    end
end
I_New = uint8(I_New); %Convert to Unsigned 8-Bit Data Type

figure(2);
subplot(121);
imshow(I);
title('Original Image');

subplot(122);
imshow(I_New);
title('Nearneighbourhood Image');