% -------------------------------------------------------------------------
function [bg_data bg_corr_data] = ...
    dwt_bg_remove(data, scale, wfilter, iterations, Legend)
% -------------------------------------------------------------------------
%
% This function is used to iteratively find the background of spectra via 
% wavelet transform. The spectra is decomposed at scale decomposition
% level. If the function has a value greater than the approximation 
% coeffecient, the spectra is set equal to the approximation coeffecient.
% This process is iterated until a desired baseline is acquired. 
%
% -------------------------------------------------------------------------
%
% Inputs:
%
% data:         An X-Matrix (row vectors) of raw signal input.
% [X-Matrix]
%
% wfilter:      Wavelet chosen as basis function (ex. 'db1' 'db10' 'sym5').
% [String]
%
% scale:        The level of decomposition used in the DWT.
% [Integer]
%
% Legend:       A cell type structure containing spectra labels.
% [Cell]
%
% iterations:   Number of background correcton iterations
% [Integer]
%
% -------------------------------------------------------------------------
%
% Outputs:
%
% bg_corr_data: An X-Matrix of background corrected data.
% [X-Matrix]
%
% bg_data:      An X-Matrix of background spectra.
% [X-Matrix]
%
% -------------------------------------------------------------------------
% Edited: Luke Melo
% July 18th, 2014
% v1.2
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% Find the size of the data
[nsample npixels] = size(data);

% -------------------------------------------------------------------------

[A_components D_components filt_data approx_data] = ...
    dwt_filter_noise(data, wfilter, scale, 0);
[ceiling_data] = dwt_fn_ceiling(data, approx_data);

index = 2;

while index < iterations
    
    [A_components D_components filt_data approx_data] = ...
    dwt_filter_noise(ceiling_data, wfilter, scale, 0);
    

    [ceiling_data] = dwt_fn_ceiling(ceiling_data, approx_data);
    
    figure(10000)
    plot(1:npixels,ceiling_data)
    title(strcat('Background Spectra Iteration #',num2str(index)))
    ylabel('Peak Intensity')
    xlabel('Pixel')
    legend(Legend)
    
    figure(10001)
    plot(1:npixels,ceiling_data(1,:),1:npixels,data(1,:))
    title('BG Fit on First Spectrum')
    ylabel('Peak Intensity')
    xlabel('Pixel')
    legend(Legend{1},strcat('Background Iteration #',num2str(index)))
    
    
    index = index + 1;
end

bg_data = ceiling_data;
bg_corr_data = data - bg_data;

% figure(1337)
% plot(1:npixels,bg_corr_data)
% title('BG Corrected Spectra')
% ylabel('Peak Intensity')
% xlabel('Pixel')
% legend(Legend)








