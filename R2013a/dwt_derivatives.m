% -------------------------------------------------------------------------
function [first_y first_x second_y second_x] = dwt_derivatives(data, Legend)
% -------------------------------------------------------------------------
%
% This function is used to numerically calculate the first and second
% derivatves of data (spectra are row vectors). These results are then
% plotted for each sample in data. 
%
% -------------------------------------------------------------------------
%
% Inputs:
%
% data:         An X-Matrix (row vectors) of raw signal input. Data must
% [X-Matrix]    have at least 2 spectra (rows).
%
% Legend:       A cell type structure containing spectra labels.
% [Cell]
%
% -------------------------------------------------------------------------
%
% Outputs:
%
% first_y:      An X-Matrix of first derivative intensities.
% [X-Matrix]
%
% first_x:      An X-Matrix of first derivative intensity locations.
% [X-Matrix]
%
% second_y:     An X-Matrix of second derivative intensities.
% [X-Matrix]
%
% second_x:     An X-Matrix of second derivative intensity locations.
% [X-Matrix]
%
% -------------------------------------------------------------------------
%
% Effects:
%
% This function will plot the signal input, first, and second derivatives
% for each sample.
%
% -------------------------------------------------------------------------
% Edited: Luke Melo
% June 23rd, 2014
% v1.1
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% Find the size of the data
peaks = data';
size_peaks_array = size(peaks);
pixels = 1:size_peaks_array(1);

% ------------------------------------------
% Take the first and second derivatives

for i = 1:size_peaks_array(2)
    % ------------------------------------------
    % Derivative 1
    
    d__pixels = diff(pixels);
    d__Int = diff(peaks(:,i));
    
   
    for j = 1:length(d__pixels)
        dpixels__plot(j) = (pixels(j+1) + pixels(j))/2;
    end
    for j = 1:size(d__Int)
        dI__dpixels(j) = d__Int(j)/d__pixels(j);
    end
    
    first_y(i,:) = dI__dpixels';
    first_x(i,:) = dpixels__plot';
    % ------------------------------------------
    % Derivative 2
    
    d2__pixels = diff(dpixels__plot);
    d2__Intensity = diff(dI__dpixels);
    
    for j = 1:length(d2__pixels)
        d2pixels__plot(j) = (dpixels__plot(j+1) + dpixels__plot(j))/2;
    end
    for j = 1:length(d2__Intensity)
        d2I__dpixels2(j) = d2__Intensity(j)/d2__pixels(j);
    end
    
    second_y(i,:) = d2I__dpixels2';
    second_x(i,:) = d2pixels__plot';
    % ------------------------------------------
    % Plotting
    
    plot_index = 100+i;
    figure(plot_index)
    
    subplot(3,1,1)
    plot(pixels,peaks(:,i))
    title(strcat('Derivative Inspection:',Legend{i}))
    ylabel(strcat('Intensity'))
    xlabel('Pixel')
    legend('I(p)')
    grid
    
    subplot(3,1,2)
    plot(dpixels__plot,dI__dpixels)
    ylabel(strcat('dI/dP'))
    xlabel('Pixel')
    legend('I`(p)')
    grid
    
    subplot(3,1,3)
    plot(d2pixels__plot,d2I__dpixels2)
    ylabel(strcat('d2I/dP2'))
    xlabel('Pixel')
    legend('I"(p)')
    grid
end

% ------------------------------------------