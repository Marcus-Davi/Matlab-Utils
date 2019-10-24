clc;close all;

if exist('s') %#ok<EXIST> %Testa pra não dar LOCK do arquivo
    fclose(s);
end
clear;

s = serial('/dev/ttyACM0','BaudRate',115200,'Terminator','CR');
fopen(s);

%% Variavel Gráfico
XPOINTS = 200;
VARIABLES = 3;
x = (1:XPOINTS)';
y = zeros(XPOINTS,VARIABLES);

y_angles = y;
position = 1;

%% Sensors Gains
Ts = 1/50;
ACC_GAIN = 0.488e-3 * 9.80665;
GYR_GAIN = 15.625e-3 * pi/180.0;
MAG_GAIN = 0.1;

%% Leitura

figure

grid on
flushinput(s)
while(1)
    leitura = fscanf(s,'%d %d %d %d %d %d %d %d %d');
    
    ACC = leitura(1:3) * ACC_GAIN;
    GYR = leitura(4:6) * GYR_GAIN;
    MAG = leitura(7:9) * MAG_GAIN;
    
    PLOT = ACC;
%     PLOT = GYR * GYR_GAIN;
%     PLOT = MAG * MAG_GAIN;
    
    y(position,1) = PLOT(1);
    y(position,2) = PLOT(2);
    y(position,3) = PLOT(3);
    
    %ANGLES COMPUTATION
    a_p = getAccPitch(ACC);
    a_r = getAccRoll(ACC);
    
    
    y_angles(position,1) = a_p;
    y_angles(position,1) = a_r;
    
    
    
    position = position + 1;
    if(position == XPOINTS)
        position = 1;
    end
    
%     plot(x,y) 
    plot(x,y_angles) 
    grid on
    drawnow
    

    
    
    
    

    
end


function pitch = getAccPitch(ACC)
pitch = atan2(-ACC(2),sqrt(ACC(1)*ACC(1) + ACC(3)*ACC(3)));
end

function roll = getAccRoll(ACC)
roll = atan2(-ACC(1),ACC(3));
end

function pitch = getGyrPitch(GYR)
pitch = GYR(2)*Ts

end



function fused = fuse(ACC,GYR)
pitch_acc = getAccPitch(ACC);

end



