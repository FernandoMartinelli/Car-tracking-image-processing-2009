function im = read_images_make_movie(imdir, ext)

% this function read all images in a given directory
% and make a movie file

% SYNTAX
%       EXAMPLE: read_images_make_movie('frames', 'jpg');
%
% INPUTS: 
% imdir: image sequense directory
% ext: the extension name of the image such as 'jpg', 'tif',
%
% Written by Desire Sidibe, 26-June-2009

filearray = dir([imdir filesep '*.' ext]); % get images in the directory
s = size(filearray,1); % get number of images

mv =struct('cdata',{}, 'colormap', {}); % get gui structure
figure, h =gcf;

frameind=0;
for i=1:s
    frameind = frameind+1;
    imgname = [imdir filesep filearray(i).name];
    im(i,:,:) = imread(imgname) ; % load image 
    
    imshow(im(i));               % show image
    mv(frameind)=getframe(h); % add the figure to movie mv
end

close(h)
framerate = 5;
movie2avi(mv, 'my_movie.avi', 'fps', framerate);
movie(mv);

