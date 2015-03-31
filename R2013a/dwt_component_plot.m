% -------------------------------------------------------------------------
function dwt_component_plot(A_components, D_components, Legend)
% -------------------------------------------------------------------------
%
% The function is used to plot both the approximation and detail vectors
% wih respect to the decomposition level (scale).
%
% -------------------------------------------------------------------------
%
% Inputs:
%
% A_components: A cell structure of X-Matrix approximation components. An
% [Cell]        example is A_components{i} = [A(scale); A(scale-1);...; A(1)].
%
% D_components: A cell structure of X-Matrix detail components. An
% [Cell]        example is D_components{i} = [D(scale); D(scale-1);...; D(1)].
%
% Legend:       A cell type structure containing spectra labels.
% [Cell]
%
% -------------------------------------------------------------------------
% Edited: Luke Melo
% June 23rd, 2014
% v1.1
% -------------------------------------------------------------------------

A = A_components{1};
D = D_components{1};
[nsample pixels] = size(A);
pixels = 1:pixels;

% -------------------------------------------------------------------------
% Plot both the approximation and detail vectors wih respect to the 
% decomposition level (scale).

for i = 1:length(A_components)
    figure(9000+i)
    legend(Legend{i})
    for ii = 1:nsample
        subplot(2,nsample,ii)
        plot(A(nsample+1-ii,:))
        title(strcat('A',num2str(ii)))
        axis([min(pixels),max(pixels),min(A(nsample+1-ii,:)),max(A(nsample+1-ii,:))])
        
        subplot(2,nsample,nsample+ii)
        plot(D(nsample+1-ii,:))
        title(strcat('D',num2str(ii)))
        axis([min(pixels),max(pixels),min(D(nsample+1-ii,:)),max(D(nsample+1-ii,:))])
    end
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0
        1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off'); 
    text(0.5, 1,strcat('\bf ',Legend{i}),'HorizontalAlignment'...
        ,'center','VerticalAlignment', 'top');
end