% -------------------------------------------------------------------------
function [iso_array] = dwt_isobestic(data, rsd_thresh, Legend)
% -------------------------------------------------------------------------
%
% This function is used to locate points in data that show isobestic
% behavior. If the data at a given pixel has less than 'rsd_thresh'
% relative standard deviation, then this point is considered isobestic.
% Plotting iso_array on the same plot as your data (as long as the data is
% organized) will clearly display isobestic ranges. 
%
% -------------------------------------------------------------------------
%
% Inputs:
%
% data:         An X-Matrix (row vectors) of raw signal input. Data must
% [X-Matrix]    have at least 2 spectra (rows).
%
% rsd_thresh:   An integer number representing the threshold percentage
% [Integer]     in determining if the data at a certain pixel is constant.
%
% Legend:       A cell type structure containing spectra labels.
% [Cell]
%
% -------------------------------------------------------------------------
%
% Outputs:
%
% iso_array:    A row vector with same length as the spectrum data
% [Row Vector]  (#pixels). iso_array takes values of 1 for isobestic points
%               lying within the rsd_thresh limit, and 0 for those points
%               that do not.
% 
% -------------------------------------------------------------------------
%
% Effects:
% 
% This function will plot data with isobestic labeling.
%
% -------------------------------------------------------------------------
% Edited: Luke Melo
% June 23rd, 2014
% v1.0
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% Find the size of the data
[nsample pixels] = size(data);

% -------------------------------------------------------------------------
% Find the isobestic points in data.
for i = 1:pixels
    stdev_pixel = std(data(:,i));
    avg_pixel = mean(data(:,i));
    rsd = 100*stdev_pixel/avg_pixel;
    if rsd > rsd_thresh
        iso_array(i) = 1;    
    else
        iso_array(i) = 0;
    end    
end

% -------------------------------------------------------------------------
% Plot the isobestic points on a plot with data
colormap = ['b' 'g' 'r' 'c' 'w' 'y' 'k']

figure(150)
plot(1:pixels,data,1:pixels,iso_array)
title('Isobestic Labeling for Spectra')
ylabel('Relative Peak Intensity')
xlabel('Pixel')
legend(Legend)