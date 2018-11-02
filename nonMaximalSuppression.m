function [ gradSup ] = nonMaximalSuppression( gradMagnitude, gradOrient )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[a, b]= size(gradMagnitude);
gradSup = zeros (a,b);

for i=2:a-1
    for j=2:b-1
        if (gradOrient(i,j)==0)
            if (gradMagnitude(i,j) == max([gradMagnitude(i,j), gradMagnitude(i,j+1), gradMagnitude(i,j-1)]));
                gradSup(i,j) = gradMagnitude(i,j);
            else
                gradSup(i,j) = 0;
            end
        elseif (gradOrient(i,j)==45)
            if(gradMagnitude(i,j) == max([gradMagnitude(i,j), gradMagnitude(i+1,j-1), gradMagnitude(i-1,j+1)]));
               gradSup(i,j) = gradMagnitude(i,j);
            else
                gradSup(i,j) = 0;
            end
        elseif (gradOrient(i,j)==90)
            if(gradMagnitude(i,j) == max([gradMagnitude(i,j), gradMagnitude(i+1,j), gradMagnitude(i-1,j)]));
               gradSup(i,j) = gradMagnitude(i,j);
            else
                gradSup(i,j) = 0;
            end
        elseif (gradOrient(i,j)==135)
            if(gradMagnitude(i,j) == max([gradMagnitude(i,j), gradMagnitude(i+1,j+1), gradMagnitude(i-1,j-1)]));
               gradSup(i,j) = gradMagnitude(i,j);
            else
                gradSup(i,j) = 0;
            end
        end
    end
end

end

