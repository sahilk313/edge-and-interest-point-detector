myCannyEdgeDetector take 2 input the image matrix and the threshold 
eg. myCannyEdgeDetector(img,[0.04,0.08]);
it calls two subfunctions, nonMaximalSupression and myHysteresis which perform their required steps.

myCompareOutput.m takes 2 input the image matrix and the threshold
eg. myCompareOutput(img,[0.04,0.08]);
it calls the inbuilt and my fucntions for calculationg edges and these edges are compared.
returns the eucledian distance and PSNR value of the two images.
also gives the colored difference map and the blockwise summary matrix.

myDetectInterest takes 2 input the image matrix and the threshold
eg. myDetectInterest(img,[0.04,0.08]);
the threshold is for canny edge detector, the threshold for R is decided from within the function and the output is displayed.

cv.zip contains the latex files