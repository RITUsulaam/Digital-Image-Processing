% Implementing JPEG ALgorithm using DCT coefficients.
% Created By : Sumant W.
clc; clear all; close all;


%% Reading an input image 
image=double((imread('Minion.png')));

%% Computing the size of an image
[m1,n1,dim]=size(image);
z=min(m1,n1);

%% Threshold Value
prompt = 'Enter the threshold value?  ';
thresh = input(prompt);
      
%% Resize the image to make it square
image_square=(imresize(image,[z z]));

%% Compute the size of a square image
[m2,n2]=size(image_square);

%% Calculation the DCT basis matrix
for i=1:m2
    for j=1:m2
        if(i==1)
          z(i,j)=sqrt(1/n2)*(cos((((2*j-1)*(i-1)*pi))/(2*n2)));
        else
          z(i,j)=sqrt(2/n2)*(cos((((2*j-1)*(i-1)*pi))/(2*n2))); 
        end
    end
end

%% Calculate the DCT coefficents for each RGB components of an image
DCT_red=z*image_square(:,:,1)*z';
DCT_green=z*image_square(:,:,2)*z';
DCT_blue=z*image_square(:,:,3)*z';


%% Truncating the DCT coefficients to achieve compression for each channel
DCT_red(abs(DCT_red)<thresh)=0;
DCT_green(abs(DCT_green)<thresh)=0;
DCT_blue(abs(DCT_blue)<thresh)=0;

DCT(:,:,1)=DCT_red;
DCT(:,:,2)=DCT_green;
DCT(:,:,3)=DCT_blue;
%% Reconstruction of the compresed image from each channel
image_compressed(:,:,1)=z'*DCT_red*z;
image_compressed(:,:,2)=z'*DCT_green*z;
image_compressed(:,:,3)=z'*DCT_blue*z;

imwrite(uint8(image_compressed),'Compressed_image_coloured.jpeg');

%% Plotting the results
figure();
subplot(121);
imshow(uint8(image_square)),title('Original image');
subplot(122);
imshow(uint8(image_compressed)),title('Compressed image');
