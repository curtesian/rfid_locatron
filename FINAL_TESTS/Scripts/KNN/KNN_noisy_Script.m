
clear all;
close all;
load("Fingerprinting_data.mat");
K = 3; % number of nearest neighbours

XMax = 5;
YMax = 5;
GridResolution = 0.1;

x = 0:GridResolution : XMax;
y = 0:GridResolution : YMax;

%X= Index (1) of grid Y= Index(2) of grid
[X,Y] = meshgrid(x,y);  



%% 
N = 4; %Antenna Reader Count
%Data = import("FingerPrintingData.mat");

antenna_locs = [[0,0]; [0,YMax]; [XMax,YMax]; [XMax,0]];


model = 'KNN_noisy_Results';
open(model)
% Result crunching:
% 
% RSSI_Fingerprints = [Data.Antenna1.RSSI(:),Data.Antenna2.RSSI(:),Data.Antenna3.RSSI(:),Data.Antenna4.RSSI(:)];
% Pos_Fingerprints  = [Data.Antenna1.RSSI(:),Data.Antenna2.RSSI(:),Data.Antenna3.RSSI(:),Data.Antenna4.RSSI(:)];
%% ====Simulation Params Setup===== %%
            FreqCarrier = 9.15e+08;
            Gr = 6; 
            Gt = 1.56; 
            Zin_r = 50; 
            Zin_t = 7.056465388996018e-01 + 2.916241413655430e+02i;
            lambdaCarrier = physconst('LightSpeed')/FreqCarrier;

            set_param('KNN_noisy_Results/Antenna_TX','Gr',num2str(Gt))
            set_param('KNN_noisy_Results/Antenna_TX','Zin',num2str(Zin_t))
            set_param('KNN_noisy_Results/Antenna_TX','CarrierFreqRad',num2str(FreqCarrier))
            set_param('KNN_noisy_Results/PA','Zin',num2str(Zin_r))      
            set_param('KNN_noisy_Results/Inport','CarrierFreq',num2str(FreqCarrier))
            
            set_param('KNN_noisy_Results/Antenna_RX','Gr',num2str(Gr))
            set_param('KNN_noisy_Results/Antenna_RX1','Gr',num2str(Gr))
            set_param('KNN_noisy_Results/Antenna_RX2','Gr',num2str(Gr))
            set_param('KNN_noisy_Results/Antenna_RX3','Gr',num2str(Gr))
            set_param('KNN_noisy_Results/Antenna_RX4','Gr',num2str(Gr))
            set_param('KNN_noisy_Results/Antenna_RX','Zin',num2str(Zin_r))
            set_param('KNN_noisy_Results/Antenna_RX1','Zin',num2str(Zin_r))
            set_param('KNN_noisy_Results/Antenna_RX2','Zin',num2str(Zin_r))
            set_param('KNN_noisy_Results/Antenna_RX3','Zin',num2str(Zin_r))
            set_param('KNN_noisy_Results/Antenna_RX4','Zin',num2str(Zin_r))
            set_param('KNN_noisy_Results/Antenna_RX','CarrierFreqRad',num2str(FreqCarrier))
            set_param('KNN_noisy_Results/Antenna_RX1','CarrierFreqRad',num2str(FreqCarrier))
            set_param('KNN_noisy_Results/Antenna_RX2','CarrierFreqRad',num2str(FreqCarrier))
            set_param('KNN_noisy_Results/Antenna_RX3','CarrierFreqRad',num2str(FreqCarrier))
            set_param('KNN_noisy_Results/Antenna_RX4','CarrierFreqRad',num2str(FreqCarrier))
             Rtest = 1;
            set_param('KNN_noisy_Results/FS_PathLossTest','Gain',num2str(lambdaCarrier/(4*pi*Rtest)))
              
            set_param('KNN_noisy_Results/LNA','Zin',num2str(Zin_r'))
            set_param('KNN_noisy_Results/LNA1','Zin',num2str(Zin_r'))
            set_param('KNN_noisy_Results/LNA2','Zin',num2str(Zin_r'))
            set_param('KNN_noisy_Results/LNA3','Zin',num2str(Zin_r'))
            set_param('KNN_noisy_Results/LNA4','Zin',num2str(Zin_r'))
             
     
           set_param('KNN_noisy_Results/RA1','CarrierFreq',num2str(FreqCarrier))
           set_param('KNN_noisy_Results/RA2','CarrierFreq',num2str(FreqCarrier))
           set_param('KNN_noisy_Results/RA3','CarrierFreq',num2str(FreqCarrier))
           set_param('KNN_noisy_Results/RA4','CarrierFreq',num2str(FreqCarrier))
           set_param('KNN_noisy_Results/RA5','CarrierFreq',num2str(FreqCarrier))

            
      %============SIMULATION CALL==================%
            %Place Tag at location in room
%             R1 = 2.828;
%             R2 = 2.236;
%             R3 = 1.414;
%             R4 = 2.236;
        TagLocations = [2.2, 3.1]; %Location of the tag
        TagLocationsCounter = 1;
           
    

        set_param('KNN_noisy_Results/FS_PathLoss1','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(antenna_locs(1,:), TagLocations(TagLocationsCounter,:)))));
        set_param('KNN_noisy_Results/FS_PathLoss2','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(antenna_locs(2,:), TagLocations(TagLocationsCounter,:)))));
        set_param('KNN_noisy_Results/FS_PathLoss3','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(antenna_locs(3,:), TagLocations(TagLocationsCounter,:)))));
        set_param('KNN_noisy_Results/FS_PathLoss4','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(antenna_locs(4,:), TagLocations(TagLocationsCounter,:)))));


        set_param('KNN_noisy_Results/white_noise', 'seed', num2str(randi([0 100],1,1)))
        SimOutput = sim(model, 'FastRestart', 'off');
        %Obtained Signal Strengths
        RSSI(1)  =mean(SimOutput.RSSI1(1)); %calculated rssi from antenna 1 for the tag
        RSSI(2) = mean(SimOutput.RSSI2(1));
        RSSI(3) = mean(SimOutput.RSSI3(1));
        RSSI(4) = mean(SimOutput.RSSI4(1));
        RSSI %not showing right values
        %RSSI in array for the TAG in question

        
        %% =================KNN====================================%
%         for ReferenceNodeNum = 1:size(RSSI,1)
%             for AntennaNodeNum = 1:4
%              ReferenceError(ReferenceNodeNum, AntennaNodeNum) = (RSSI_Fingerprints(ReferenceNodeNum, AntennaNodeNum) - RSSI(AntennaNodeNum))^2;
%             end
%         end
%         ReferenceError   = sqrt(sum(ReferenceError,2));
%         [out, index]     = sort(ReferenceError);
%         NearestNeighborRSSI = RSSI_Fingerprints(index);
%         NearestNeighborRSSI = NearestNeighborRSSI(1:K);
%         
%         NearestNeighborsCoords = getCoords(index)


least_distance_matrix = zeros( 51, 51); 
row_values = [];
col_values = [];
%val = 0;

for i = 1: 51
    for j = 1:51
      val = (Data.Antenna1.RSSI(i, j) - RSSI(1))^2 + (Data.Antenna2.RSSI(i, j) - RSSI(2))^2 + (Data.Antenna3.RSSI(i, j) - RSSI(3))^2 + (Data.Antenna4.RSSI(i, j) - RSSI(4))^2;
      %val = ((measured_RSSI_matrix(i, j, 1) - AP_rssi(1))^2) + ((measured_RSSI_matrix(i, j, 2) - AP_rssi(2))^2) + ((measured_RSSI_matrix(i, j, 3) - AP_rssi(3))^2 + ((measured_RSSI_matrix(i, j, 4) - AP_rssi(4))^2);
      final = sqrt(val);
      least_distance_matrix(i, j) = final;
    end
end

[R, C] = ndgrid(1:size(least_distance_matrix, 1), 1:size(least_distance_matrix, 2));
[out, idx] = sort(least_distance_matrix(:));

positions = [R(idx), C(idx)];   %positions of nearest reference locations
E = zeros(K,1);
E_total_square = 0;
for k = 1: K
    E(k) = least_distance_matrix(positions(k, 1), positions(k, 2));
end
for k = 1: K
    E_total_square = E_total_square + 1/(E(k)^2);
end
final_pos = [0, 0];
for k= 1: K
    final_pos = final_pos + (((1/E(k)^2)/E_total_square) * positions(k, :));
end

final_pos = final_pos * GridResolution


function [dist2d] = distanceCalc(AntennaPos, TagPos)
    dist2d = norm(TagPos-AntennaPos);
end
        
        
        
        
        
        
        
        
