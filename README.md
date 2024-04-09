# Utilizing Image software
The SEM-acquired grayscale images underwent a conversion process to binary images through a
thresholding technique. Through this method, gray shades present in both α and β phases were eliminated
to enhance the differentiation between the characteristics. In the resultant thresholded binary images,
the β phase was depicted in white, while the α phase was indicated in black. This approach lays the
foundation for quantifying the microstructural attributes using stereological methods Figure 1.

## 1. Thickness Measurement of Alpha Phase (Using stereological procedure):
To measure the thickness of α laths, a set of random lines is drawn on the image; any portions of lines
that are on the β phase keep erased, leaving a set of line segments (of length λ) which were only on
the α phase see Figure 1.
 
![Fig1](https://github.com/Povarnitsyn/Utilizing-Image-software-Image-Processing-MATLAB-/assets/50267432/34d9a5e3-aad0-40a6-9c67-bce0a375a7e7)

Fig. 1 Processing of scanning electron microscopic images: (A) Grayscale images obtained by scanning
electron microscopy; (B) Binary processing; (C) Particle boundary treatment.

## 2. Grain size measurement: 
The average grain intercept (AGI) method is a technique used to quantify the grain - or crystal - 
size for a given material by drawing a set of randomly positioned line segments on the micrograph,
counting the number of times each line segment intersects a grain boundary, and finding the ratio of
intercepts to line length. Thus, the AGI is calculated as AGI = ( number of incercepts)/(line length)
A set of random lines is drawn on the low magnification optical image; all the intersections of those
lines with the colony boundaries are marked see Figure 2.

![Fig2](https://github.com/Povarnitsyn/Utilizing-Image-software-Image-Processing-MATLAB-/assets/50267432/cd0700d4-2856-4b74-8c3a-ca665c688eca)

Fig. 2 Grain size measurement example

## 3. Volume Fraction: 
In conventional stereological methods, the measurement of any volume fraction is carried out using number
fractions. A uniform grid of points is superimposed onto the image, and points that land on the feature of
interest are annotated. The volume fraction of that specific feature is determined by the number fraction
of those points that coincide with the said feature Figure 3.

![Fig3](https://github.com/Povarnitsyn/Utilizing-Image-software-Image-Processing-MATLAB-/assets/50267432/89029271-b7d1-41fa-81d4-76c1831d6d16)

Fig. 3 Stereological process for quantifying the volume fraction of the α phase. 
A grid of points is positioned on the image, and the white circles indicate where the grid intersects the β phase.
(A) Grayscale images obtained by scanning electron microscopy; (B) Binary processing.
