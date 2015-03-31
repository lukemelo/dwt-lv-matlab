% -------------------------------------------------------------------------
function [zero_data] = dwt_zero(data, local)
% -------------------------------------------------------------------------
%
% This function is used to zero "data". The input "local" determines 
% whether to use the minimum value in the entire dataset (false) or to use 
% local minima and zero each spectra in 'data' individually.
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
%               normalize each spectra in 'data' individually.
%
% -------------------------------------------------------------------------
%
% Outputs:
%
% zero_data:    An X-Matrix (row vectors) of zeroed signal input.
% [X-Matrix]
%
% -------------------------------------------------------------------------
% Edited: Luke Melo
% June 19th, 2014
% v1.0
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% Find the number of samples and pixels in data
[nsample pixels] = size(data);
tot_data = nsample*pixels;

% -------------------------------------------------------------------------
% Zero the data input

if not(local)
    base=min(min(data));
    for i = 1:tot_data
        if data(i)<base
            base = data(i);
        end
    end
    zero_data = data - base;
else
    for i = 1:nsample
        base=min(min(data));
        for j = 1:pixels
            if data(i,j)<base
                base = data(i,j);
            end
        zero_data(i,:) =  data(i,:) - base;               
        end
        base=min(min(data));
    end   
end