
%% Initial Setup
XMax = 5;
YMax = 5;
GridResolution = 0.1;

x = 0:GridResolution : XMax;
y = 0:GridResolution : YMax;

%X= Index (1) of grid Y= Index(2) of grid
[X,Y] = meshgrid(x,y);
AntennaPosIndex = [X(1), Y(1); 
                                    X(1),Y(end); 
                                    X(end), Y(end);
                                    X(end), Y(1)]; % [m]   

TagLocations = [3.5,1;3,2;4,2;2,3];

%% Attaching distance Dataset to simulation

model = 'KNN_DataGen';
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

            set_param('KNN_DataGen/Antenna_TX','Gr',num2str(Gt))
            set_param('KNN_DataGen/Antenna_TX','Zin',num2str(Zin_t))
            set_param('KNN_DataGen/Antenna_TX','CarrierFreqRad',num2str(FreqCarrier))
            set_param('KNN_DataGen/PA','Zin',num2str(Zin_r))      
            set_param('KNN_DataGen/Inport','CarrierFreq',num2str(FreqCarrier))
            
            set_param('KNN_DataGen/Antenna_RX','Gr',num2str(Gr))
            set_param('KNN_DataGen/Antenna_RX1','Gr',num2str(Gr))
            set_param('KNN_DataGen/Antenna_RX2','Gr',num2str(Gr))
            set_param('KNN_DataGen/Antenna_RX3','Gr',num2str(Gr))
            set_param('KNN_DataGen/Antenna_RX4','Gr',num2str(Gr))
            set_param('KNN_DataGen/Antenna_RX','Zin',num2str(Zin_r))
            set_param('KNN_DataGen/Antenna_RX1','Zin',num2str(Zin_r))
            set_param('KNN_DataGen/Antenna_RX2','Zin',num2str(Zin_r))
            set_param('KNN_DataGen/Antenna_RX3','Zin',num2str(Zin_r))
            set_param('KNN_DataGen/Antenna_RX4','Zin',num2str(Zin_r))
            set_param('KNN_DataGen/Antenna_RX','CarrierFreqRad',num2str(FreqCarrier))
            set_param('KNN_DataGen/Antenna_RX1','CarrierFreqRad',num2str(FreqCarrier))
            set_param('KNN_DataGen/Antenna_RX2','CarrierFreqRad',num2str(FreqCarrier))
            set_param('KNN_DataGen/Antenna_RX3','CarrierFreqRad',num2str(FreqCarrier))
            set_param('KNN_DataGen/Antenna_RX4','CarrierFreqRad',num2str(FreqCarrier))
             
             
            set_param('KNN_DataGen/FS_PathLoss1','Gain',num2str(lambdaCarrier/(4*pi*R1)))
            set_param('KNN_DataGen/FS_PathLoss2','Gain',num2str(lambdaCarrier/(4*pi*R2)))
            set_param('KNN_DataGen/FS_PathLoss3','Gain',num2str(lambdaCarrier/(4*pi*R3)))
            set_param('KNN_DataGen/FS_PathLoss4','Gain',num2str(lambdaCarrier/(4*pi*R4)))
            set_param('KNN_DataGen/FS_PathLossTest','Gain',num2str(lambdaCarrier/(4*pi*Rtest)))
              
            set_param('KNN_DataGen/LNA','Zin',num2str(Zin_r'))
            set_param('KNN_DataGen/LNA1','Zin',num2str(Zin_r'))
            set_param('KNN_DataGen/LNA2','Zin',num2str(Zin_r'))
            set_param('KNN_DataGen/LNA3','Zin',num2str(Zin_r'))
            set_param('KNN_DataGen/LNA4','Zin',num2str(Zin_r'))
             
     
           set_param('KNN_DataGen/RA1','CarrierFreq',num2str(FreqCarrier))
           set_param('KNN_DataGen/RA2','CarrierFreq',num2str(FreqCarrier))
           set_param('KNN_DataGen/RA3','CarrierFreq',num2str(FreqCarrier))
           set_param('KNN_DataGen/RA4','CarrierFreq',num2str(FreqCarrier))
           set_param('KNN_DataGen/RA5','CarrierFreq',num2str(FreqCarrier))

            
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

Data.Antenna1.AntennaPos = AntennaPosIndex(1,:);  
Data.Antenna2.AntennaPos = AntennaPosIndex(2,:);  
Data.Antenna3.AntennaPos = AntennaPosIndex(3,:);  
Data.Antenna4.AntennaPos =AntennaPosIndex(4,:);  

Data.Antenna1.RSSI = zeros(4,1);
Data.Antenna2.RSSI = zeros(4,1);
Data.Antenna3.RSSI = zeros(4,1);
Data.Antenna4.RSSI = zeros(4,1);



    for TagLocationsCounter = 1:size(TagLocations,1)
        %============SIMULATION CALL==================%
        

        set_param('KNN_DataGen/FS_PathLoss1','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(AntennaPosIndex(1,:), TagLocations(TagLocationsCounter,:)))));
        set_param('KNN_DataGen/FS_PathLoss2','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(AntennaPosIndex(2,:), TagLocations(TagLocationsCounter,:)))));
        set_param('KNN_DataGen/FS_PathLoss3','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(AntennaPosIndex(3,:), TagLocations(TagLocationsCounter,:)))));
        set_param('KNN_DataGen/FS_PathLoss4','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(AntennaPosIndex(4,:), TagLocations(TagLocationsCounter,:)))));

        SimOutput = sim(model, 'FastRestart', 'off');
        %Obtained Signal Strengths
        Data.Antenna1.RSSI(TagLocationsCounter)  =SimOutput.RSSI1(1);
        Data.Antenna2.RSSI(TagLocationsCounter) = SimOutput.RSSI2(1);
        Data.Antenna3.RSSI(TagLocationsCounter) = SimOutput.RSSI3(1);
        Data.Antenna4.RSSI(TagLocationsCounter) = SimOutput.RSSI4(1);
    end
        %=============================================%


% Result crunching:
antenna_locs = [[0,0]; [0,5]; [5,5]; [5,0]];
A = 0.8838; % raw value from RSSI_test
distances = DistEstimator(Data,A);

% 2D results processing
est_pos = zeros(4,2);
err2d = zeros(4,1);
for i = 1:4
    pos = position2d(distances(i,:),antenna_locs);
    est_pos(i,:) = [pos(1) pos(2)];
    err2d(i) = error2d(est_pos(i,:),TagLocations(i,:));
end

clearvars -except Data DistMatrix GridResolution XMax YMax est_pos err2d distances A antenna_locs

function [dist2d] = distanceCalc(AntennaPos, TagPos)
    dist2d = norm(TagPos-AntennaPos);
end


%% From position_triangulation.m
function distances = DistEstimator(Data,A)    
    % A=Data.RSSI(5); %dbm strength when length=1m; Original A = 5
    d0=3; %length of room
    n = zeros(4);
    nhat = zeros(4,1);
    for i = 1:4
        n(i,:) = [-(Data.Antenna1.RSSI(i)-A)/(10*log10(d0)), ...
                -(Data.Antenna2.RSSI(i)-A)/(10*log10(d0)), ...
                -(Data.Antenna3.RSSI(i)-A)/(10*log10(d0)), ...
                -(Data.Antenna4.RSSI(i)-A)/(10*log10(d0))]; %constant
        nhat(i) = mean(n(i,:));
    end
    
    %nhat = mean(n);
    distances = zeros(4);
    for i = 1:4
        %RSSI(i) = input() %strength received from tag
        distances(i,:)= [10^((-Data.Antenna1.RSSI(i)-A)/(10*nhat(i))), ...
                             10^((-Data.Antenna2.RSSI(i)-A)/(10*nhat(i))), ...
                             10^((-Data.Antenna3.RSSI(i)-A)/(10*nhat(i))), ...
                             10^((-Data.Antenna4.RSSI(i)-A)/(10*nhat(i)))];
    end    
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

function pos = position3d(distances, antenna_locs)
    % Use nonlinear least squares approach, problem based
    % Function works as expected, tested with data
    xyz = optimvar('xyz',3);

    % 3D Triangulation Equations
    eq1 = ((xyz(1) - antenna_locs(1,1))^2 + (xyz(2) - antenna_locs(1,2))^2 + (xyz(3) - antenna_locs(1,3))^2 == (distances(1))^2);
    eq2 = ((xyz(1) - antenna_locs(2,1))^2 + (xyz(2) - antenna_locs(2,2))^2 + (xyz(3) - antenna_locs(2,3))^2 == (distances(2))^2);
    eq3 = ((xyz(1) - antenna_locs(3,1))^2 + (xyz(2) - antenna_locs(3,2))^2 + (xyz(3) - antenna_locs(3,3))^2 == (distances(3))^2);
    eq4 = ((xyz(1) - antenna_locs(4,1))^2 + (xyz(2) - antenna_locs(4,2))^2 + (xyz(3) - antenna_locs(4,3))^2 == (distances(4))^2);

    prob = eqnproblem;
    prob.Equations.eq1 = eq1;
    prob.Equations.eq2 = eq2;
    prob.Equations.eq3 = eq3;
    prob.Equations.eq4 = eq4;

    x0.xyz = [0 0 0];
    [sol,fval,exitflag] = solve(prob,x0);
    %disp(sol.xyz)

    % Return position 3D
    pos = sol.xyz;
end

% Create error functions for results (2d and 3d)
function e = error2d(estPos, actualPos)
    e = sqrt((actualPos(1)-estPos(1))^2 + (actualPos(2)-estPos(2))^2);
end

function e = error3d(estPos, actualPos)
    e = sqrt((actualPos(1)-estPos(1))^2 + (actualPos(2)-estPos(2))^2 + (actualPos(3)-estPos(3))^2);
end

