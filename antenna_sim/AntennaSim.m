%% Simulation of RF Systems with Antenna Blocks
% Use the antenna block to incorporate the effect of an antenna into an RF
% simulation. In this model, a single tone is fed to the transmitter
% and the power of the received signal at the output of the receiver is
% calculated.
model = 'antenna_sim';
open(model)

% Parameters
FreqCarrier = 9.15e+08; % Operating Frequency - 915 MHz
Gr = 6; % Gain of antenna receivers = 6 dBi
Gt = 1.56; % Gain of RFID tag = 1.56 dBi
Zin_r = 50; % Impedance of antennas
Zin_t = 7.056465388996018e-01 + 2.916241413655430e+02i; % Impedance of tag

% Distances to tag (current location (2,2))
% [2.828 2.236 1.414 2.236]
R1 = 2.828;
R2 = 2.236;
R3 = 1.414;
R4 = 2.236;

Rtest = 1; % For getting RSSI at 1 meter distance

% Unknown parameters to configure
% lambdaCarrier
% Available input power (dBm) from tag

% Run simulation
sim(model);

