clear all
load acetone_import_workspace.mat
% -------------------------------------------------------------------------
% Edited: Luke Melo
% June 23rd, 2014
% v1.1
% UBC
% -------------------------------------------------------------------------


% -------------------------------------------------------------------------
% Import the data from the acetone workspace, or from whichever file your 
% data resides. 

peaks(:,1) = x1000x25acetone(:,2);
peaks(:,2) = x800x25acetone(:,2);
peaks(:,3) = x500x25acetone(:,2);
peaks(:,4) = x200x25acetone(:,2);
peaks(:,5) = x00x25acetone(:,2);

% -------------------------------------------------------------------------
% Label each spectrum
Legend{1} = '100% Acetone';
Legend{2} = '80% Acetone';
Legend{3} = '50% Acetone';
Legend{4} = '20% Acetone';
Legend{5} = '0% Acetone';

% -------------------------------------------------------------------------
% Set up waveform processing parameters

data = peaks';
wfilter = 'sym5'    % Basis Wavelet (generally 'sym5' and 'db10' work well)
scale = 8           % DWT decomposition level
hfreq_cut = 1       % # of high frequency detail coefficients to remove
lfreq_cut = 0       % # of high frequency detail coefficients to remove

iterations = 20


local = false       % treat spectra individually (true) or in bulk (false)


% -------------------------------------------------------------------------
% Find the size of the data
[nsample pixels] = size(data);

% -------------------------------------------------------------------------
% Plot the raw Data
figure(1)
plot(1:pixels,data)
title('Raw/Unprocessed/Unfiltered Spectra')
ylabel('Peak Intensity')
xlabel('Pixel')
legend(Legend)

% -------------------------------------------------------------------------
% Decompose signal and filter out specified details and approximations

[filt_data] = ...
    dwt_filter(data, wfilter, scale, hfreq_cut, lfreq_cut);

% -------------------------------------------------------------------------
% Plot the DWT components (comment out if unnecessary)

% dwt_component_plot(A_components, D_components, Legend)

% -------------------------------------------------------------------------
% Apply a Savitzky-Golay Smoothing algorithm to the spectra

[bg_data bg_corr_data] = dwt_bg_remove(filt_data, scale, wfilter, iterations)%, Legend);

[smoothed_data] = dwt_smooth(bg_corr_data,3,9);

% -------------------------------------------------------------------------
% Pinch the baslines together, then zero and normalize the data. 

[baseline_pinch_data] = ...
    dwt_baseline_pinch(smoothed_data, 1, pixels, Legend);
[zero_data] = dwt_zero(baseline_pinch_data, local);
[norm_data] = dwt_normalize(zero_data, local);

% -------------------------------------------------------------------------
% Plot the filtered Data

figure(3)
plot(1:pixels,norm_data)
title('Processed/Filtered/Normalized Spectra')
ylabel('Relative Peak Intensity')
xlabel('Pixel')
legend(Legend)

% -------------------------------------------------------------------------
% Find Isobestic Ranges/Points in the spectra

% [iso_array] = dwt_isobestic(norm_data,40,Legend);

% -------------------------------------------------------------------------
% find the first and second derivatives of each spectra and plots them

%[first_y first_x second_y second_x] = dwt_derivatives(norm_data, Legend);










