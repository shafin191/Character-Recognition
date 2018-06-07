
% Main Function

charmap = ['A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z'];
imgSet = imageSet('Data');
label=1;
R= double(zeros(1040,64));
L= zeros(1040,1);

for a=1:1040

if(mod(a,41)==0)
    label=label+1;
end
I=(read(imgSet,a));
I= rgb2gray(I);
I= imbinarize(I);
%imshow(I);

img=I;
[x,y]=find(img==0);
maxy=max(y);
maxx=max(x);
miny=min(y);
minx=min(x);
img=img(minx:maxx,miny:maxy);
%imshow(img);
imgsize = imresize(img,[64 64]);
%imshow(imgsize);

iminv = imcomplement(imgsize);
%imshow(iminv);


imgthin = bwmorph(iminv,'thin',Inf);
%figure;
%imshow(imgthin);

P=double(zeros(1,64));
[r,c] = size(imgthin);
m=8;
k=0;
for i=1:8:r
    for j=1:8:c
        k=k+1;
        neigh = Neighbour(imgthin,m,i,j );
        [nw,nb] = calculateWhiteBlackPixels(neigh);
  
        P(1,k)=  nw/nb;
    end
end
R(a,1:64)=P(1,1:64);
L(a) = label;
end





%%
%Testing

imgSet = imageSet('test');

label=1;
G= double(zeros(390,64));
%Lp= zeros(390,1);
for a=1:390

if(mod(a,16)==0)
    label=label+1;
end
I=(read(imgSet,a));
I= rgb2gray(I);
I= imbinarize(I);
img=I;
[x,y]=find(img==0);
maxy=max(y);
maxx=max(x);
miny=min(y);
minx=min(x);
img=img(minx:maxx,miny:maxy);
%imshow(img);
imgsize = imresize(img,[64 64]);
%imshow(imgsize);

iminv = imcomplement(imgsize);
%imshow(iminv);


imgthin = bwmorph(iminv,'thin',Inf);
%figure;
%imshow(imgthin);
p=0;
T=double(zeros(1,64));
[r,c] = size(imgthin);
m=8;
k=0;
for i=1:8:r
    for j=1:8:c
        k=k+1;
        neigh = Neighbour(imgthin,m,i,j );
        [nw,nb] = calculateWhiteBlackPixels(neigh);
  
        T(1,k)=  nw/nb;
    end
end
G(a,1:64)=T(1,1:64);
end

Mdl = fitcknn(R,L,'NumNeighbors',3,'Standardize',1);
check = predict(Mdl,G);
%result = charmap(check)

Conf = transpose(reshape(check,[15,26]));
acc=0;
for ip=1:26
    for jp=1:15
        if Conf(ip,jp)==ip
            acc=acc+1;
        end
    end
end
accuracyPerChar = zeros(26,1);
for i=1:26
    cnt = 0;
    for j=1:15
        
        if Conf(i,j) ==i
            cnt = cnt+1;
        end
    end
    accuracyPerChar(i) = cnt/15;
end
            

str = {'A'; 'B'; 'C'; 'D'; 'E'; 'F'; 'G'; 'H'; 'I'; 'J'; 'K';'L'; 'M'; 'N'; 'O'; 'P'; 'Q'; 'R'; 'S'; 'T'; 'U'; 'V'; 'W'; 'X'; 'Y'; 'Z'};
bar(accuracyPerChar)
set(gca, 'XTickLabel',str, 'XTick',1:numel(str))
