% input image
file = '..\sample_images\floorplan\plan.jpg';
img = imread(file);

gimg = img;
level = graythresh(gimg);
    %binary_image = gray_image;
    bimg = im2bw(gimg, 0.812);
img=bimg;
figure, imshow(img);
%%
% define template (choose the below range as per the texture interested)
%template = img(225:236, 161:167);
%template = img(76:81, 397:408);
%template = img(72:81, 397:408);
%template = img(58:68, 290:295);
%%
%separate bricks
template = imread('..\sample_images\floorplan\t12.jpg');
template = rgb2gray(template);
%%
% perform normalized cross correlation
img_correlated = normxcorr2(template, img);

% find peak in cross correlation 
[ypeak, xpeak] = find(img_correlated == max(img_correlated(:)));
    
% color neighboring regions
ylow = ypeak - size(template, 1)/2;
yhigh = ypeak + size(template, 1)/2;
xlow = xpeak - size(template, 2)/2;
xhigh = xpeak + size(template, 2)/2;

% construct a binary image with the matched region being white
img_out1 = zeros(size(img));
for i = 1: size(xpeak, 1)
   img_out1(ylow(i):yhigh(i), xlow(i):xhigh(i)) = 1;
end


%%
template = imread('templates_example\brick_temp2.png');

% perform normalized cross correlation
img_correlated = normxcorr2(template, img);

% find peak in cross correlation 
[ypeak, xpeak] = find(img_correlated == max(img_correlated(:)));
    
% color neighboring regions
ylow = ypeak - size(template, 1)/2;
yhigh = ypeak + size(template, 1)/2;
xlow = xpeak - size(template, 2)/2;
xhigh = xpeak + size(template, 2)/2;

% construct a binary image with the matched region being white
img_out2 = zeros(size(img));
for i = 1: size(xpeak, 1)
   img_out2(ylow(i):yhigh(i), xlow(i):xhigh(i)) = 1;
end


%%

template = imread('templates_example\brick_temp3.png');

% perform normalized cross correlation
img_correlated = normxcorr2(template, img);

% find peak in cross correlation 
[ypeak, xpeak] = find(img_correlated == max(img_correlated(:)));
    
% color neighboring regions
ylow = ypeak - size(template, 1)/2;
yhigh = ypeak + size(template, 1)/2;
xlow = xpeak - size(template, 2)/2;
xhigh = xpeak + size(template, 2)/2;

% construct a binary image with the matched region being white
img_out3 = zeros(size(img));
for i = 1: size(xpeak, 1)
   img_out3(ylow(i):yhigh(i), xlow(i):xhigh(i)) = 1;
end
%%
img_out = img_out1 + img_out2 + img_out3;
%% display results
figure,imshow(img_out1);

%%
%separate concrete


template = imread('templates_example\conc_temp1.png');
%figure,imshow(template);
% perform normalized cross correlation
img_correlated = normxcorr2(template, img);

% find peak in cross correlation 
[ypeak, xpeak] = find(img_correlated == max(img_correlated(:)));
    
% color neighboring regions
ylow = ypeak - size(template, 1)/2;
yhigh = ypeak + size(template, 1)/2;
xlow = xpeak - size(template, 2)/2;
xhigh = xpeak + size(template, 2)/2;

% construct a binary image with the matched region being white
conc_img_out1 = zeros(size(img));
for i = 1: size(xpeak, 1)
   conc_img_out1(ylow(i):yhigh(i), xlow(i):xhigh(i)) = 1;
end
%%

%figure,imshow(conc_img_out1);
%%
template = imread('templates_example\conc_temp3.png');
%figure,imshow(template);
% perform normalized cross correlation
img_correlated = normxcorr2(template, img);

% find peak in cross correlation 
[ypeak, xpeak] = find(img_correlated == max(img_correlated(:)));
    
% color neighboring regions
ylow = ypeak - size(template, 1)/2;
yhigh = ypeak + size(template, 1)/2;
xlow = xpeak - size(template, 2)/2;
xhigh = xpeak + size(template, 2)/2;

% construct a binary image with the matched region being white
conc_img_out2 = zeros(size(img));
for i = 1: size(xpeak, 1)
   conc_img_out2(ylow(i):yhigh(i), xlow(i):xhigh(i)) = 1;
end

%conc_img_out = conc_img_out1 + conc_img_out2;
%figure,imshow(conc_img_out2);
%%
template = imread('templates_example\conc_temp4.png');
%figure,imshow(template);
% perform normalized cross correlation
img_correlated = normxcorr2(template, img);

% find peak in cross correlation 
[ypeak, xpeak] = find(img_correlated == max(img_correlated(:)));
    
% color neighboring regions
ylow = ypeak - size(template, 1)/2;
yhigh = ypeak + size(template, 1)/2;
xlow = xpeak - size(template, 2)/2;
xhigh = xpeak + size(template, 2)/2;

% construct a binary image with the matched region being white
conc_img_out4 = zeros(size(img));
for i = 1: size(xpeak, 1)
   conc_img_out4(ylow(i):yhigh(i), xlow(i):xhigh(i)) = 1;
end

conc_img_out = conc_img_out1 + conc_img_out2 + conc_img_out4;
%figure,imshow(conc_img_out2);
figure,imshow(conc_img_out);


%%
%separate stone

template = imread('templates_example\stone_temp1.png');
%figure,imshow(template);
% perform normalized cross correlation
img_correlated = normxcorr2(template, img);

% find peak in cross correlation 
[ypeak, xpeak] = find(img_correlated == max(img_correlated(:)));
    
% color neighboring regions
ylow = ypeak - size(template, 1)/2;
yhigh = ypeak + size(template, 1)/2;
xlow = xpeak - size(template, 2)/2;
xhigh = xpeak + size(template, 2)/2;

% construct a binary image with the matched region being white
stone_img_out1 = zeros(size(img));
for i = 1: size(xpeak, 1)
   stone_img_out1(ylow(i):yhigh(i), xlow(i):xhigh(i)) = 1;
end

template = imread('templates_example\stone_temp2.png');
%figure,imshow(template);
% perform normalized cross correlation
img_correlated = normxcorr2(template, img);

% find peak in cross correlation 
[ypeak, xpeak] = find(img_correlated == max(img_correlated(:)));
    
% color neighboring regions
ylow = ypeak - size(template, 1)/2;
yhigh = ypeak + size(template, 1)/2;
xlow = xpeak - size(template, 2)/2;
xhigh = xpeak + size(template, 2)/2;

% construct a binary image with the matched region being white
stone_img_out2 = zeros(size(img));
for i = 1: size(xpeak, 1)
   stone_img_out2(ylow(i):yhigh(i), xlow(i):xhigh(i)) = 1;
end

stone_img_out = stone_img_out1 + stone_img_out2;
%figure,imshow(conc_img_out2);
figure,imshow(stone_img_out);
