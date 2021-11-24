%    properties (Access = public)
%         RoomBoundX     = 3.0  % Room Length
%         RoomBoundY     = 3.0  % Room Breadth
%         RoomBoundZ     = 3.0  % Room Height
%         NeighborCount  = 0    % Number of K-Nearest Neighbors needed when localizing Tag
%         FoundStateFlag = 0    % Flag to store state for indicator lights. |||Initially zero -> Not Found|||
%         TagNumber      = 'Tag1'    % Default value of tag to be tracked, updated in callback
%         XPos           = 0.0
%         YPos           = 0.0
%         ZPos           = 0.0
%         PosVariance    = [0,0,0]
%         PosTable       = table()
%    end


% 
%     function [] = triangulator(app, distances, antenna_locs)
%             xyz = optimvar('xyz',3);
%             % 3D Triangulation Equations
%             eq1 = ((xyz(1) - antenna_locs(1,1))^2 + (xyz(2) - antenna_locs(1,2))^2 + (xyz(3) - antenna_locs(1,3))^2 == (distances(1))^2);
%             eq2 = ((xyz(1) - antenna_locs(2,1))^2 + (xyz(2) - antenna_locs(2,2))^2 + (xyz(3) - antenna_locs(2,3))^2 == (distances(2))^2);
%             eq3 = ((xyz(1) - antenna_locs(3,1))^2 + (xyz(2) - antenna_locs(3,2))^2 + (xyz(3) - antenna_locs(3,3))^2 == (distances(3))^2);
%             eq4 = ((xyz(1) - antenna_locs(4,1))^2 + (xyz(2) - antenna_locs(4,2))^2 + (xyz(3) - antenna_locs(4,3))^2 == (distances(4))^2);
%         
%             prob = eqnproblem;
%             prob.Equations.eq1 = eq1;
%             prob.Equations.eq2 = eq2;
%             prob.Equations.eq3 = eq3;
%             prob.Equations.eq4 = eq4;
%         
%             x0.xyz = [0 0 0];
%             [sol,~,~] = solve(prob,x0);
%         
%             % Return position 3D
%             pos      = sol.xyz; %Row Vector [3x1]
%             app.XPos = pos(1);
%             app.YPos = pos(2);
%             app.ZPos = pos(3);
%         end


% function LocateButtonPushed(app, event)
% %             When this button is pushed, call other callback functions
%               app.LocateButton.BackgroundColor = [0,0,0];
%                 
% %               Set/Reset app.FoundStateFlag using data received in another callback function
%                 if app.FoundStateFlag == 0
%                     app.LocatedLampIndicator.Color = [0.1,0.5,0.1];
%                     app.MissingLampIndicator.Color = [1,0,0];
%                 else
%                     app.LocatedLampIndicator.Color = [0,0,1];
%                     app.MissingLampIndicator.Color = [0.5,0.1,0.1];
%                 end
%               
%         end

        
%  function NeighborCountFunc(app, event)
%             app.NeighborCount = app.SetNeighborCountKnob.Value;
%         end
% 
%         % Value changed function: SelectTagDropDown
%         function SelectTagDropDownValueChanged(app, event)
%             app.TagNumber = app.SelectTagDropDown.Value;
%         end
%     end