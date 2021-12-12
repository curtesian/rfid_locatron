
XMax = 3;
YMax = 3;
ZMax = 3;

GridResolution = 0.1;

x = 0:GridResolution : XMax;
y = 0:GridResolution : YMax;
z = 0:GridResolution : ZMax;

[X,Y,Z] = meshgrid(x,y,z);



%% Define Antenna Positions  X= Index (1) of grid Y= Index(2) of grid Z = index(3)
AntennaPosIndex = [X(1), Y(1), Z(1) ; 
                                    X(end),Y(end),  Z(end)]; % [m]


%% Initialize Distance matrix
DistMatrix  = zeros(length(AntennaPosIndex), XMax / GridResolution, YMax / GridResolution, ZMax/GridResolution);
%% Uniformly distribute along the entire room
for AntennaPosCounter = 1:size(AntennaPosIndex,1)
   for x_index = 1 : (XMax) / GridResolution +1
    for y_index =1 : (YMax) / GridResolution +1
         for z_index =1 : (ZMax) / GridResolution +1
            Tag_pos = [(x_index-1)*GridResolution, (y_index-1)*GridResolution, (z_index-1)*GridResolution];
            DistMatrix(AntennaPosCounter, x_index,y_index,z_index)=  distanceCalc(AntennaPosIndex(AntennaPosCounter,:), Tag_pos);
            end
        end
    end
end

%% Constrain sample tags to only walls

for x_index = 1 : (XMax) / GridResolution +1
    for y_index =1 : (YMax) / GridResolution +1
         for z_index =1 : (ZMax) / GridResolution +1
            Tag_pos = [(x_index-1)*GridResolution, (y_index-1)*GridResolution, (z_index-1)*GridResolution];
            for AntennaPosCounter = 1:size(AntennaPosIndex,1)
                if (x_index>0 && x_index<XMax && y_index >0 && y_index<YMax && z_index>0 && z_index<ZMax)
                  DistMatrix(AntennaPosCounter, x_index,y_index,z_index)=  nan;
                else
                  DistMatrix(AntennaPosCounter, x_index,y_index,z_index)=  distanceCalc(AntennaPosIndex(AntennaPosCounter,:), Tag_pos);
                end
           end
        end
    end
end
    




Data.Antenna1.AntennaPos = AntennaPosIndex(1,:);  
Data.Antenna2.AntennaPos = AntennaPosIndex(2,:);  
Data.Antenna3.AntennaPos = AntennaPosIndex(3,:);  
Data.Antenna4.AntennaPos =AntennaPosIndex(4,:);  

Data.Antenna1.DistMat = zeros( XMax / GridResolution, YMax / GridResolution, ZMax/GridResolution);
Data.Antenna2.DistMat = zeros( XMax / GridResolution, YMax / GridResolution,ZMax/GridResolution);
Data.Antenna3.DistMat = zeros( XMax / GridResolution, YMax / GridResolution,ZMax/GridResolution);
Data.Antenna4.DistMat = zeros( XMax / GridResolution, YMax / GridResolution,ZMax/GridResolution);







function [dist3d] = distanceCalc(AntennaPos, TagPos)
    dist3d = norm(TagPos-AntennaPos);
end




