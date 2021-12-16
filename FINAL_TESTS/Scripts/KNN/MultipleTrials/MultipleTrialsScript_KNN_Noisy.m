
clear all;
close all;
load("Fingerprinting_data_Noisy.mat");
SimulationData = struct();


XMax = 5;
YMax = 5;
GridResolution = 0.1;
x = 0:GridResolution : XMax;
y = 0:GridResolution : YMax;

%X= Index (1) of grid Y= Index(2) of grid
[X,Y] = meshgrid(x,y);

K = 3; % number of nearest neighbours

least_distance_matrix = zeros( 51, 51,'double');
row_values = [];
col_values = [];
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

        SimulationData.(KCount{KNameCounter}).(TagNames{i}).TXPower = TagTransmissionPower(i,:);
        SimulationData.(KCount{KNameCounter}).(TagNames{i}).TrueLocation = TagLocations(i,:);
        SimulationData.(KCount{KNameCounter}).(TagNames{i}).EstimatedLocation = zeros(50,2,'double');   % 50 Here is the total Iteration Count
        SimulationData.(KCount{KNameCounter}).(TagNames{i}).PositionError = zeros(50,1,'double');
        SimulationData.(KCount{KNameCounter}).(TagNames{i}).NeighborCount = KNameCounter+2;
    end
end

%% ====Simulation Params Setup===== %%
model = 'MultipleTrials_KNN_Noisy';
open(model)

FreqCarrier = 9.15e+08;
Gr = 6;
Gt = 1.56;
Zin_r = 50;
Zin_t = 7.056465388996018e-01 + 2.916241413655430e+02i;
lambdaCarrier = physconst('LightSpeed')/FreqCarrier;

set_param('MultipleTrials_KNN_Noisy/Antenna_TX','Gr',num2str(Gt))
set_param('MultipleTrials_KNN_Noisy/Antenna_TX','Zin',num2str(Zin_t))
set_param('MultipleTrials_KNN_Noisy/Antenna_TX','CarrierFreqRad',num2str(FreqCarrier))
set_param('MultipleTrials_KNN_Noisy/PA','Zin',num2str(Zin_r))
set_param('MultipleTrials_KNN_Noisy/Inport','CarrierFreq',num2str(FreqCarrier))

set_param('MultipleTrials_KNN_Noisy/Antenna_RX','Gr',num2str(Gr))
set_param('MultipleTrials_KNN_Noisy/Antenna_RX1','Gr',num2str(Gr))
set_param('MultipleTrials_KNN_Noisy/Antenna_RX2','Gr',num2str(Gr))
set_param('MultipleTrials_KNN_Noisy/Antenna_RX3','Gr',num2str(Gr))
set_param('MultipleTrials_KNN_Noisy/Antenna_RX4','Gr',num2str(Gr))
set_param('MultipleTrials_KNN_Noisy/Antenna_RX','Zin',num2str(Zin_r))
set_param('MultipleTrials_KNN_Noisy/Antenna_RX1','Zin',num2str(Zin_r))
set_param('MultipleTrials_KNN_Noisy/Antenna_RX2','Zin',num2str(Zin_r))
set_param('MultipleTrials_KNN_Noisy/Antenna_RX3','Zin',num2str(Zin_r))
set_param('MultipleTrials_KNN_Noisy/Antenna_RX4','Zin',num2str(Zin_r))
set_param('MultipleTrials_KNN_Noisy/Antenna_RX','CarrierFreqRad',num2str(FreqCarrier))
set_param('MultipleTrials_KNN_Noisy/Antenna_RX1','CarrierFreqRad',num2str(FreqCarrier))
set_param('MultipleTrials_KNN_Noisy/Antenna_RX2','CarrierFreqRad',num2str(FreqCarrier))
set_param('MultipleTrials_KNN_Noisy/Antenna_RX3','CarrierFreqRad',num2str(FreqCarrier))
set_param('MultipleTrials_KNN_Noisy/Antenna_RX4','CarrierFreqRad',num2str(FreqCarrier))
Rtest = 1;
set_param('MultipleTrials_KNN_Noisy/FS_PathLossTest','Gain',num2str(lambdaCarrier/(4*pi*Rtest)))

set_param('MultipleTrials_KNN_Noisy/LNA','Zin',num2str(Zin_r'))
set_param('MultipleTrials_KNN_Noisy/LNA1','Zin',num2str(Zin_r'))
set_param('MultipleTrials_KNN_Noisy/LNA2','Zin',num2str(Zin_r'))
set_param('MultipleTrials_KNN_Noisy/LNA3','Zin',num2str(Zin_r'))
set_param('MultipleTrials_KNN_Noisy/LNA4','Zin',num2str(Zin_r'))


set_param('MultipleTrials_KNN_Noisy/RA1','CarrierFreq',num2str(FreqCarrier))
set_param('MultipleTrials_KNN_Noisy/RA2','CarrierFreq',num2str(FreqCarrier))
set_param('MultipleTrials_KNN_Noisy/RA3','CarrierFreq',num2str(FreqCarrier))
set_param('MultipleTrials_KNN_Noisy/RA4','CarrierFreq',num2str(FreqCarrier))
set_param('MultipleTrials_KNN_Noisy/RA5','CarrierFreq',num2str(FreqCarrier))



for  TagCounter = 1:size(TagLocations,1)
    set_param('MultipleTrials_KNN_Noisy/InputPower', 'Value', num2str(TagTransmissionPower(TagCounter)))
    for Iteration = 1:50
        for K = 3:5
            
            set_param('MultipleTrials_KNN_Noisy/FS_PathLoss1','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(antenna_locs(1,:), TagLocations(TagCounter,:)))));
            set_param('MultipleTrials_KNN_Noisy/FS_PathLoss2','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(antenna_locs(2,:), TagLocations(TagCounter,:)))));
            set_param('MultipleTrials_KNN_Noisy/FS_PathLoss3','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(antenna_locs(3,:), TagLocations(TagCounter,:)))));
            set_param('MultipleTrials_KNN_Noisy/FS_PathLoss4','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(antenna_locs(4,:), TagLocations(TagCounter,:)))));

            SimOutput = sim(model, 'FastRestart', 'off');
            %Obtained Signal Strengths
            RSSI(1)  =mean(SimOutput.RSSI1(1)); %calculated rssi from antenna 1 for the tag
            RSSI(2) = mean(SimOutput.RSSI2(1));
            RSSI(3) = mean(SimOutput.RSSI3(1));
            RSSI(4) = mean(SimOutput.RSSI4(1));
            for i = 1: (XMax/GridResolution) +1
                for j = 1:(YMax/GridResolution) +1
                    val = (Data.Antenna1.RSSI(i, j) - RSSI(1))^2 + (Data.Antenna2.RSSI(i, j) - RSSI(2))^2 + (Data.Antenna3.RSSI(i, j) - RSSI(3))^2 + (Data.Antenna4.RSSI(i, j) - RSSI(4))^2;
                    final = sqrt(val);
                    least_distance_matrix(i, j) = final;
                end
            end
            E = zeros(K,2);
            [R, C] = ndgrid(1:size(least_distance_matrix, 1), 1:size(least_distance_matrix, 2));
            [out, idx] = sort(least_distance_matrix(:));

            positions = [R(idx), C(idx)];   %positions of nearest reference locations
           
            E_total_square = 0;
            for k = 1: K
                E(k,:) = least_distance_matrix(positions(k, :));
            end
            for k = 1: K
                E_total_square = E_total_square + 1/(E(k)^2);
            end
            final_pos = [0, 0];
            for k= 1: K
                final_pos = final_pos + (((1/E(k)^2)/E_total_square) * positions(k, :));
            end
            final_pos = final_pos * GridResolution;
            
            %Appending to SimulationData
            SimulationData.(KCount{K-2}).(TagNames{TagCounter}).EstimatedLocation(Iteration,:)= final_pos;  %K-2 to use as index for name array of tags
            SimulationData.(KCount{K-2}).(TagNames{TagCounter}).PositionError(Iteration,:)= distanceCalc(SimulationData.(KCount{K-2}).(TagNames{TagCounter}).TrueLocation,final_pos);  %K-2 to use as index for name array of tags
        end
    end
end
clearvars -except SimulationData

function [dist2d] = distanceCalc(TruePosition, EstimatedPosition)
dist2d = norm(TruePosition-EstimatedPosition);
end








