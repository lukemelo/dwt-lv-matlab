% -------------------------------------------------------------------------
function [C S]=dwt_2D_decomp(data,wfilter,scale)
% -------------------------------------------------------------------------
%
% Multilevel 2D wavelet decomposition is applied data.
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
% -------------------------------------------------------------------------
%
% Outputs:
%
% wt_components: the wavelet components with the same length of raw spectrum.
% [Cell]         The  data set was storaged in the cell structure data, each 
%                cell represents one sample.
%              - The sequence of wt_components is [A(N), D(N), ..., D(1)]
%
% -------------------------------------------------------------------------
% Da Chen, Dec. 16, 2006
% Modified version Feb. 20, 2009
% -------------------------------------------------------------------------
% Edited: Luke Melo
% July 22nd, 2014
% v1.0
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% Find the size of the data input

[wa,wb]=size(data);

[C,S] = wavedec2(data, scale, wfilter);