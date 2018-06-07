imgSet = imageSet('Data');
Img=(read(imgSet,1029));
%Img_rgb= rgb2gray(Img);
Img_rgb= imageToRgb(Img);
Img_binary= imageToBinary(Img_rgb);
%imshow(Img_binary);

img=Img_binary;
[x,y]=find(img==0);
[r,c] = size(Img_binary);
x_cor=[];
y_cor=[];
for i=1:r
    for j=1:c
        if img(i,j)==0
            x_cor = [x_cor; i];
            y_cor = [y_cor; j];
        end
    end
end
x_cmax = max(x_cor(:));
x_cmin = min(x_cor(:));

y_cmax = max(y_cor(:));
y_cmin = min(y_cor(:));

Img_crop= img(x_cmin:x_cmax,y_cmin:y_cmax);


Img_resize = imresize(Img_crop,[64 64]);
for i=1:64
    for j=1:64
        if Img_resize(i,j)==0
            Img_resize(i,j) = 1;
        else
            Img_resize(i,j) = 0;
        end
    end
end
imshow(Img_resize);