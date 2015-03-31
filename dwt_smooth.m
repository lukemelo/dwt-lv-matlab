% -------------------------------------------------------------------------
function [smoothed_data] = dwt_smooth(data,k,f)
% -------------------------------------------------------------------------
%
% This function applies a Savitzky-Golay FIR smoothing filter to data (row
% vectors). The polynomial order k must be less than the frame size, f,
% which must be odd. If k = f-1, the filter produces no smoothing.
%
% -------------------------------------------------------------------------
%
% Inputs:
%
% data:         An X-Matrix (row vectors) of raw signal input.
% [X-Matrix]
%
% k:            The polynomial order.
% [Odd Integers]
%
% f:            Frame size.
% [Odd Int. > k+1]
% -------------------------------------------------------------------------
%
% Outputs:
%
% smoothed_data:    A row vector with same length as the spectrum data
% [Row Vector]  (#pixels). iso_array takes values of 1 for isobestic points
%               lying within the rsd_thresh limit, and 0 for those points
%               that do not.
%
% -------------------------------------------------------------------------
% Edited: Luke Melo
% June 23rd, 2014
% v1.1
% -------------------------------------------------------------------------


smooth_data = data';
smoothing_data = sgolayfilt(smooth_data,k,f);
smoothed_data = smoothing_data';
