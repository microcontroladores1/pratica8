%UH Summary of this function goes here
%   Detailed explanation goes here

function high_time = H( v )

k = 1000/255;
high_time = round(1000 + k*v);

end

