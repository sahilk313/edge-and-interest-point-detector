function [ FinalIm ] = myHysteresis( gradSup,lthres,hthres )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
lthres = lthres*max(max(gradSup));
hthres = hthres*max(max(gradSup));
[a, b]=size(gradSup);
tempIm=zeros([a b]);
for i=2:a-1
    for j=2:b-1
        if(gradSup(i,j)>hthres)
            tempIm(i,j)=1;
        elseif(gradSup(i,j)<lthres)
            tempIm(i,j)=0;
        elseif ( gradSup(i+1,j)>hthres || gradSup(i-1,j)>hthres || gradSup(i,j+1)>hthres || gradSup(i,j-1)>hthres || gradSup(i-1, j-1)>hthres || gradSup(i-1, j+1)>hthres || gradSup(i+1, j+1)>hthres || gradSup(i+1, j-1)>hthres)
            tempIm(i,j) = 1;
        end
    end
end
FinalIm=tempIm;



end

