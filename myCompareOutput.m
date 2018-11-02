function [ newim ] = myCompareOutput( img, threshold )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
I = img;
i = rgb2gray(I);

i1 = myCannyEdgeDetector(img,threshold);
i2 = edge(i,'canny',threshold);
figure, imshow([i1,i2]);
title('1.My edge output                                                                                    2.In-built edge output');
i2 = im2double(i2);
hn1 = imhist(i1)./numel(i1);
hn2 = imhist(i2)./numel(i2);
euc = sum(sqrt(abs(hn2 - hn1)).^2);
mypsnr = psnr(im2double(i1),im2double(i2));
fprintf('The images eucledian distance is: %d\n',euc);
fprintf('Their PSNR value is: %d \n',mypsnr);

figure;
mesh(i2-i1)
colormap default
title('Colored difference map');

newim = abs(i2-i1);
[a,b] = size(newim);
for i=2:3:a-1
    for j=2:3:b-1
        if(max(max(newim(i-1:i+1,j-1:j+1)))>0)
            newim(i-1:i+1,j-1:j+1) = 0;
            newim(i,j) = 1;
        end
    end
end

[x,y] = size(i1);
newim = zeros(x,y);

for i = 4:7:x-4
    for j =4:7:y-4
        newim(i,j) = sqrt(sum(sum((i2(i-3:i+3,j-3:j+3)-i1(i-3:i+3,j-3:j+3)).^2)));
    end
end

figure,imshow(newim);
title('Blockwise summary matrix');




end

