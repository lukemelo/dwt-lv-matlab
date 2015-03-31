% -------------------------------------------------------------------------
function [pinch_data] = ...
    dwt_baseline_pinch(data, low_pixel, high_pixel, Legend)
% -------------------------------------------------------------------------
%
% This function is used to pinch the baselines of spectra in data together 
% within a specified pixel range (low_pixel:high_pixel). Baseline pinched
% data is output as pinch_data.
%
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
% high_pixel:   The high end pixel limit for baseline pinching.
% [Integer]
%
% Legend:       A cell type structure containing spectra labels.
% [Cell]
%
% -------------------------------------------------------------------------
%
% Outputs:
%
% pinch_data:   An X-Matrix of baseline pinched data.
%
% -------------------------------------------------------------------------
% Edited: Luke Melo
% June 23rd, 2014
% v1.1
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
    average(i) = sum(i)/length(low_pixel:high_pixel);
end

baseline_min = min(average);
baseline_corr = average - baseline_min;

for i = 1:nsample
    pinch_data(i,:) = data(i,:) - baseline_corr(i);  
end

% figure(1000)
% plot(1:pixels,pinch_data)
% title('Baseline Pinched Acetone/Acetonitrile Raman Spectra')
% ylabel('Relative Peak Intensity')
% xlabel('Pixel')
% legend(Legend)