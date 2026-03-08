function make_nice_figures(fig_, ax_, fontSize_, axTitle_, ...
    xLabel_, yLabel_, figTitle_, figPosition_, exportAs_, xLim_, yLim_)
%% Apply consistent figure formatting for paper-quality plots
% This utility function standardizes figure appearance and optional export
% settings for the plots used throughout the paper. It applies the desired
% font, interpreters, axis labels, axis limits, figure placement, and file
% export settings.
%
% Inputs:
%   fig_         - figure handle
%   ax_          - axes handle
%   fontSize_    - axis font size
%   axTitle_     - axes title text
%   xLabel_      - x-axis label text
%   yLabel_      - y-axis label text
%   figTitle_    - figure window title
%   figPosition_ - normalized figure position vector
%   exportAs_    - output filename for export
%   xLim_        - x-axis limits
%   yLim_        - y-axis limits

    fig_.Units = 'normalized';

    if numel(figTitle_)
        fig_.Name = figTitle_;
    end

    if numel(figPosition_)
        fig_.Position = figPosition_;
    else
        fig_.Position = [0.1 0.1 0.5*[1 1]];
    end

    ax_.FontSize = fontSize_;
    ax_.FontName = 'Times New Roman';
    ax_.TickLabelInterpreter = 'latex';

    if numel(axTitle_)
        ax_.Title.String = axTitle_;
        ax_.Title.Interpreter = 'latex';
    end

    if numel(xLabel_)
        ax_.XLabel.String = xLabel_;
        ax_.XLabel.Interpreter = 'latex';
    end

    if numel(yLabel_)
        ax_.YLabel.String = yLabel_;
        ax_.YLabel.Interpreter = 'latex';
    end

    if numel(xLim_)
        ax_.XLim = xLim_;
    end

    if numel(yLim_)
        ax_.YLim = yLim_;
    end

    if numel(exportAs_)
        exportgraphics(fig_, exportAs_, 'Resolution', 150);
    end
end