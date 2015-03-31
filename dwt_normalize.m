% -------------------------------------------------------------------------
function [norm_data] = dwt_normalize(data, local)
% -------------------------------------------------------------------------
%
% This function is used to normalize "data". The input "local" determines 
% whether to use the maximum value in the entire dataset (false) or to use 
% local maxima and normalize each spectra in 'data' individually (true).
%
% -------------------------------------------------------------------------
%
% Inputs:
%
% data:         An X-Matrix (row vectors) of raw signal input.
% [X-Matrix]
%
% local:        True or False. Determines whether to use the maximum value
% [Boolean]     in the entire dataset (false) or to use local maxima and
%               normalize each spectra in 'data' individually (true).
%
% -------------------------------------------------------------------------
%
% Outputs:
%
% norm_data:    An X-Matrix (row vectors) of normalized signal output.
% [X-Matrix]
%
% -------------------------------------------------------------------------
% Edited: Luke Melo
% June 20th, 2014
% v1.0
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% Find the number of samples and pixels in data
[nsample pixels] = size(data);
tot_data = nsample*pixels;

% -------------------------------------------------------------------------
% Normalize the data input

if not(local)
    norm=0;
    for i = 1:tot_data
        if data(i)>norm
            norm = data(i);
        end
    end
    norm_data = data/norm;
else
    for i = 1:nsample
        norm=0;
        for j = 1:pixels
            if data(i,j)>norm
                norm = data(i,j);
            end
        norm_data(i,:) =  data(i,:)/norm;               
        end
        norm=0;
    end   
end