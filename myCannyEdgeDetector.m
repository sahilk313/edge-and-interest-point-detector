function [ FinalIm ] = myCannyEdgeDetector( img,threshold )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%threshold should be a [lthres hthres]
%change the function to take image as input instead of location


I = img;
%imshow(I);
lthres = threshold(1,1);
hthres = threshold(1,2);

if(hthres>1 || lthres<=0)
    disp('lower thres should be >=0 and higher should be <1');
else

    i = rgb2gray(I);
    i = im2double(i);

%     e = edge(i,'canny',[lthres,hthres]);
%     imshow(e);

    kernel = fspecial('gaussian',5,3);
    im = imfilter(i,kernel);
    gradXkernel = [-1 0 1;-2 0 2;-1 0 1];
    gradYkernel = [1 2 1;0 0 0;-1 -2 -1];
    gradXkernel = im2double(gradXkernel);
    gradYkernel = im2double(gradYkernel);
    gradX = imfilter(im,gradXkernel);
    gradY = imfilter(im,gradYkernel);
    %imshow([im,gradX,gradY]);

    gradMagnitude = sqrt(gradX.^2 + gradY.^2);

    [a,b]=size(gradX);
    gradOrient = zeros([a b]);
    for i=1:a
          for j=1:b
                if(gradX(i,j)==0)
                   gradOrient(i,j) = pi/2;
                   gradOrient(i,j) = gradOrient(i,j)*(180/pi);
                else
                    gradOrient(i,j) = atan(gradY(i,j)/gradX(i,j));
                    gradOrient(i,j) = gradOrient(i,j)*(180/pi);
                end
                if(gradOrient(i,j)<0)
                   gradOrient(i,j) = gradOrient(i,j) + 360;
                end
                if (((0<=gradOrient(i,j))&&(gradOrient(i,j)<22.5))||((157.5<=gradOrient(i,j))&&(gradOrient(i,j)<202.5))||((337.5<=gradOrient(i,j))&&(gradOrient(i,j)<=360)))
                    gradOrient(i,j)=0;
                elseif ((gradOrient(i, j) >= 22.5) && (gradOrient(i, j) < 67.5) || (gradOrient(i, j) >= 202.5) && (gradOrient(i, j) < 247.5))
                    gradOrient(i,j)=45;
                elseif (((gradOrient(i, j) >= 67.5 && gradOrient(i, j) < 112.5) || (gradOrient(i, j) >= 247.5 && gradOrient(i, j) < 292.5)))
                    gradOrient(i,j)=90;
                elseif ((gradOrient(i, j) >= 112.5 && gradOrient(i, j) < 157.5) || (gradOrient(i, j) >= 292.5 && gradOrient(i, j) < 337.5))
                    gradOrient(i,j)=135;
                end
          end
    end
    %figure, imshow(gradMagnitude);
    [gradSup] = nonMaximalSuppression(gradMagnitude,gradOrient);

    %figure, imshow(gradSup);
    [FinalIm] = myHysteresis(gradSup,lthres,hthres);
    figure,
    imshow(FinalIm);
    title('Output of myCannyEdgeDetector');
end

end

