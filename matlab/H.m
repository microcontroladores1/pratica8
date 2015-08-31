%UH Summary of this function goes here
%   Detailed explanation goes here

function high_time = H( v )

k = (500/90) * (180/255);
high_time = uint16( round(1000 + k*v) );

end

