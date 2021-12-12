
XMax = 3;
YMax = 3;
GridResolution = 0.1;

x = 0:GridResolution : XMax;
y = 0:GridResolution : YMax;

%X= Index (1) of grid Y= Index(2) of grid
[X,Y] = meshgrid(x,y);
AntennaPosIndex = [X(1), Y(1); 
                                    X(1),Y(end); 
                                    X(end), Y(end);
                                    X(end), Y(1)]; % [m]   
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

Data.Antenna1.DistMat = zeros( XMax / GridResolution, YMax / GridResolution);
Data.Antenna2.DistMat = zeros( XMax / GridResolution, YMax / GridResolution);
Data.Antenna3.DistMat = zeros( XMax / GridResolution, YMax / GridResolution);
Data.Antenna4.DistMat = zeros( XMax / GridResolution, YMax / GridResolution);

 for AntennaPosCounter = 1:size(AntennaPosIndex,1)
    for x_index = 1 : (XMax) / GridResolution +1
        for y_index =1 : (YMax) / GridResolution +1
            Tag_pos = [(x_index-1)*GridResolution, (y_index-1)*GridResolution];   
            Data.Antenna1.DistMat( x_index,y_index)=  distanceCalc(Data.Antenna1.AntennaPos, Tag_pos);
            Data.Antenna2.DistMat( x_index,y_index)=  distanceCalc(Data.Antenna2.AntennaPos, Tag_pos);
            Data.Antenna3.DistMat( x_index,y_index)=  distanceCalc(Data.Antenna3.AntennaPos, Tag_pos);
            Data.Antenna4.DistMat( x_index,y_index)=  distanceCalc(Data.Antenna4.AntennaPos, Tag_pos);
        end
    end
 end
 clearvars -except Data DistMatrix GridResolution XMax YMax

function [dist2d] = distanceCalc(AntennaPos, TagPos)
    dist2d = norm(TagPos-AntennaPos);
end




