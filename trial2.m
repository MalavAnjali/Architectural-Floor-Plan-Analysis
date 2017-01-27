    filename = 'test_segment.png'; 
    %strcat('..\sample_images\floorplan_dataset\',srcFiles(i).name);
    %'..\sample_images\floorplan_dataset\Ib_GY0301_sommaire.png'; 
    %strcat('..\sample_images\floorplan_dataset\',srcFiles(i).name);
    input_image = imread(filename);
    %figure, imshow(input_image);
    %%
    %gray_image = rgb2gray(input_image);
    gray_image = input_image;
    level = graythresh(gray_image);
    %binary_image = gray_image;
    binary_image = im2bw(gray_image, 0.812);
    comp_bin = imcomplement(binary_image);
    figure, imshow(binary_image);
    %%
    [comp_fin, props] = filterRegions2(comp_bin);
%figure;imshow(comp_fin);
final_text = imcomplement(comp_fin);
%figure,imshow(final_text);

without_text = binary_image + imcomplement(final_text);
%figure,imshow(without_text);

%%
mat = [1 1 1;1 1 1;1 1 1];


%%
er_img = imerode(without_text,mat);
%%
er_img = imerode(er_img,mat);
%%
er_img = imerode(er_img,mat);
%er_img = imerode(er_img,mat);
%%
external_walls = er_img;
%%
%figure,imshow(er_img);
%%
dil_img = imdilate(er_img,mat);
%%
dil_img = imdilate(dil_img,mat);
dil_img = imdilate(dil_img,mat);
dil_img = imdilate(dil_img,mat);
dil_img = imdilate(dil_img,mat);
dil_img = imdilate(dil_img,mat);
dil_img = imdilate(dil_img,mat);
%%
%dil_img = imdilate(dil_img,mat);
%dil_img = imdilate(dil_img,mat);

%figure,imshow(dil_img);
%%
%dil_img = imerode(dil_img,mat);
%%
%dil_img = imdilate(dil_img,mat);
%%
%figure,imshow(dil_img);

%%

er_img = imerode(dil_img,mat);
%%
er_img = imerode(er_img,mat);
er_img = imerode(er_img,mat);
er_img = imerode(er_img,mat);
er_img = imerode(er_img,mat);
%%
external_walls = er_img;
%figure,imshow(external_walls);
%%
remaining = without_text + imcomplement(external_walls);
%figure,imshow(remaining);

%%

only_walls1 = without_text + without_text + imcomplement(remaining);
%figure, imshow(only_walls);
%%
check = imerode(only_walls1,mat);
%figure, imshow(check);
comp1 = logical(check);
comp = imcomplement(comp1);
[comp_fin, props] = filterRegions_walls(comp);
only_walls = imcomplement(comp_fin);
only_walls = imdilate(only_walls,mat);
left_only_walls = only_walls1 + imcomplement(only_walls);
%figure,imshow(left_only_walls);
%%

d1 = imdilate(only_walls,mat);
%%
d1 = imdilate(d1,mat);
d1 = imdilate(d1,mat);
d1 = imdilate(d1,mat);
%%
e1 =  imerode(d1,mat);
e1 =  imerode(e1,mat);
e1 =  imerode(e1,mat);
e1 =  imerode(e1,mat);
%%
%figure, imshow(e1);
%figure, imshow(d1);
solid_walls = e1;
%%
hollow_walls = only_walls  +only_walls+ imcomplement(e1);
%figure,imshow(hollow_walls);

%%

%%

%template_matching
template = imread('..\sample_images\floorplan\t12.jpg');
%%
%template = rgb2gray(template);

% perform normalized cross correlation
img_correlated = normxcorr2(template, hollow_walls);

% find peak in cross correlation 
[ypeak, xpeak] = find(img_correlated == max(img_correlated(:)));
    
% color neighboring regions
ylow = ypeak - size(template, 1)/2;
yhigh = ypeak + size(template, 1)/2;
xlow = xpeak - size(template, 2)/2;
xhigh = xpeak + size(template, 2)/2;

% construct a binary image with the matched region being white
img_out1 = zeros(size(hollow_walls));
for i = 1: size(xpeak, 1)
   img_out1(ylow(i):yhigh(i), xlow(i):xhigh(i)) = 1;
end
texture1 = imcomplement(img_out1);

texture1 = imerode(texture1,mat);
%figure,imshow(texture1);
%%
matm = [0 1 0; 0 1 0;0 1 0];
texture1 = imerode(texture1, matm);
texture1 = imerode(texture1, matm);
texture1 = imerode(texture1, matm);
texture1 = imerode(texture1, matm);
texture1 = imerode(texture1, matm);
texture1 = imerode(texture1, matm);
texture1 = imerode(texture1, matm);
%texture1 = imerode(texture1, matm);
%texture1 = imerode(texture1, matm);
texture1 = imerode(texture1, mat);
texture1 = imerode(texture1, mat);
%figure,imshow(texture1);
lines = texture1;
%%
rem_hollow = hollow_walls + imcomplement(texture1);
%figure,imshow(rem_hollow);
hollow_walls = rem_hollow;

%%
mat1 = [0 0 1; 0 1 0; 1 1 1; 0 1 0; 1 0 0];
mat2 = [0 0 0 0 0;1 1 1 1 1;0 0 0 0 0];
e2 = imerode(hollow_walls,mat1);
e21 = imerode(hollow_walls,mat2);
%%

%e2 = imerode(e2,mat);
%%
%figure,imshow(e2);

%%
d2 = imdilate(e2,mat);
d2 = imdilate(d2,mat);

d21 = imdilate(e21,mat);
d21 = imdilate(d21,mat);
d21 = imdilate(d21,mat);
d21 = imdilate(d21,mat);
d21 = imdilate(d21,mat);
d21 = imdilate(d21,mat);
d21 = imdilate(d21,mat);
%%
d2 = imdilate(d2,mat);

%%
%d2 = imerode(d2,mat);
%%
d2 = imdilate(d2,mat);
d2 = imdilate(d2,mat);
d2 = imdilate(d2,mat);
d2 = imdilate(d2,mat);
%d2 = imdilate(d2,mat);

%%
%figure,imshow(d21);

%%

e3 = imerode(d2,mat);
e3 = imerode(e3,mat);
e3 = imerode(e3,mat);
e3 = imerode(e3,mat);
e3 = imerode(e3,mat);

e31 = imerode(d21,mat);
e31 = imerode(e31,mat);
e31 = imerode(e31,mat);
e31 = imerode(e31,mat);
e31 = imerode(e31,mat);
%%

windodws1 = e3;
windows2 = e31;

e3g = im2uint8(e3);
e31g = im2uint8(e31);
win_gray = bitand(e3g, e31g);
wind = im2bw(win_gray);
%figure,imshow(wind);
%%

rem = hollow_walls +  imcomplement(wind);
%%

%figure,imshow(rem);

%%
mat4 = [ 0 1 0;0 1 0; 0 1 0];
e4 = imerode(rem,mat);
e4 = imerode(e4,mat);
e4 = imerode(e4,mat);
%figure,imshow(e4);

%%
d4 = imdilate(e4,mat);
d4 = imdilate(d4,mat);
d4 = imdilate(d4,mat);
d4 = imdilate(d4,mat);
d4 = imdilate(d4,mat);
d4 = imdilate(d4,mat);
d4 = imdilate(d4,mat);
d4 = imdilate(d4,mat);
d4 = imdilate(d4,mat);
%figure,imshow(d4);
%%
e4 = imerode(d4,mat);
e4 = imerode(e4,mat);
e4 = imerode(e4,mat);
e4 = imerode(e4,mat);
e4 = imerode(e4,mat);
e4 = imerode(e4,mat);
e4 = imerode(e4,mat);
%%
%figure,imshow(e4);

%%
remain = rem +rem+ e4;
remain = im2uint8(remain);
remain = im2bw(remain);
remain1 = rem +imcomplement(remain);
left_over = remain1;
%figure,imshow(remain1);
%figure,imshow(imcomplement(remain));

%%
% = imdilate(remain,mat);
e5 = imerode(remain,mat);
%e5 = imerode(e5,mat);
%e5 = imerode(e5,mat);
%e5 = imerode(e5,mat);
%figure,imshow(e5);
%%
e5 = imdilate(e5,mat);
e5 = imdilate(e5,mat);
e5 = imdilate(e5,mat);
e5 = imdilate(e5,mat);
%e5 = imdilate(e5,mat);
%e5 = imdilate(e5,mat);
%e5 = imdilate(e5,mat);
%e5 = imdilate(e5,mat);
%figure,imshow(e5);
%%
e5 = imerode(e5,mat);
e5 = imerode(e5,mat);
e5 = imerode(e5,mat);
e5 = imerode(e5,mat);
e5 = imerode(e5,mat);
e5 = imerode(e5,mat);
e5 = imerode(e5,mat);
e5 = imerode(e5,mat);
%figure,imshow(e5);
e5 = im2uint8(e5);
e5 = im2bw(e5);
hash = e5;
%%

%figure,imshow(remain);

%%
rema = remain + imcomplement(e5);
%figure,imshow(rema);
%%
e6 = imerode(rema,mat);
e6 = imerode(e6,mat);
e6 = imerode(e6,mat);
e6 = imdilate(e6,mat);
e6 = imdilate(e6,mat);
e6 = imdilate(e6,mat);
e6 = imdilate(e6,mat);
e6 = imdilate(e6,mat);
e6 = imdilate(e6,mat);
e6 = imdilate(e6,mat);
e6 = imerode(e6,mat);
e6 = imerode(e6,mat);
e6 = imerode(e6,mat);
e6 = imerode(e6,mat);
e6 = imerode(e6,mat);
dots = e6;
%figure,imshow(e6);


%%
dots = im2uint8(dots);
dots = im2bw(dots);
hash = remain + imcomplement(dots);
hash = imerode(hash, mat);
hash = imerode(hash, mat);
%figure,imshow(hash);

%%
%solid walls
solid_walls = im2uint8(solid_walls);
solid_walls = im2bw(solid_walls);
chnl = 255 * (solid_walls);
chnl1 = 255 * ones(size(solid_walls));
rgb_solid_walls = cat(3,chnl1,chnl,chnl1);
%figure,imshow(rgb_solid_walls);

%%
%dots
dots = im2uint8(dots);
dots = im2bw(dots);
chnl = 255 * (dots);
chnl1 = 255 * ones(size(dots));
rgb_dots = cat(3,chnl1,chnl1,chnl);
%figure,imshow(rgb_dots);

%%
%hash
hash = im2uint8(hash);
hash = im2bw(hash);
chnl = 255 * (hash);
chnl1 = 255 * ones(size(hash));
rgb_hash = cat(3,chnl,chnl1,chnl1);
%figure,imshow(rgb_hash);

%%
%windows
wind = im2uint8(wind);
wind = im2bw(wind);
chnl = 255 * (wind);
chnl1 = 255 * ones(size(wind));
rgb_wind = cat(3,chnl,chnl,chnl1);
%figure,imshow(rgb_wind);

%%
%windows
left_only_walls_fin = im2uint8(left_only_walls);
left_only_walls_fin = im2bw(left_only_walls_fin);
chnl = 255 * (left_only_walls_fin);
chnl1 = 255 * ones(size(left_only_walls_fin));
rgb_left_only_walls = cat(3,chnl,chnl,chnl);
%figure,imshow(rgb_wind);

%%
%lines
lines = im2uint8(lines);
lines = im2bw(lines);
chnl = 255 * (lines);
chnl1 = 255 * ones(size(lines));
rgb_lines = cat(3,chnl,chnl1,chnl);
%figure,imshow(rgb_lines);

%%
%text
final_text = im2uint8(final_text);
final_text = im2bw(final_text);
chnl = 255 * (final_text);
chnl1 = 255 * ones(size(final_text));
rgb_final_text = cat(3,chnl,chnl,chnl);
%figure,imshow(rgb_final_text);

%%
%left over
left_over = im2uint8(left_over);
left_over = im2bw(left_over);
chnl = 255 * (left_over);
chnl1 = 255 * ones(size(left_over));
rgb_left_over = cat(3,chnl,chnl,chnl);
%figure,imshow(rgb_left_over);

%%
%remaining
remaining = im2uint8(remaining);
remaining = im2bw(remaining);
chnl = 255 * (remaining);
chnl1 = 255 * ones(size(remaining));
rgb_remaining = cat(3,chnl,chnl,chnl);
%figure,imshow(rgb_remaining);

%%
temp1 = bitand(rgb_solid_walls, rgb_dots);
temp2 = bitand(temp1, rgb_hash);
temp3 = bitand(temp2, rgb_wind);
temp4 = bitand(temp3, rgb_lines);
temp5 = bitand(temp4, rgb_final_text);
temp6 = bitand(temp5, rgb_left_over);
temp7 = bitand(temp6, rgb_remaining);
temp8 = bitand(temp7, rgb_left_only_walls);
figure, imshow(temp8);