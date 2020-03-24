# Optical-Handwritten-Character-Recognition
This program converts a picture of handwriting to printable text using Matlab's Computer Vision toolbox.

The “emnist-letters.mat” file is the dataset used to train the neural network.

To run the code:
- Make sure the picture of the writing, and the following MATLAB files are in the same folder: MultiLineSegment.m, myNNfun.m, NNreturnLetter.m, ReturnLetter3.m, OneLineSegment.m.
- If the picture has multiple lines, run the MultiLineSegment.m file.
- If the picture only has one line, either MultiLineSegment.m or OneLineSegment.m can be run.
- For both 2 & 3, make sure the name of the picture is in the imread(‘’) portion of the code.
This should be all that is needed to run the files.
