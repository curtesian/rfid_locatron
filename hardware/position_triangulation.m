%% Position Function Using Triangulation
% RFID Team
% Curtis Manore
%close all; clear;

% Test Inputs (Uncomment lines to test)
%distances = [2.828 2.236 1.414 2.236];
antenna_locs = [[0,0]; [0,3]; [3,3]; [3,0]]; %2D input for now

% Test Position Function
%pos = position2d(distances,antenna_locs);
%est_pos = [pos(1) pos(2)];

% Test Error Function
%actPos = [2 2];
%error = error2d(est_pos, actPos);

%rssi=10; %dbm strength if we put db equal to room length
RSSI = [out.RSSI1(1) out.RSSI2(1) out.RSSI3(1) out.RSSI4(1)];
A=out.RSSI_test(1); %dbm strength when length=1m; Original A = 5
d0=3; %length of room
n = zeros(1,4,'double');
for i = 1:4
    n(i) = -(RSSI(i)-A)/(10*log10(d0)); %constant
end
nhat = mean(n);

d = zeros(1,4,'double');
for i = 1:4
    %RSSI(i) = input() %strength received from tag
    d(i)= 10^((-RSSI(i)-A)/(10*nhat)); %distance
end
pos = position2d(d,antenna_locs);
est_pos = [pos(1) pos(2)];

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