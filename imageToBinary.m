function I_binary=imageToBinary(I)
[row,col] = size(I);
K = uint8(zeros(row,col));
for i=1:row
    for j=1:col
        if I(i,j) <=128
            K(i,j)= 0;
        else
            K(i,j) = 1;
        end
    end
end
K = logical(K);
I_binary=K;
end