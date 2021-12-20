clc;
close all;

load("MTS_KNN_Noisy_Results.mat");


XMax = 5;
YMax = 5;
GridResolution = 0.1;
x = 0:GridResolution : XMax;
y = 0:GridResolution : YMax;

antenna_locs = [[0,0]; [0,YMax]; [XMax,YMax]; [XMax,0]];
TagNames =  {'Tag1', 'Tag2', 'Tag3', 'Tag4'};
KCount =  {'K_3', 'K_4', 'K_5'};
TagLocations =      [2.2, 3.1;
                     4.0,3.0;
                     1.5,4.0;
                     2.8,3.0;];   %Location of the tags(Different Transmission Power???)
TagTransmissionPower = [-20;
                        -30;
                        -35;
                        -40]; %Location of the tags(Different Transmission Power???)

SimulationData.Antennas.Position= antenna_locs;
for KNameCounter = 1:3
    for i = 1:size(TagNames,2)
        fprintf(KCount{KNameCounter});
        fprintf(TagNames{i});
        fprintf("  mean position = ");
        mean(SimulationData.(KCount{KNameCounter}).(TagNames{i}).PositionError)
        fprintf('\n');
%         SimulationData.(KCount{KNameCounter}).(TagNames{i}).TrueLocation = TagLocations(i,:);
%         SimulationData.(KCount{KNameCounter}).(TagNames{i}).EstimatedLocation = zeros(50,2,'double');   % 50 Here is the total Iteration Count
%         SimulationData.(KCount{KNameCounter}).(TagNames{i}).PositionError = zeros(50,1,'double');
%         SimulationData.(KCount{KNameCounter}).(TagNames{i}).NeighborCount = KNameCounter+2;
    end
end

SimulationData.K_3