function [im_binarized,pixelWidth,pixelHeight] = getImage(filename)
    info = imfinfo(filename);
    pixelWidth = info.Width;
    pixelHeight = info.Height;
    imraw = imread(filename);
    imgrey = im2gray(imraw);
    im_binarized = sparse(imbinarize(imgrey));
end