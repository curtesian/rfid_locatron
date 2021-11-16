%% Simulation of RF Systems with Antenna Blocks
% Use the antenna block to incorporate the effect of an antenna into an RF
% simulation. In this model, a single tone is fed to the transmitter
% and the power of the received signal at the output of the receiver is
% calculated.
model = 'Antenna_block_example';
open(model)
sim(model);
% Copyright 2020 The MathWorks, Inc.
%% 
% Set the *Antenna_TX* and *Antenna_RX* blocks to be isotropic radiators
% with the following parameters:
%
% <<../Antenna_TX.png>>
%
% <<../Antenna_RX.png>>
%
% The following values are set upon loading the model:
%
% * R = 100 [m]
% * FreqCarrier = 5.0 [GHz]
% * Gt = Gr = 7.9988 [dBi]
% * Zin_t = Zin_r = 56.2947 - 4.2629i [Ohm]
%
% where the antenna gains and impedances were calculated beforehand from
% dipoles backed by circular reflectors.
%%
% With Antenna Toolbox, it is possible to design the antenna using the
% Antenna Designer app invoked directly from the block. To do so, change
% the choice of *Source of the antenna model* to *Antenna Designer* and
% press the *Create antenna* button. Within the Antenna Designer app,
% create a new antenna, choose *Dipole* from the Antenna Gallery,
% *Circular* from the Backing Structure Gallery in the app toolstrip and
% press *Accept*. Note that the design frequency was prepopulated with the
% RF system frequency of 5 GHz.
%
% <<../antenna_update_block.png>>
%
% Press the *Impedance* button in the app toolstrip to analyze the
% structure and press the *Update Block* button to update the block with
% the chosen antenna. Note that the Antenna block requires that the
% designed antenna be analyzed for at least one frequency in the Antenna
% Designer app before updating and using it in the block.
%%
% In the *Antenna_TX* block mask parameter dialog box, change the default
% *Direction of departure* to 0 degrees in azimuth and 90 degrees in
% elevation:
%
% <<../Antenna_TX_AntDes.png>>
%
%%
% Repeat the above steps to design *Antenna_RX*. However, the receiving
% antenna needs to be rotated to face the transmitting antenna. To do so,
% in the Antenna Properties panel of the Antenna Designer app, change
% *Tilt* to 180 degrees. Again, press the *Impedance* button and then press
% the *Update Block* button to update the block. In the *Antenna_RX* block
% mask parameter dialog box, change the *Direction of arrival* to 0 degrees
% in azimuth and -90 degrees in elevation. We choose -90 degrees in
% elevation since the radiated signal that was transmitted in the positive
% z direction in the coordinate system of the transmitter, is now arriving
% from the negative z direction in the coordinate system of the receiver.
%%
% Run the model again, and note that the output power remained almost
% exactly the same. This is since the original gain and impedance values
% used for the isotropically radiating antenna in the beginning were
% calculated from the same antennas and spatial settings. However, it is
% now possible to change the antenna properties and observe the effect on
% the output power in the model. For example: press the 'Edit Antenna'
% button in the *Antenna_TX* block mask parameter dialog box to reopen the
% Antenna Designer app. In the Antenna Properties panel of the Antenna
% Designer app, change *Tilt* to 30 degrees and the *TiltAxis* to [0 1 0].
% Press the *Impedance* button and then press the *Update Block* button to
% update the block. Rerun the model to observe reduction of 2.5 dB in
% the output received power due to the mismatch in antenna orientation.