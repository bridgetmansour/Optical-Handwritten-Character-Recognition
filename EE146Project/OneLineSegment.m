clear;
clc;
close all;

% load('NNonlyWorkspace.mat')

colorImage = imread('CapitalTest2.jpg');
I = rgb2gray(colorImage);

I = imresize(I, [750 600]);
I2 = imbinarize(I);
BW = imcomplement(I2);

BW2 = bwareaopen(BW,7);
se = strel('disk',1);
BW2 = imdilate(BW2,se);
figure, imshow(BW2)

horizontalProfile = sum(BW2, 1);

bw3 = BW2;
h1 = sum(bw3,2);
figure
plot(sum(bw3,2),1:size(bw3,1));


[pks1,locs1] = findpeaks(h1,'MinPeakDistance',80);
meanCycle1 = mean(diff(locs1))
if(isnan(meanCycle1))
    
    delta1 = 80;
else
    delta1 = ceil((meanCycle1-15)/2);
end

for i = 1:length(pks1)
    
    figure
    BWline(:,:,i) = BW2((locs1(i)-delta1-5):(locs1(i)+delta1+5),:);
    imshow(BWline(:,:,i))
    imshow(BW2((locs1(i)-delta1):(locs1(i)+delta1),:))
    
 
end

% figure 
% plot(1:size(BWline(:,:,1),2),sum(BWline(:,:,1),1));
h2(i,:) = sum(BWline(:,:,i),1);
[pks2,locs2] = findpeaks(h2,'MinPeakDistance',50);
    
V = var(BWline(locs2(1),:))
    
% [L,num] = bwlabel(BW2((locs1(1)-delta1):(locs1(1)+delta1),:));
% stats = regionprops(L,'All');
    
cc = bwconncomp(BW2((locs1(1)-delta1):(locs1(1)+delta1),:));
stats = regionprops(cc,'All');

Boxes = cat(1, stats.BoundingBox);
bwArea = cat(1,stats.Area);
Ibox = insertShape(double(BWline(:,:,1)),'Rectangle',Boxes);

% figure
% imshow(Ibox,[])

idx = find([stats.Area] > 54); 
bw = ismember(labelmatrix(cc), idx); 
bw = padarray(bw,[10 10],0);

% figure
% imshow(bw)
cc2 = bwconncomp(bw);
stats2 = regionprops(cc2,'BoundingBox');

Bx = cat(1,stats2.BoundingBox);
Ib = insertShape(double(bw),'Rectangle',Bx);

figure
imshow(Ib,[])

for i = 1:length(Bx(:,1))

    lets(:,:,i) = imresize((bw((Bx(i,2)-2):(Bx(i,2)+Bx(i,4)+2),(Bx(i,1)-2):(Bx(i,1)+Bx(i,3)+2))),[28 28]);
%     figure
%     imshow(lets(:,:,i))
    se = strel('disk',1);
    Idil = imdilate(lets(:,:,i),se);
    B = padarray(Idil,[5 5],0);
    letters(i) = NNreturnLetter(B);

end
%  b = [a(1:2) 3 a(3:end)];
% dif(1) = Bx(1,1)+Bx(1,3) - Bx(2,1);
dif(1) = 0;
for j = 2:length(Bx(:,1))
   
%     dif = Bx(j-1,1)+Bx(j-1,3) - Bx(j,1);
    dif(j-1) = Bx(j,1) - Bx(j-1,1) - Bx(j-1,3);
    
    if abs(dif(j-1)) > 20
        space(j-1) = 27;
    else
        space(j-1) = 33;
    end
    
end

space(length(Bx(:,1))) = 33;

letters;

D = [letters; space];
D = D(:)';
Sent = ReturnLetter3(D)
% for i = 1:length(D)
%     Sent(i) = ReturnLetter2(D(i));
% end
% Sent

% se = strel('disk',1);
% Idil = imdilate(lets(:,:,2),se);
% B = padarray(Idil,[5 5],0);
% figure
% imshow(B)
% letters = NNreturnLetter(B)