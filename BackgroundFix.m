%引导图像
[image,map] = imread('古诗四首.jpg');
translate = makecform('srgb2lab'); 
imageLab = applycform(image,translate);
L = image(:,:,1);

%----------------------提取印章--------------------
% %印章的输入图像
S = imread('03.png');
S = 255-S;
figure;
subplot(2,2,1);
imshow(S);
title('KNN_seals');
S(S>130)=255;
subplot(2,2,2);
imshow(S);
%imwrite(S,'sealsTemplate.png','png');
title('sealsTemplate');

[m,n] = size(L);
sealsImage = image;
for i=1:m
    for j=1:n
        if S(i,j) == 255
            sealsImage(i,j,:) = 255;
        end
    end
end
%imwrite(sealsImage,'seals.png','png')
subplot(2,2,3);
imshow(image);
title('origin');
subplot(2,2,4);
imshow(sealsImage);
title('sealsImage');

%----------------------提取书法字----------------------
%书法字的输入图像
C = imread('01.png');
C = 255-C;
figure;
subplot(2,3,1);
imshow(C);
title('KNN_char');
C(C>180)=255;
subplot(2,3,2);
imshow(C);
%imwrite(C,'charTemplate.png','png');
title('charTemplate');
%滤波
I=double(L)/255;
p =double(C)/255; 
i=8;
r=2;
eps = 10^-i;
q2 = guidedfilter(I, p, r, eps);
q2(q2>=1)=1;
q2(q2<=0)=0;
%imwrite(q2,strcat('i=',num2str(i),'r=',num2str(r),'.jpg'),'jpg');
subplot(2,3,3);
imshow(image);
title('origin');
subplot(2,3,4);
imshow(q2);
%imwrite(q2,'char_filter.png','png')
title('the filter output')

[m,n] = size(L);
charImage = image;
for i=1:m
    for j=1:n
        if q2(i,j) > 0.8
            charImage(i,j,:) = 255;
        end
    end
end
%imwrite(charImage,'char.png','png')
subplot(2,3,5);
imshow(charImage);
title('charImage');

%--------------------图像融合--------------------
bgImage = imread('bgImage.jpg');
fusionImage = bgImage;
count = 0;
for i=1:m
    for j=1:n
        if sealsImage(i,j,1) < 255
            fusionImage(i,j,1) = sealsImage(i,j,1);
            fusionImage(i,j,2) = sealsImage(i,j,2);
            fusionImage(i,j,3) = sealsImage(i,j,3);
        else
            if charImage(i,j,1) < 255
                fusionImage(i,j,1) = charImage(i,j,1);
                fusionImage(i,j,2) = charImage(i,j,2);
                fusionImage(i,j,3) = charImage(i,j,3);
            end
        end
    end
end
imwrite(fusionImage,'fusionImage.png','png')
figure;
imshow(fusionImage);
title('fusionImage');