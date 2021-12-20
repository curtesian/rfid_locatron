%% Initial Setup
XMax = 5;
YMax = 5;
GridResolution = 0.1;

load("Fingerprinting_data_Noisy.mat");


x = 0:GridResolution : XMax;
y = 0:GridResolution : YMax;

%X= Index (1) of grid Y= Index(2) of grid
[X,Y] = meshgrid(x,y);

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
        SimulationData.(TagNames{i}).TXPower = TagTransmissionPower(i,:);
        SimulationData.(TagNames{i}).TrueLocation = TagLocations(i,:);
        SimulationData.(TagNames{i}).RSSI = zeros(50,4,'double');   % 50 Here is the total Iteration Count
        SimulationData.(TagNames{i}).EstimatedLocation = zeros(50,2,'double');   
        SimulationData.(TagNames{i}).PositionError = zeros(50,1,'double');
    end
   A = 0.8838; % raw value from RSSI_test
%% Attaching distance Dataset to simulation

model = 'antenna_simNoisy';
open(model)
  % ====Simulation Params Setup===== %
            FreqCarrier = 9.15e+08;
            Gr = 6; 
            Gt = 1.56; 
            Zin_r = 50; 
            Zin_t = 7.056465388996018e-01 + 2.916241413655430e+02i;
            lambdaCarrier = physconst('LightSpeed')/FreqCarrier;
            
            %Preset Distances for corroboration %
            R1 = 2.828;
            R2 = 2.236;
            R3 = 1.414;
            R4 = 2.236;
            Rtest = 1;

            set_param('antenna_simNoisy/Antenna_TX','Gr',num2str(Gt))
            set_param('antenna_simNoisy/Antenna_TX','Zin',num2str(Zin_t))
            set_param('antenna_simNoisy/Antenna_TX','CarrierFreqRad',num2str(FreqCarrier))
            set_param('antenna_simNoisy/PA','Zin',num2str(Zin_r))      
            set_param('antenna_simNoisy/Inport','CarrierFreq',num2str(FreqCarrier))
            
            set_param('antenna_simNoisy/Antenna_RX','Gr',num2str(Gr))
            set_param('antenna_simNoisy/Antenna_RX1','Gr',num2str(Gr))
            set_param('antenna_simNoisy/Antenna_RX2','Gr',num2str(Gr))
            set_param('antenna_simNoisy/Antenna_RX3','Gr',num2str(Gr))
            set_param('antenna_simNoisy/Antenna_RX4','Gr',num2str(Gr))
            set_param('antenna_simNoisy/Antenna_RX','Zin',num2str(Zin_r))
            set_param('antenna_simNoisy/Antenna_RX1','Zin',num2str(Zin_r))
            set_param('antenna_simNoisy/Antenna_RX2','Zin',num2str(Zin_r))
            set_param('antenna_simNoisy/Antenna_RX3','Zin',num2str(Zin_r))
            set_param('antenna_simNoisy/Antenna_RX4','Zin',num2str(Zin_r))
            set_param('antenna_simNoisy/Antenna_RX','CarrierFreqRad',num2str(FreqCarrier))
            set_param('antenna_simNoisy/Antenna_RX1','CarrierFreqRad',num2str(FreqCarrier))
            set_param('antenna_simNoisy/Antenna_RX2','CarrierFreqRad',num2str(FreqCarrier))
            set_param('antenna_simNoisy/Antenna_RX3','CarrierFreqRad',num2str(FreqCarrier))
            set_param('antenna_simNoisy/Antenna_RX4','CarrierFreqRad',num2str(FreqCarrier))
             
             
            set_param('antenna_simNoisy/FS_PathLoss1','Gain',num2str(lambdaCarrier/(4*pi*R1)))
            set_param('antenna_simNoisy/FS_PathLoss2','Gain',num2str(lambdaCarrier/(4*pi*R2)))
            set_param('antenna_simNoisy/FS_PathLoss3','Gain',num2str(lambdaCarrier/(4*pi*R3)))
            set_param('antenna_simNoisy/FS_PathLoss4','Gain',num2str(lambdaCarrier/(4*pi*R4)))
            set_param('antenna_simNoisy/FS_PathLossTest','Gain',num2str(lambdaCarrier/(4*pi*Rtest)))
              
            set_param('antenna_simNoisy/LNA','Zin',num2str(Zin_r'))
            set_param('antenna_simNoisy/LNA1','Zin',num2str(Zin_r'))
            set_param('antenna_simNoisy/LNA2','Zin',num2str(Zin_r'))
            set_param('antenna_simNoisy/LNA3','Zin',num2str(Zin_r'))
            set_param('antenna_simNoisy/LNA4','Zin',num2str(Zin_r'))
             
     
           set_param('antenna_simNoisy/RA1','CarrierFreq',num2str(FreqCarrier))
           set_param('antenna_simNoisy/RA2','CarrierFreq',num2str(FreqCarrier))
           set_param('antenna_simNoisy/RA3','CarrierFreq',num2str(FreqCarrier))
           set_param('antenna_simNoisy/RA4','CarrierFreq',num2str(FreqCarrier))
           set_param('antenna_simNoisy/RA5','CarrierFreq',num2str(FreqCarrier))

            
%% Coordinate System on Matrices
%      (0,0)     0     0     0     0     0     0     0     0     0     0    (0,3)  
%           0     0     0     0     0     0     0     0     0     0     0     0   
%           0     0     0     0     0     0     0     0     0     0     0     0     
%           0     0     0     0     0     0     0     0     0     0     0     0   
%           0     0     0     0     0     0     0     0     0     0     0     0    
%      (3,0)    0     0     0     0     0     0     0     0     0     0     (3,3)     
%% Coordinate System on images
%      (0,3)     0     0     0     0     0     0     0     0     0     0    (3,3)  
%           0     0     0     0     0     0     0     0     0     0     0     0   
%           0     0     0     0     0     0     0     0     0     0     0     0     
%           0     0     0     0     0     0     0     0     0     0     0     0   
%           0     0     0     0     0     0     0     0     0     0     0     0    
%      (0,0)    0     0     0     0     0     0     0     0     0     0     (3,0)     
% Triangulation function might need changing
%% 
% DistMatrix  = zeros(length(AntennaPosIndex), XMax / GridResolution, YMax / GridResolution);
%  for AntennaPosCounter = 2:size(AntennaPosIndex,1)
%     for x_index = 1 : (XMax) / GridResolution +1
%         for y_index =1 : (YMax) / GridResolution +1
%             Tag_pos = [(x_index-1)*GridResolution, (y_index-1)*GridResolution];   
%              DistMatrix(AntennaPosCounter, x_index,y_index) =  distanceCalc(AntennaPosIndex(AntennaPosCounter,:), Tag_pos);
%         end
%     end
%  end

    for TagCounter = 1:size(TagLocations,1)
        set_param('antenna_simNoisy/Available input power (dBm)', 'Value', num2str(TagTransmissionPower(TagCounter)))
        for Iterations = 1:50
        set_param('antenna_simNoisy/FS_PathLoss1','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(antenna_locs(1,:), TagLocations(TagCounter,:)))));
        set_param('antenna_simNoisy/FS_PathLoss2','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(antenna_locs(2,:), TagLocations(TagCounter,:)))));
        set_param('antenna_simNoisy/FS_PathLoss3','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(antenna_locs(3,:), TagLocations(TagCounter,:)))));
        set_param('antenna_simNoisy/FS_PathLoss4','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(antenna_locs(4,:), TagLocations(TagCounter,:)))));

        %===================================================
        %model with AWGN
        %initial_seed = randi(5000);
        initial_seed = Iterations;

        noise_snr = 110;
        set_param('antenna_simNoisy/AWGN_Channel','seed',num2str(initial_seed));
        set_param('antenna_simNoisy/AWGN_Channel','EbNodB',num2str(noise_snr));

        SimOutput = sim(model, 'FastRestart', 'on');
        %Obtained Signal Strengths
        SimulationData.(TagNames{TagCounter}).RSSI(Iterations,:)  = [mean(SimOutput.RSSI1(:)), mean(SimOutput.RSSI2(:)),mean(SimOutput.RSSI3(:)),mean(SimOutput.RSSI4(:))];
        Data.RSSI =  [mean(SimOutput.RSSI1(:)), mean(SimOutput.RSSI2(:)),mean(SimOutput.RSSI3(:)),mean(SimOutput.RSSI4(:))];
        %=============================================%
        distances = DistEstimator(Data,A);
        pos = position2d(distances,antenna_locs);
        SimulationData.(TagNames{TagCounter}).EstimatedLocation(Iterations,:) = [pos(1), pos(2)];
        SimulationData.(TagNames{TagCounter}).PositionError(Iterations) = error2d(SimulationData.(TagNames{i}).EstimatedLocation(Iterations,:),TagLocations(TagCounter,:));
        end
    end

clearvars -except SimulationData GridResolution XMax YMax est_pos err2d distances A antenna_locs


%% From position_triangulation.m
function distances = DistEstimator(Data,A)    
    % A=Data.RSSI(5); %dbm strength when length=1m; Original A = 5
    d0=5; %length of room (5mx5m)
    n = [-(Data.RSSI(1)-A)/(10*log10(d0)), ...
                -(Data.RSSI(2)-A)/(10*log10(d0)), ...
                -(Data.RSSI(3)-A)/(10*log10(d0)), ...
                -(Data.RSSI(4)-A)/(10*log10(d0))]; %constant
    nhat = mean(n);
   
        %RSSI(i) = input() %strength received from tag
        distances= [10^((-Data.RSSI(1)-A)/(10*nhat)), ...
                             10^((-Data.RSSI(2)-A)/(10*nhat)), ...
                             10^((-Data.RSSI(3)-A)/(10*nhat)), ...
                             10^((-Data.RSSI(4)-A)/(10*nhat))];
    end    
% pos = position2d(d,antenna_locs);
% est_pos = [pos(1) pos(2)];

function pos = position2d(distances, antenna_locs)
    % Use nonlinear least squares approach, problem based
    % Function works as expected, tested with data
    xy = optimvar('xy',2);

    % 2D Triangulation Equations
    eq1 = ((xy(1) - antenna_locs(1,1))^2 + (xy(2) - antenna_locs(1,2))^2 == (distances(1))^2);
    eq2 = ((xy(1) - antenna_locs(2,1))^2 + (xy(2) - antenna_locs(2,2))^2 == (distances(2))^2);
    eq3 = ((xy(1) - antenna_locs(3,1))^2 + (xy(2) - antenna_locs(3,2))^2 == (distances(3))^2);
    eq4 = ((xy(1) - antenna_locs(4,1))^2 + (xy(2) - antenna_locs(4,2))^2 == (distances(4))^2);

    prob = eqnproblem;
    prob.Equations.eq1 = eq1;
    prob.Equations.eq2 = eq2;
    prob.Equations.eq3 = eq3;
    prob.Equations.eq4 = eq4;

    x0.xy = [0 0];
    [sol,fval,exitflag] = solve(prob,x0);
    %disp(sol.xy)

    % Return position 2D
    pos = sol.xy;
end

function e = error2d(estPos, actualPos)
    e = sqrt((actualPos(1)-estPos(1))^2 + (actualPos(2)-estPos(2))^2);
end

function [dist2d] = distanceCalc(AntennaPos, TagPos)
    dist2d = norm(TagPos-AntennaPos);
end
% Create error functions for results (2d and 3d)

