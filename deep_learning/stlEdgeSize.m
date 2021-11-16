%% Find STL Model Size
% Used for finding the dimensions of the STL model
% Requires Partial Differential Equation Toolbox

%Import the STL file
   model = createpde(1);
   b=importGeometry(model,'office.stl'); % Put your file name here
   g=model.Geometry;
%Calculate the edges length
   [Ex, Ey, Ez] = g.allDisplayEdges(); %list of edges
   c=(sqrt((Ex(1,:)-Ex(2,:)).^2+(Ey(1,:)-Ey(2,:)).^2+(Ez(1,:)-Ez(2,:)).^2));%the matrix with the length of each edge