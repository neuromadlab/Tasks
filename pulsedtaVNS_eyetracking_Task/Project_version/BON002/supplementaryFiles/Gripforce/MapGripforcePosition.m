function [ResultL, ResultR, GripFSpec] = MapGripforcePosition( ...
    GripFDev, GripFSpec, TargetRange)
% This function maps the polled values of the gripforce device to the
% target-range & updates the specification bounds.
if(nargin < 2)
    GripFSpec.MinL		= 32765;
    GripFSpec.MaxL		= 500;
    GripFSpec.MinR      = 32765;
    GripFSpec.MaxR      = 500;
end
if(nargin < 3)
	TargetRange = [0 100];
end

% compute the mapped values
ResultL = GripFDev.X;
ResultL = (ResultL - GripFSpec.MinL) / (GripFSpec.MaxL - GripFSpec.MinL);
ResultL = ResultL * (TargetRange(2) - TargetRange(1)) + TargetRange(1);
ResultR = GripFDev.Y;
ResultR = (ResultR - GripFSpec.MinR) / (GripFSpec.MaxR - GripFSpec.MinR);
ResultR = ResultR * (TargetRange(2) - TargetRange(1)) + TargetRange(1);

% update the specification bounds left
if(GripFSpec.MinL > GripFDev.X) 
	GripFSpec.MinL = GripFDev.X; %update minimal value to actual minium
end
if(GripFSpec.MaxL < GripFDev.X) 
	GripFSpec.MaxL = GripFDev.X;
end
% update the specification bounds right
if(GripFSpec.MinR > GripFDev.Y) 
	GripFSpec.MinR = GripFDev.Y; %update minimal value to actual minium
end
if(GripFSpec.MaxR < GripFDev.Y) 
	GripFSpec.MaxR = GripFDev.Y;
end
end %----------------------------------------------------------------------