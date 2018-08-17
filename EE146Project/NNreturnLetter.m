function [letterNum] = NNreturnLetter(img)
% uses NN function to classify img as a letter.  First the image is resized
% to 28x28, then flattened to 784x1.  The NN function takes only flattened
% images, and needs to be changed to double.  Then returns a number 
% of 1-26 for A-Z.


temp1 = imresize(img, [28 28]);
temp1 = 255*temp1;

temp2 = reshape(temp1,[784, 1]);

val = myNNfun(double(temp2));

[maximum, in] = max(val);

letterNum = in;


% Im = rgb2gray(Im);
% I = imresize(Im,[28 28]);
% Im = reshape(I,[784, 1]);
% y1 = myNNfun(double(Im));


end

