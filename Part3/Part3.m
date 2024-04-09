% VOLUME FRACTION
clc;clear; close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUTS
%It is necessary to register the name of the picture with the extension ('Image 1.jpg'). 
%The image and macro file must be in the same folder, or then you need to
%write the full path.
A=imread('Image 1.jpg');
%This is a multiplier that adjusts the properties of the image. 
%a multiplier of morphological Operations on Binary Image.
Multiplier=0.7; % smooth operation multiplier (from 0 to 1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULATIONS
if ndims(A)==3; A=rgb2gray(A); end
%BW = im2bw(I,level) converts the grayscale image I to binary image BW, by replacing all pixels in the input image with luminance greater than level with the value 1 (white) and replacing all other pixels with the value 0 (black).
%If the input image is not a grayscale image, im2bw converts the input image to grayscale using ind2gray or rgb2gray, and then converts this grayscale image to binary by thresholding.
I1 = adapthisteq(A,'ClipLimit',0.1,'Distribution','Rayleigh');
G  = graythresh(I1);
I1 = im2bw(I1, G*Multiplier);
I1=bwmorph(I1,'diag'); % smooth operation 
I1=bwmorph(I1,'fill'); % smooth operation 
%To draw the grid of points
[s1,s2]=size(I1);
B=~zeros(s1,s2);
N=50; %grid spacing, pixels
Ni = round(s1/N);
         if Ni*N+1 > s1 
             Ni=Ni-1;
         end
Nj = round(s2/N);
         if Nj*N+1 > s2 
             Nj=Nj-1;
         end
for I=0:Ni
     for J=0:Nj
             B(I*N+1,J*N+1)=0;
             
     end
end
Nsum=(Ni+1)*(Nj+1); %sum points
NAlphasum=0; %sum Alpha points
%Find points that fall onto the feature of interest
B1=~zeros(s1,s2);
B2=~zeros(s1,s2);
for I=1:s1
    for J=1:s2
        if B(I,J)~=1 
            Densum=0;
           for Ii=0:2
               for Ji=0:2 
                   a=I-1+Ii;
                   b=J-1+Ji;
                   if a==0 
                       a=1; 
                   end
                   if b==0 
                       b=1; 
                   end
                   Densum=I1(a,b)+Densum;
                   B2(a,b)=0;
               end
           end
            if Densum >3  
                  B1(I,J)=0;
                  NAlphasum=NAlphasum+1;  
            end
            
        end
    end
end
%The volume fraction
VolumefractionAlfa=NAlphasum/Nsum;
imshow(I1,'InitialMagnification',30); hold on

% %VolumeFraction Alpha Display
% % Display the circles of the Alpha Phase.
radii=2;
for I=1:s1
    for J=1:s2
        if B1(I,J)==0 % && B(I,J)~=1 
            X = I;
            Y = J;
            centers = [Y X];
            viscircles(centers,radii,'Color','b');  hold on          
        end
    end
end

% %%VolumeFraction Beta Display
% %% Display the circles of the Beta Phase.
% radii=2;
% for I=1:s1
%     for J=1:s2
%         if B1(I,J)==1  && B(I,J)~=1 
%             X = I;
%             Y = J;
%             centers = [Y X];
%             viscircles(centers,radii,'Color','r');  
%         end
%     end
% end
% VolumefractionBeta=1-VolumefractionAlfa; 