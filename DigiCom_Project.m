clc;
close all;
% Read the image
image=imread('sunflower.tif');
figure
imshow(image)
% Converting the image to grey scale so that it can be represented with 64
% Symbols(intensities) , where n=6 (number of bits) 
image1=rgb2gray(image); 
image2=zeros(400,600);

for i=1:1:length(image1(:,1))
    for j=1:1:length(image1(1,:))
        temp=double(image1(i,j));
        image2(i,j)=floor(temp/4);
    end
end
%% Intensity analysis
% shows the probability of various intensities
%J=histeq(img2);
%imhist(J)
histogram(image2)
title('Intensity Distribution of Image')
%% Initiating U,V,C and the intensities are mapped to these symbols
%% C - Constellation Vector , U= Row Vector of C (x) , V= Column Vector of C (y)
 U=zeros(1,8);
 C=zeros(8,8);
 V=zeros(1,8);
 % computing the frequency of occurance of each symbols for easy processing
 for i=1:400
    for j=1:600
        temp=image2(i,j);
        U(1,floor(temp/8)+1)=U(1,floor(temp/8)+1)+1;
        V(1,rem(temp,8)+1)=V(1,rem(temp,8)+1)+1;
        C(floor(temp/8)+1,rem(temp,8)+1)= C(floor(temp/8)+1,rem(temp,8)+1)+1;
     end
 end
%% Visualising the distribution the variables follow.
figure
spy(C)
xlabel('x');
ylabel('y');
title('Constellation Vector- Mapping of Input')
figure
stem(U)
xlabel('x')
ylabel('Frequency')
title(' Distribution of x')
figure
stem(V)
xlabel('y')
ylabel('Frequency')
title('Distribution of y')
%% Applying Box-Muller transform
% U and V are transformed into X and Y gaussian symbols
% initialising X and Y
% Generating U , V random variables between (0,1) by in for Loop 
X=zeros(8);
Y=zeros(8);

for i=1:8
    for j=1:8
        temp1=sqrt(-2*log(i/8-0.12))*cos(2*pi*(j/8-0.12));
        temp1=temp1*C(i,j);
        temp2=sqrt(-2*log(i/8-0.12))*sin(2*pi*(j/8-0.12));
        temp2=temp2*C(i,j);
        X(i,j)=temp1;
        Y(i,j)=temp2;
    end
end
%% Analysis of the random variable X and Y after the Box muller transform
figure
histogram(X)
title('Distribution of the random Variable X')
xlabel('X')
ylabel('Frequency')
figure 
histogram(Y)
title('Distribution of the random Variable Y')
xlabel('Y')
ylabel('Frequency')
figure
plot(X,Y)
title('Box-Muller Transform')
xlabel('X')
ylabel('Y')