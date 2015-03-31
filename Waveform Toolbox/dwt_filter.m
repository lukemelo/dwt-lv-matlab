% -------------------------------------------------------------------------
function [A_components D_components filt_data] = ...
    dwt_filter(data, wfilter, scale, hfreq_cut, lfreq_cut, bg_remove)
% -------------------------------------------------------------------------
%
% This function is used to filter each signal in "data" by means of Discrete
% Wavelet Transform (DWT). Detail and approximation components can be
% filtered to remove high frequency noise and low frequency background.
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
% hfreq_cut:    Number of high frequency detail components to be filtered.
% [Integer]
%
% lfreq_cut:    Number of low frequency detail components to be filtered.
% [Integer]
%
% bg_remove:    True or False. Filter nth approximation component from signal. 
% [Boolean]
%
% -------------------------------------------------------------------------
%
% Outputs:
%
% A_components: A cell structure of X-Matrix approximation components. An
% [Cell]        example is A_components{i} = [A(scale); A(scale-1);...; A(1)].
%
% D_components: A cell structure of X-Matrix detail components. An
% [Cell]        example is D_components{i} = [D(scale); D(scale-1);...; D(1)].
%
% filt_data:    An X-Matrix (row vectors) of filtered signal. 
% [X-Matrix]
%
% -------------------------------------------------------------------------
% Edited: Luke Melo
% June 18th, 2014
% v1.0
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% Apply the DWT to data with wfilter wavelet and scale decomposition

[wt_components]=dwt_matrix(data,wfilter,scale);

% -------------------------------------------------------------------------
% Determines the number of samples to be processed for filtering. Also
% determines size of the wt_components given by the "dwt_matrix" function

nsamples = length(wt_components);
[a b] = size(wt_components{1});

% -------------------------------------------------------------------------
% This loop generates the approximation and detail components from data for
% each sample

for i = 1:nsamples
    dwt_component = wt_components{i};
    
    for ii = 1:scale
        D(ii,:) = dwt_component(ii+1,:);
    end
    D_components{i} = D;
    
    A(1,:) = dwt_component(1,:);
    for ii = 2:scale
        A(ii,:) = A(ii-1,:) + D(ii-1,:);
    end
    A_components{i} = A;
end

% -------------------------------------------------------------------------
% This section of code can filter out hfreq_cut # of high frequency detail
% component vectors, lfreq_cut # of low frequency detail component vectors,
% and the nth approximation component vector for background removal.
% Spectra is zeroed at local minimum.


scale_hfreq = 1 + hfreq_cut;
scale_lfreq = scale - lfreq_cut;
scale_range = [scale_hfreq scale_lfreq];

for i = 1:nsamples
    sample = wt_components{i};
    
    if bg_remove
        sample(1,:) = zeros(1,length(sample(1,:)));
    end
    
    for j = 1:scale
        if j < scale_range(1)
            sample(a+1-j,:) = zeros(1,length(sample(a+1-j,:)));
        end
        if j > scale_range(2)
            sample(a+1-j,:) = zeros(1,length(sample(a+1-j,:)));
        end
    end
    
    filtered_recon = zeros(1,b);
    
    for ii =1:a
        for jj = 1:b
            filtered_recon(jj) = filtered_recon(jj) + sample(ii,jj);
        end
    end
    
    filtered_recon = filtered_recon - min(filtered_recon);
    
    filt_data(i,:) = filtered_recon;    
end

% -------------------------------------------------------------------------