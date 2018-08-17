clear;
clc;
close all;

% load workspace
% load('NeuralNetworkWorkspace.mat')

%read in image and change to grayscale
colorImage = imread('MultipleLines.jpg');
I = rgb2gray(colorImage);
% resize image, make it binary, then complement the image.
%  The background needs to be black and letters need to be
% white.
I = imresize(I, [750 600]);
I2 = imbinarize(I);
BW = imcomplement(I2);

% use open to get rid of small unwanted objects
% Then dilate so make sure letters are connected
BW2 = bwareaopen(BW,7);
se = strel('disk',1);
BW2 = imdilate(BW2,se);
figure, imshow(BW2)

horizontalProfile = sum(BW2, 1);

% Get the horizontal profile to segment line
% if there is mulitple lines.  If just one line,
% crops image closer to the line
bw3 = BW2;
h1 = sum(bw3,2);
% figure
% plot(sum(bw3,2),1:size(bw3,1));

% finds the peaks of the horizontal profile
% to separate the lines.
[pks1,locs1] = findpeaks(h1,'MinPeakDistance',80);
meanCycle1 = mean(diff(locs1))
if(isnan(meanCycle1))
    
    delta1 = 60;
else
    delta1 = ceil((meanCycle1-15)/2);
end

% For loop to segment lines
for i = 1:length(pks1)
    
    BWline(:,:,i) = BW2((locs1(i)-delta1-5):(locs1(i)+delta1+5),:);
%     figure
%     imshow(BWline(:,:,i))
%     imshow(BW2((locs1(i)-delta1):(locs1(i)+delta1),:))


end

for j = 1:length(BWline(1,1,:))
    % Find connected components of line j
    cc(j) = bwconncomp(BW2((locs1(j)-delta1):(locs1(j)+delta1),:));
    stats{j} = regionprops(cc(j),'All');
    % Put bounding boxes around the letters
    % in line j
    Boxes = cat(1, stats{j}.BoundingBox);
    bwArea = cat(1,stats{j}.Area);
    Ibox = insertShape(double(BWline(:,:,j)),'Rectangle',Boxes);

%     figure
%     imshow(Ibox,[])

    % get rid of small objects that are not connected
    % to letters
    idx = find([stats{j}.Area] > 30); 
    bw = ismember(labelmatrix(cc(j)), idx); 
    bw = padarray(bw,[10 10],0);

%     figure
%     imshow(bw)

    % find connected components a second time
    % with after getting rid of smaller objects
    cc2(j) = bwconncomp(bw);
    stats2{j} = regionprops(cc2(j),'BoundingBox');

    Bx{:,:,j} = cat(1,stats2{j}.BoundingBox);
    Ib(:,:,:,j) = insertShape(double(bw),'Rectangle',Bx{j});

    % Plot line j with bounding boxes
    figure
    imshow(Ib(:,:,:,j),[])
    
    % Prepare letters in line j to classify, then classify using 
    % Neural Networks function NNreturnLetter.
    for i = 1:length(Bx{j})

        lets(:,:,i,j) = imresize((bw((Bx{j}(i,2)-2):(Bx{j}(i,2)+Bx{j}(i,4)+2),(Bx{j}(i,1)-2):(Bx{j}(i,1)+Bx{j}(i,3)+2))),[28 28]);
        se = strel('disk',1);
        Idil(:,:,i,j) = imdilate(lets(:,:,i,j),se);
        B(:,:,i,j) = padarray(Idil(:,:,i,j),[5 5],0);
        letters{j}(i) = NNreturnLetter(B(:,:,i,j));
        
        % uncomment to plot the individual letters
        % that were used in the NN function
%         figure
%         imshow(lets(:,:,i,j))

    end
    
    % find where the spaces are in each line
    dif{j}(1) = 0;
    for i = 2:length(Bx{j})
   
%     dif = Bx(j-1,1)+Bx(j-1,3) - Bx(j,1);
        dif{j}(i-1) = Bx{j}(i,1) - Bx{j}(i-1,1) - Bx{j}(i-1,3);
    
        if abs(dif{j}(i-1)) > 15
            space{j}(i-1) = 27;
        else
            space{j}(i-1) = 33;
        end
    
    end
    
    space{j}(length(Bx{j})) = 33;
    
    % add spaces to lines, then output sentence 
    % to command prompt.
    D{j} = [letters{j}; space{j}];
    D{j} = D{j}(:)';
    Sent{j} = ReturnLetter3(D{j})
 
end






