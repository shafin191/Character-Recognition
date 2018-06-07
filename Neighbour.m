




%{
    Name: Ashfaq Ali Shafin
    ID: 14-01-04-111
    Group: C1
    This function is used for extracting the Neighbours of a pixel
%}



function neigh = Neighbour( R,m,xi,yi )
% R is the image, m is window size, xi is the x coordinate and yi is the y coordinate
[row,col] = size(R);

maximum_x = xi+m;
maximum_y = yi+m;
minimum_x = xi;
minimum_y = yi;

if(maximum_x>row)
    maximum_x=row;
end

if(maximum_y>col)
    maximum_y=col;
end

if(minimum_x<=0)
    minimum_x=1;
end

if(minimum_y<=0)
    minimum_y=1;
end

R(xi,yi) = 0;
neigh=R(minimum_x:maximum_x,minimum_y:maximum_y);


end

