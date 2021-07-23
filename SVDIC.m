close all
clear all
clc
image = imread('plane.jpg');
grayimage = rgb2gray(image);
imageD=double(grayimage);
%The above steps are used to read an image and to convert the image to gray scale and to store the converted image inta a class double.
%now lets decompose the image matrix by using singular value decomposition
[U,S,V] = svd(imageD);
%now lets use different singular values and reconstruct our image
DisplayError = [];
NoOfSingularValues = [];
for N = 10:30:100
  %now lets store the in an another variable temporarly
  C = S;
  %now let us eliminate the singular values which are not required for the compression
C(N+1:end,:)=0;
C(:,N+1:end)=0;
% Now let us construct the image using the reduced singular values
M = U*C*V';
% now lets display the computed error
figure;
out = sprintf('Image output using %d singular values', N)
imshow(uint8(M));
title(out);
error=sum(sum((imageD-M).^2));
%now let us store the values to displayend
DisplayError = [DisplayError; error];
NoOfSingularValues = [NoOfSingularValues; N];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% image Compression for the coloured images
filename = 'plane.jpg';
[X, map] = imread(filename);
figure('Name','ORIGINAL component of the imported image');
imshow(X);
imwrite(X, '!original.jpg');
R = X(:,:,1);
G = X(:,:,2);
B = X(:,:,3);
Rimg = cat(3, R, zeros(size(R)), zeros(size(R)));
Gimg = cat(3, zeros(size(G)), G, zeros(size(G)));
Bimg = cat(3, zeros(size(B)), zeros(size(B)), B);
figure('Name','RED component of the imported image');
imshow(Rimg);
imwrite(Rimg, '!red.jpg');
figure('Name','GREEN component of the imported image');
imshow(Gimg);
imwrite(Gimg, '!green.jpg');
figure('Name','BLUE component of the imported image');
imshow(Bimg);
imwrite(Bimg, '!blue.jpg');
Red =double(R);
Green = double(G);
Blue = double(B);
N = 1;
% Compute values for the red image
[U,S,V]=svd(Red);
C = S;
C(N+1:end,:)=0;
C(:,N+1:end)=0;
Dr=U*C*V';
% Rebuild the data back into a displayable image and show it
figure;
buffer = sprintf('Red image output using %d singular values', N);
Rimg = cat(3, Dr, zeros(size(Dr)), zeros(size(Dr)));
imshow(uint8(Rimg));
imwrite(uint8(Rimg), sprintf('%dred.jpg', N));
title(buffer);
% Compute values for the green image
[U2, S2, V2]=svd(Green);
C = S2;
C(N+1:end,:)=0;
C(:,N+1:end)=0;
Dg=U2*C*V2';
% Rebuild the data back into a displayable image and show it
figure;
buffer = sprintf('Green image output using %d singular values', N);
Gimg = cat(3, zeros(size(Dg)), Dg, zeros(size(Dg)));
imshow(uint8(Gimg));
imwrite(uint8(Gimg), sprintf('%dgreen.jpg', N));
title(buffer);
% Compute values for the blue image
[U3, S3, V3]=svd(Blue);
C = S3;
C(N+1:end,:)=0;
C(:,N+1:end)=0;
Db=U3*C*V3';
% Rebuild the data back into a displayable image and show it
figure;
buffer = sprintf('Blue image output using %d singular values', N);
Bimg = cat(3, zeros(size(Db)), zeros(size(Db)), Db);
imshow(uint8(Bimg));
imwrite(uint8(Bimg), sprintf('%dblue.jpg', N));
title(buffer);
% Thake the data from the Red, Green, and Blue image
% Rebuild a colored image with the corresponding data and show it
figure;
buffer = sprintf('Colored image output using %d singular values', N);
Cimg = cat(3, Dr, Dg, Db);
imshow(uint8(Cimg));
imwrite(uint8(Cimg), sprintf('%dcolor.jpg', N));
