function [high_byte, low_byte] = splitBytes( num )

    bytes = typecast(num, 'uint8');
    high_byte = bytes(2); % byte maior é o segundo elemento
    low_byte = bytes(1); % byte menor é o primeiro elemento

end

