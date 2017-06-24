image_sequence = read_images_make_movie('car_sequence','jpg');

first_im = imread('car_sequence/00000805.jpg');
imshow(first_im);

%Calculates the median pixel of all images

% Y = SORT(X,DIM,MODE)
sorted_image_sequence = sort(image_sequence, 1, 'ascend');

back_ground = squeeze(sorted_image_sequence(round(size(sorted_image_sequence,1)/2),:,:));

imshow(back_ground);

% car_image = gray2ind(first_im - back_ground,2);
car_image = first_im - back_ground;
threshold = 30;

car_image(car_image < threshold) = 0;
car_image(car_image >= threshold) = 1;

imagesc(car_image)

%Kernel of the dilation
SE = strel('square',4);

filled_car_image = imfill(car_image,'holes');

eroded_car_image = imerode(filled_car_image,SE);

closure_car_image = imdilate(eroded_car_image,SE);

imshow(closure_car_image);

imshow(first_im);

properties = regionprops(closure_car_image, 'boundingbox','centroid');

draw_box(properties.BoundingBox);

centroid = properties.Centroid;

hold on
scatter(centroid(1),centroid(2),'x','b');
scatter(centroid(1),centroid(2),'o','b');
hold off





























