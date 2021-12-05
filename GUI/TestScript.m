clear all
close all
FLOORPLAN = imread('FLOORPLAN.jpg')
ax1 = axes('Position',[0.1 0.1 0.7 0.7]);

image(ax1, FLOORPLAN)
ax1.Color = 'None';
ax1.XColor = 'None';
ax1.YColor = 'None';

ax2 = axes('Position',[0.1 0.1 0.7 0.7]);
hold(ax2,'on')
p1 = scatter(ax2, 30,40, 'filled')
p1.MarkerFaceColor = 'Yellow';
ax2.Color = 'None';
ax2.XColor = 'None';
ax2.YColor = 'None';


StateBufferSz = 10;
Table = table('Size',[StateBufferSz 8],'VariableTypes',{'string','datetime','double', 'double', 'double', 'double', 'double', 'double'}, ...
                             'VariableNames', {'TagID', 'TimeStamp', 'X','Y','Z','CovXX', 'CovYY', 'CovZZ'});

FinalTable = Table(strcmp(Table.Tag ID(:), 'Tag1'))

