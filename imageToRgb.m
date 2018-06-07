function I_rgb=imageToRgb(I)
[row,col,sl] = size(I);
K = uint8(ones(row,col));
r = I(:,:,1);
g = I(:,:,2);
b = I(:,:,3);
K = (0.2126 .* r) + (0.7152 .*g) + (0.0722 .*b);

I_rgb=K;

end