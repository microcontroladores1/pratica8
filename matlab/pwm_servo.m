%% Gera duas tabelas para serem incluido em um programa assembly.

th_high = 'TH_HIGH:'; % tabela de bytes altos do TEMPO ALTO
th_low = 'TH_LOW:';   % tabela de bytes baixos do TEMPO ALTO

tl_high = 'TL_HIGH:'; % tabela de bytes altos do TEMPO BAIXO
tl_low = 'TL_LOW:';   % tabela de bytes baixos do TEMPO BAIXO

for v = 0:255
    
    %% Calculo do tempo de alto do pwm
    high_time = H(v);
    
    % Separo em byte maior e byte menor para usar na tabela
    bytes = typecast(high_time, 'uint8');
    high_byte = bytes(2); % byte maior é o segundo elemento
    low_byte = bytes(1); % byte menor é o primeiro elemento
    
    %% Monta a tabela de bytes altos do tempo alto
    str = '';
    if v ~= 255
        str = sprintf('%sh,', dec2hex(high_byte,3));
    else
        str = sprintf('%sh',dec2hex(high_byte,3));
    end
    
    th_high = strcat(th_high, str);
    
    %% Monta a tabela de bytes baixos do tempo alto
    str = '';
    if v ~= 255
        str = sprintf('%sh,', dec2hex(low_byte,3));
    else if v == 255
        str = sprintf('%sh', dec2hex(low_byte,3));
        end
    end
    th_low = strcat(th_low, str);
    
    %% Calculo do tempo de baixo
    low_time = L(v);
    
    % Separo o valor do tempo de baixo do pwm em dois bytes para uso na
    % tabela
    bytes = typecast(low_time, 'uint8');
    high_byte = bytes(2); % byte maior é o segundo elemento
    low_byte = bytes(1); % byte menor é o primeiro elemento
    
    %% Monta a tabela de bytes altos do tempo baixo
    str = '';
    if v ~= 255
        str = sprintf('%sh,', dec2hex(high_byte,3));
    else
        str = sprintf('%sh', dec2hex(high_byte,3));
    end
    tl_high = strcat(tl_high,str);
    
    %% Monta a tabela de bytes baixos do tempo alto
    str = '';
    if v ~= 255
        str = sprintf('%sh,', dec2hex(low_byte,3));
    else
        str = sprintf('%sh', dec2hex(low_byte,3));
    end
    
    tl_low = strcat(tl_low, str);
end

%% Salva as 4 tabelas em um arquivo .txt
tabelas = fopen('tabelas.txt', 'w');

fprintf(tabelas,'%s\n\n',th_high);
fprintf(tabelas,'%s\n\n---\n\n',th_low);

fprintf(tabelas,'%s\n\n',tl_high);
fprintf(tabelas,'%s\n',tl_low);

fclose(tabelas);