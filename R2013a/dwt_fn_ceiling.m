% -------------------------------------------------------------------------
function [ceiling_data] = dwt_fn_ceiling(data, approx_data)
% -------------------------------------------------------------------------
%
% This function modifies data such that all points in data which lie above 
% the approximation spectrum are set equal to the approximation spectrum 
% itself. 
%
% -------------------------------------------------------------------------
%
% Inputs:
%
% data:         An X-Matrix (row vectors) of signal input.
% [X-Matrix]
%
% approx_data:  An X-Matrix (row vectors) of approximation coefficients.
% [X-Matrix]
%
% -------------------------------------------------------------------------
%
% Outputs:
%
% ceiling_data: An X-Matrix of background corrected data.
% [X-Matrix]
%
% -------------------------------------------------------------------------
% Edited: Luke Melo
% June 24th, 2014
% v1.0
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% Find the size of the data
[nsample pixels] = size(data);

% -------------------------------------------------------------------------

for ii = 1:nsample
    
    sample = data(ii,:);
    approx_sample = approx_data(ii,:);
    
    for jj = 1:pixels
        
        if sample(jj) > approx_sample(jj)
            ceiling_data(ii,jj) = approx_sample(jj);
        else
            ceiling_data(ii,jj) = sample(jj);
        end  
    end     
end


