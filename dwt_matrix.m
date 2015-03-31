% -------------------------------------------------------------------------
function [wt_components]=dwt_matrix(data,wfilter,scale)
% -------------------------------------------------------------------------
%
% The function is used to divide the raw spectrum into different wavelet 
% frequency components with the same length of raw spetrum.
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
% June 19th, 2014
% v2.0
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% Find the size of the data input

[wa,wb]=size(data);

% -------------------------------------------------------------------------
% Apply the DWT to data with wfilter wavelet and scale decomposition

[wx,WL]=wavedec(data(1,:),scale,wfilter);

% -------------------------------------------------------------------------
% Cumulative indexing for approximation/detail vector book-keeping

for i=1:(scale+1)
    windex(i)=sum(WL(1:i));
end

% -------------------------------------------------------------------------
% Divide the raw spectrum into different wavelet frequency components with 
% the same length of raw spetrum.

for i=1:wa
    [wx]=wavedec(data(i,:),scale,wfilter);
    
    for j=1:scale+1
         nwx=wx*0;
         if j==1
             nwx(1:windex(1))=wx(1:windex(1));
             wcomponents(j,:)=waverec(nwx,WL, wfilter);
         else
             nwx(windex(j-1)+1:windex(j))=wx(windex(j-1)+1:windex(j));
             wcomponents(j,:)=waverec(nwx,WL, wfilter);
         end
    end
         wt_components{i}=wcomponents;
         wcomponents=[];         
end