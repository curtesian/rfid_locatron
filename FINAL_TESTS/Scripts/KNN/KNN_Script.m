
N = 4; %Antenna Reader Count
Data = import("FingerPrintingData.mat");
model = 'KNN_Results';
open(model)


%% ====Simulation Params Setup===== %%
            FreqCarrier = 9.15e+08;
            Gr = 6; 
            Gt = 1.56; 
            Zin_r = 50; 
            Zin_t = 7.056465388996018e-01 + 2.916241413655430e+02i;
            lambdaCarrier = physconst('LightSpeed')/FreqCarrier;

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

            R1 = 2.828;
            R2 = 2.236;
            R3 = 1.414;
            R4 = 2.236;
            Rtest = 1;

      %============SIMULATION CALL==================%
        

        set_param('KNN_DataGen/FS_PathLoss1','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(AntennaPosIndex(1,:), TagLocations(TagLocationsCounter,:)))));
        set_param('KNN_DataGen/FS_PathLoss2','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(AntennaPosIndex(2,:), TagLocations(TagLocationsCounter,:)))));
        set_param('KNN_DataGen/FS_PathLoss3','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(AntennaPosIndex(3,:), TagLocations(TagLocationsCounter,:)))));
        set_param('KNN_DataGen/FS_PathLoss4','Gain',num2str(lambdaCarrier/(4*pi*distanceCalc(AntennaPosIndex(4,:), TagLocations(TagLocationsCounter,:)))));

        SimOutput = sim(model, 'FastRestart', 'off');
        %Obtained Signal Strengths
        RSSI(1)  =mean(SimOutput.RSSI1(1));
        RSSI(2) = mean(SimOutput.RSSI2(1));
        RSSI(3) = mean(SimOutput.RSSI3(1));
        RSSI(4) = mean(SimOutput.RSSI4(1));
        %=============================================%
% Result crunching:
antenna_locs = [[0,0]; [0,5]; [5,5]; [5,0]];

