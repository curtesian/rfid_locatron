clc;
close all;

load("Noisy_triangulationResults.mat");


XMax = 5;
YMax = 5;
GridResolution = 0.1;
x = 0:GridResolution : XMax;
y = 0:GridResolution : YMax;

antenna_locs = [[0,0]; [0,YMax]; [XMax,YMax]; [XMax,0]];
TagNames =  {'Tag1', 'Tag2', 'Tag3', 'Tag4'};
TagLocations =      [2.2, 3.1;
                     4.0,3.0;
                     1.5,4.0;
                     2.8,3.0;];   %Location of the tags(Different Transmission Power???)
TagTransmissionPower = [-20;
                        -30;
                        -35;
                        -40]; %Location of the tags(Different Transmission Power???)

SimulationData.Antennas.Position= antenna_locs;
    for i = 1:size(TagNames,2)
        for j = 1: 50
            SimulationData.(TagNames{i}).PositionError(j, :) = error2d(SimulationData.(TagNames{i}).TrueLocation, SimulationData.(TagNames{i}).EstimatedLocation(j, :));

        end

    end


    for i = 1:size(TagNames,2)
        fprintf(TagNames{i});
        fprintf("  mean error = ");
        mean(SimulationData.(TagNames{i}).PositionError)
        fprintf('\n');
%         SimulationData.(TagNames{i}).TrueLocation = TagLocations(i,:);
%         SimulationData.(TagNames{i}).EstimatedLocation = zeros(50,2,'double');   % 50 Here is the total Iteration Count
%         SimulationData.(TagNames{i}).PositionError = zeros(50,1,'double');
%         SimulationData.(TagNames{i}).NeighborCount = KNameCounter+2;
    end


function e = error2d(estPos, actualPos)
    e = sqrt((actualPos(1)-estPos(1))^2 + (actualPos(2)-estPos(2))^2);
end

