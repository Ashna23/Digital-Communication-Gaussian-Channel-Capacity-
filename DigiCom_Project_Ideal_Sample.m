clc;
close all;
% Ideal Sample Input
sample=zeros(64,64);
%% Initializing 64 symbol equiprobable values
for i=1:64
    sample(i,:)=i-1;
end

img=zeros(64);
%converting to double
for i=1:1:length(sample(:,1))
    for j=1:1:length(sample(1,:))
        temp=double(sample(i,j));
        img(i,j)=floor(temp);
    end
end

%% image analysis
% shows the probability of various intensities
histogram(img)
title('Ideal Intensity Distribution of Image')
%% initiating U,V,C and the intensities are mapped to these symbols
 U=zeros(1,8);
 C=zeros(8,8);
 V=zeros(1,8);
 % computing the frequency of occurance of each symbols for easy processing
 for i=1:64
    for j=1:64
        temp=img(i,j);
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
title('Ideal Mapping of Input')
figure
stem(U)
xlabel('x')
ylabel('Frequency')
title('Ideal Uniform distribution of x')
figure
stem(V)
xlabel('y')
ylabel('Frequency')
title('Ideal Uniform distribution of y')
%% Applying Box-Muller transform
% U and V are transformed into X and Y symbols
% initialising X and Y


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
%% analysis of the random variable U and V after the Box muller transform
figure
histogram(X)
title('Ideal Distribution of the random Variable X')
xlabel('X')
ylabel('Frequency')
figure 
histogram(Y)
title('Ideal Distribution of the random Variable Y')
xlabel('Y')
ylabel('Frequency')

figure
plot(X,Y)
title('Box-Muller Transform')
xlabel('X')
ylabel('Y')