


% This function is used for finding the number of white pixels
% and black pixels in a grid
function [nw,nb] = calculateWhiteBlackPixels(neigh)
[row,col] = size(neigh);

white=0;
black=0;
for i=1:row
    for j=1:col
        pixelIntensity = neigh(i,j);
        if pixelIntensity==1
             white=white+1;   
        elseif pixelIntensity==0
            black=black+1;
        end
    end
end
nw=white;
nb=black;
end
