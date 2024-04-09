% GRAIN SIZE MEASUREMENT
% Grain size distribution from 2D binary image of rocks using watershed
% segmentation algorithm
% You will need image processing license to run this code
clc;clear; close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUTS
%It is necessary to register the name of the picture with the extension ('grain size.jpg'). 
%The image and macro file must be in the same folder, or then you need to
%write the full path.
A=imread('grain size.jpg');
%This is a multiplier that adjusts the properties of the image. 
%a multiplier of morphological Operations on Binary Image.
Multiplier=3; % smooth operation multiplier
% micron/pixel % this is the spatial resolution of the input 
Resolution=3; 
% This is the number of bars for histogram chart
Bins=20; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULATIONS
if ndims(A)==3; A=rgb2gray(A); end
%BW = im2bw(I,level) converts the grayscale image I to binary image BW, by replacing all pixels in the input image with luminance greater than level with the value 1 (white) and replacing all other pixels with the value 0 (black).
%If the input image is not a grayscale image, im2bw converts the input image to grayscale using ind2gray or rgb2gray, and then converts this grayscale image to binary by thresholding.
A=im2bw(A,graythresh(A));
Conn=8;
[s1,s2]=size(A);
%Morphological Operations on Binary Image
%BW2 = bwmorph(BW,operation,n) applies the operation n times. n can be Inf, in which case the operation is repeated until the image no longer changes.
%'majority' - Sets a pixel to 1 if five or more pixels in its 3-by-3 neighborhood are 1s; otherwise, it sets the pixel to 0.
A=~bwmorph(A,'majority',Multiplier); % smooth operation and reverse negative
Poro=sum(sum(~A))/(s1*s2);
%bwdist Distance transform of binary image
%In 2-D, the cityblock distance between (x1,y1) and (x2,y2) is
% x1 – x2 + ?y1 – y2?
D=-bwdist(A,'cityblock'); % distance between (x1,y1) and (x2,y2)
%J = medfilt2(I,[m n]) performs median filtering, where each output pixel contains the median value in the m-by-n neighborhood around the corresponding pixel in the input image.
 B=medfilt2(D,[3 3]);  %median filtering
%-------------------------
B=watershed(B,Conn);
%zeros - Create array of all zeros
Pr=zeros(s1,s2);
%zeros - Create array of all zeros
for I=1:s1
    for J=1:s2
        if A(I,J)==0 && B(I,J)~=0 %Combine the two pictures A and B, result is poro with boundaries
            Pr(I,J)=1;
        end
    end
end
%bwareaopen-Remove small objects from binary image
Pr=bwareaopen(Pr,9,Conn);
%bwlabel - Label connected components in 2-D binary image
[Pr_L,Pr_n]=bwlabel(Pr,Conn);
%zeros - Create array of all zeros
V=zeros(Pr_n,1);
for I=1:s1
    for J=1:s2
        if Pr_L(I,J)~=0
            V(Pr_L(I,J))=V(Pr_L(I,J))+1; %count quantity of unique label, it is volume of pixels in one poro
        end
    end
end
R=Resolution.*(V./pi).^.5; % grain radius
 
%OUTPUTS
Average_grain_radius_micron=mean(R) %Average grain radius micron
Standard_deviation_of_grain_radius_micron=std(R) %Standard deviation
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
RGB=label2rgb(Pr_L,'jet', 'w', 'shuffle'); %picture with highlighted pore numbers
imshow(RGB)
imwrite(RGB,'Output.png')

subplot(1,2,2)
Rel_Frequencies=hist(R,[1:round(max(R)/Bins):round(max(R))])./sum(sum(hist(R,[1:round(max(R)/Bins):round(max(R))]))); 
bar([1:round(max(R)/Bins):round(max(R))],Rel_Frequencies); %draw histograms of a normal distribution of a random variable
xlabel('Equivalent Grain Radius (micron)'); ylabel('Relative Frequency'); axis([1 max(R) 0 max(Rel_Frequencies)]); axis square;
annotation('textbox',[.2 .85 .1 .1], 'String', [ 'Average grain radius = ' num2str(Average_grain_radius_micron) ' micron'])