% -------------------------------------------------------------------------
function [baseline_corr_data] = ...
    dwt_baseline_pinch(data, low_pixel, high_pixel)
% -------------------------------------------------------------------------
%
% This function is used to pinch the baselines of spectra in data together 
% within a specified pixel range (low_pixel:high_pixel). Baseline  
% -------------------------------------------------------------------------
%
% Inputs:
%
% data:         An X-Matrix (row vectors) of raw signal input. Data must
% [X-Matrix]    have at least 2 spectra (rows).
%
% low_pixel:    The low end pixel limit for baseline pinching.
% [Integer]
%
% high_pixel:    The high end pixel limit for baseline pinching.
% [Integer]
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
% June 20th, 2014
% v1.0
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% Find the size of the data
[nsample pixels] = size(data);

% ------------------------------------------
% Baseline centering
% ------------------------------------------

for i = 1:nsample
    sample_interest = data(i,:);
    sum(i) = 0;
    for j = low_pixel:high_pixel
        sum(i) = sum(i) + sample_interest(1,j);
    end
    average(i) = sum(i)/length(low_pixel:high_pixel)
end

baseline_min = min(average)

baseline_corr = average - baseline_min

for i = 1:nsample
    baseline_corr_data(i,:) = data(i,:) - baseline_corr(i)  ;  
end

figure(8374)
plot(1:pixels,baseline_corr_data)