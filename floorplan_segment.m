srcFiles = dir('..\sample_images\floorplan_dataset\*.png');  % the folder in which ur images exists
%length(srcFiles)
for i = 1:2
    %%Section 1
    %reading image and converting to binary
    filename = strcat('..\sample_images\floorplan_dataset\',srcFiles(i).name);
    %'..\sample_images\floorplan_dataset\Ib_GY0301_sommaire.png'; 
    %strcat('..\sample_images\floorplan_dataset\',srcFiles(i).name);
    input_image = imread(filename);
    %figure, imshow(input_image);
    gray_image = rgb2gray(input_image);
    level = graythresh(gray_image);
    binary_image = im2bw(gray_image, level);
    str_i = num2str(i);
    extension = strcat(str_i,'.png');
    file_name = strcat('output1/bin_img',extension);
    imwrite(binary_image,file_name);
    %imshow(binary_image);

%% Section 2
%external walls removal
mat = [1 1 1;1 1 1;1 1 1];
dil_img = imdilate(binary_image,mat);
dil_img = imdilate(dil_img,mat);
dil_img = imdilate(dil_img,mat);
dil_img = imdilate(dil_img,mat);
er_img = imerode(dil_img,mat);
er_img = imerode(er_img,mat);
er_img = imerode(er_img,mat);
er_img = imerode(er_img,mat);
er_img = imerode(er_img,mat);
er_img = imerode(er_img,mat);
external_walls = er_img;
file_name = strcat('output/ext_walls',extension);
    %imwrite(binary_image,file_name);
%figure;imshow(external_walls);
external_walls_complement = imcomplement(er_img);
%figure;imshow(external_walls_complement);
without_walls = binary_image + external_walls_complement;
%figure;imshow(without_walls);
comp_without_walls1 = logical(without_walls);
%figure;imshow(comp_without_walls);
comp_without_walls = imcomplement(comp_without_walls1);
%figure;imshow(comp_without_walls);
%% Section 3
% Separating text and remaining graphics
[comp_fin, props] = filterRegions1(comp_without_walls);
%figure;imshow(comp_fin);
final_text = imcomplement(comp_fin);
file_name = strcat('output1/text',extension);
    imwrite(final_text,file_name);
%figure;imshow(final_text);
graphics = without_walls + comp_fin;
wal_dil = imdilate(graphics,mat);
wal_dil = imdilate(wal_dil,mat);
wal_er = imerode(wal_dil,mat);
wal_er = imerode(wal_er,mat);
comp_walls = imcomplement(wal_er);
only_graphics = graphics + comp_walls;
only_walls = graphics + imcomplement(only_graphics);
file_name = strcat('output1/only_walls1',extension);
%    imwrite(only_walls,file_name);
    
    walls = external_walls-imcomplement(only_walls);
    file_name = strcat('output1/walls1',extension);
    imwrite(walls,file_name);


file_name = strcat('output1/graphics',extension);
    imwrite(only_graphics,file_name);
%figure;imshow(graphics);
    
    
end