%THICKNESS MEASUREMENT OF ALPHA PHASE
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
Resolution=1; % micron/pixel % this is the spatial resolution of the input 
Bins=50; % This is the number of bars for histogram chart
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image processing
if ndims(A)==3; A=rgb2gray(A); end
%BW = im2bw(I,level) converts the grayscale image I to binary image BW, by replacing all pixels in the input image with luminance greater than level with the value 1 (white) and replacing all other pixels with the value 0 (black).
%If the input image is not a grayscale image, im2bw converts the input image to grayscale using ind2gray or rgb2gray, and then converts this grayscale image to binary by thresholding.
I1 = adapthisteq(A,'ClipLimit',0.1,'Distribution','Rayleigh');
G  = graythresh(I1);
I1 = im2bw(I1, G*Multiplier); %G*0.65
I1=bwmorph(I1,'diag'); % smooth operation 
I2=bwmorph(I1,'fill'); % smooth operation 
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
imshow(I2,'InitialMagnification',30); hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULATIONS
[s1,s2]=size(I2);
B=~zeros(s1,s2);

n=30;   % Number of Lines to the draw
nvar = randi(4);
LineArraylength=zeros([],1);
L=1;
V=1;
for i1 = 1:n
switch nvar
    case 1
while (0< abs(V))&&(abs(V) <30)|| (60< abs(V))&&(abs(V) <90)        
X1(i1) = 1;
Y1(i1) = randi(s2);
X2(i1) = randi(s1);
Y2(i1) = s2; 
V = atan2(Y2(i1)-Y1(i1), X2(i1)-X1(i1))*180/pi() ;
end

LineArray=zeros(X2(i1),3);
for I=X1(i1):X2(i1)
    J=round(((I-X1(i1))/(X2(i1)-X1(i1)))*(Y2(i1)-Y1(i1))+Y1(i1));
    B(I,J)=0;   
    LineArray (I,1)=I;
    LineArray (I,2)=J;
    LineArray (I,3)=I2(I,J);
end

    case 2
while (0< abs(V))&&(abs(V) <30)|| (60< abs(V))&&(abs(V) <90)   
X1(i1) = randi(s1);
Y1(i1) = s2; 
X2(i1) = s1; 
Y2(i1) = randi(s2); 
V = atan2(Y2(i1)-Y1(i1), X2(i1)-X1(i1))*180/pi() ;
end

LineArray=zeros(X2(i1),3);
for I=X1(i1):X2(i1)
    J=round(((I-X1(i1))/(X2(i1)-X1(i1)))*(Y2(i1)-Y1(i1))+Y1(i1));
    B(I,J)=0;   
    LineArray (I,1)=I;
    LineArray (I,2)=J;
    LineArray (I,3)=I2(I,J);
end
          
    case 3
while (0< abs(V))&&(abs(V) <30)|| (60< abs(V))&&(abs(V) <90) 
X1(i1) = s1;
Y1(i1) = randi(s2);
X2(i1) = randi(s1);
Y2(i1) = 1;
V = atan2(Y2(i1)-Y1(i1), X1(i1)-X2(i1))*180/pi() ;
end

LineArray=zeros(X2(i1),3);
for I=X2(i1):X1(i1)
    J=round(((I-X1(i1))/(X2(i1)-X1(i1)))*(Y2(i1)-Y1(i1))+Y1(i1));
    B(I,J)=0;   
    LineArray (I,1)=I;
    LineArray (I,2)=J;
    LineArray (I,3)=I2(I,J);
end

    otherwise
while (0< abs(V))&&(abs(V) <30)|| (60< abs(V))&&(abs(V) <90)    
X1(i1) = randi(s1);
Y1(i1) = 1;
X2(i1) = 1;
Y2(i1) = randi(s2);   
V = atan2(Y2(i1)-Y1(i1), X1(i1)-X2(i1))*180/pi() ;
end

LineArray=zeros(X2(i1),3);
for I=X2(i1):X1(i1)
    J=round(((I-X1(i1))/(X2(i1)-X1(i1)))*(Y2(i1)-Y1(i1))+Y1(i1));
    B(I,J)=0;   
    LineArray (I,1)=I;
    LineArray (I,2)=J;
    LineArray (I,3)=I2(I,J);
end

end
V=1;
% Drawing Line on the Picture
[L1,~]=size(LineArray);
openLine=0; 
a=0;
LineArray1=zeros(L1,5);
for I=1:L1
            if LineArray (I,3)==0 
               openLine=0;
            end
                 if LineArray (I,3)==1 &&  openLine==0   %
                    LineArray1(a+1,1)=LineArray (I,1);LineArray1(a+1,2)=LineArray (I,2);
                    a=a+1;
                 end
                    if    LineArray (I,3)==1 
                          openLine=1;
                          LineArray1(a,3)=LineArray (I,1);LineArray1(a,4)=LineArray (I,2);
                          LineArray1(a,5)=sqrt((LineArray1(a,3)-LineArray1(a,1))^2+(LineArray1(a,4)-LineArray1(a,2))^2);
                    end
end  
% Display the LINE of the Alpha Phase.
[L1,L2]=size(LineArray1);
Lengthsort=2;  % Mod
for I=1:L1
        if LineArray1(I,5)> Lengthsort            
        plot([LineArray1(I,2) LineArray1(I,4)], [LineArray1(I,1) LineArray1(I,3)],'b');
        LineArraylength(L,1)=Resolution.*LineArray1(I,5); % CALCULATIONS segment length (Alpha Phase)
        L=L+1;
        end 
end
nvar1=nvar;
while nvar == nvar1 
nvar = randi(4);
end

end

%Outputs

Average_segment_length_micron=mean(LineArraylength); %Average grain radius micron
Standard_deviation_of_segment_length_micron=std(LineArraylength); %Standard deviation

subplot(1,2,2)
Rel_Frequencies=hist(LineArraylength,[1:round(max(LineArraylength)/Bins):round(max(LineArraylength))])./sum(sum(hist(LineArraylength,[1:round(max(LineArraylength)/Bins):round(max(LineArraylength))]))); 
bar([1:round(max(LineArraylength)/Bins):round(max(LineArraylength))],Rel_Frequencies); %draw histograms of a normal distribution of a random variable
xlabel('Equivalent segment length (micron)'); ylabel('Relative Frequency'); axis([1 max(LineArraylength) 0 max(Rel_Frequencies)]); axis square;
annotation('textbox',[.2 .85 .1 .1], 'String', [ 'Average length segment = ' num2str(Average_segment_length_micron) ' micron'])

imwrite(I2,'OutputI2.png') 
