function [ ] = myDetectInterest( image,threshold )
G = image;
G2 = myCannyEdgeDetector(G,threshold);

Xfilter = [1 0 -1; 2 0 -2; 1 0 -1];
Yfilter = [1 2 1; 0 0 0 ; -1 -2 -1];

Ix = imfilter(G2, Xfilter);
Iy = imfilter(G2, Yfilter);

f = fspecial('gaussian',5,2);
Ix2 = imfilter(Ix.^2, f);
Iy2 = imfilter(Iy.^2, f);
Ixy = imfilter(Ix.*Iy, f);

k = 0.04;

[num_rows,num_cols] = size(G2);

H = zeros(num_rows, num_cols);

% get matrix M for each pixel
for i = 3:num_rows-2        
    for j = 3:num_cols-2      
        Ix2_matrix = Ix2(i-2:i+2,j-2:j+2);
        Ix2_sum = sum(Ix2_matrix(:));
        Iy2_matrix = Iy2(i-2:i+2,j-2:j+2);
        Iy2_sum = sum(Iy2_matrix(:));
        Ixy_matrix = Ixy(i-2:i+2,j-2:j+2);
        Ixy_sum = sum(Ixy_matrix(:));
        Matrix = [Ix2_sum, Ixy_sum; 
                  Ixy_sum, Iy2_sum];
        R = det(Matrix) - (k * trace(Matrix)^2);
        H(i,j) = R;
    end
end
threshold = 750;

[a,b] = size(H);
fin = zeros(a,b);
for i=1:a
    for j=1:b
        if H(i,j)>=threshold
            fin(i,j)=H(i,j);
        end
    end
end

for i=2:a-1
    for j=2:b-1
        if(fin(i,j)>0)
            if(fin(i,j)==max(max(fin(i-1:i+1,j-1:j+1))))
                fin(i,j) = 1;
            else
                fin(i,j) = 0;
            end
        else
            fin(i,j) = 0;
        end
    end
end
figure, imshow(G);
hold on
for i=1:2:a
    for j=1:2:b
        if fin(i,j)==1;
            plot(j,i,'r*');
        end
    end
end

hold off
title('CORNERS DETECTED');
end