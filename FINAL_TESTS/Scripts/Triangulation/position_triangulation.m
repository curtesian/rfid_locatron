%% Position Function Using Triangulation
% RFID Team
% Curtis Manore
%close all; clear;

% Test Inputs (Uncomment lines to test)
%distances = [2.828 2.236 1.414 2.236];
antenna_locs = [[0,0]; [0,3]; [3,3]; [3,0]]; %2D input for now
TagLocations = [1,1;1,2;2,2;2,1];

% Test Position Function
%pos = position2d(distances,antenna_locs);
%est_pos = [pos(1) pos(2)];

% Test Error Function
%actPos = [2 2];
%error = error2d(est_pos, actPos);

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
%e = error2d([2.3754    2.3754],[2 2]);

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