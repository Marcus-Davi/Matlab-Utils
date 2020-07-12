clear;close all;clc
addpath('Lib')

global mleft
global mright
global clientID
global sim


disp('Program started');
% sim=remApi('remoteApi','extApi.h'); % using the header (requires a compiler)
sim=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
sim.simxFinish(-1); % just in case, close all opened connections
clientID=sim.simxStart('127.0.0.1',19999,true,true,5000,5);


if (clientID>-1)
    disp('Connected to remote API server');
    else
    disp('Could not connet to remote API server');
    return
end



[r,mleft] = sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_leftMotor',sim.simx_opmode_blocking);
[r,mright] = sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_rightMotor',sim.simx_opmode_blocking);


    


h_fig = figure;
set(h_fig,'KeyPressFcn',@myfun);


function myfun(~,event)
global clientID
global mleft
global mright
global sim
gain = 5;
%disp(event.Key);
if(strcmp(event.Key,'uparrow'))
    disp('cima')
    sim.simxSetJointTargetVelocity(clientID,mleft,1.0*gain,sim.simx_opmode_blocking);
    sim.simxSetJointTargetVelocity(clientID,mright,1.0*gain,sim.simx_opmode_blocking);
elseif(strcmp(event.Key,'leftarrow'))
    disp('left')
    sim.simxSetJointTargetVelocity(clientID,mleft,-1.0*gain,sim.simx_opmode_blocking);
    sim.simxSetJointTargetVelocity(clientID,mright,1.0*gain,sim.simx_opmode_blocking);
elseif(strcmp(event.Key,'downarrow'))
    disp('baixo')
    sim.simxSetJointTargetVelocity(clientID,mleft,-1.0*gain,sim.simx_opmode_blocking);
    sim.simxSetJointTargetVelocity(clientID,mright,-1.0*gain,sim.simx_opmode_blocking);
elseif(strcmp(event.Key,'rightarrow'))
    disp('right')
    sim.simxSetJointTargetVelocity(clientID,mleft,1.0*gain,sim.simx_opmode_blocking);
    sim.simxSetJointTargetVelocity(clientID,mright,-1.0*gain,sim.simx_opmode_blocking);    
elseif(strcmp(event.Key,'space'))
    disp('pausa')
    sim.simxSetJointTargetVelocity(clientID,mleft,0.0,sim.simx_opmode_blocking);
    sim.simxSetJointTargetVelocity(clientID,mright,0.0,sim.simx_opmode_blocking);
end

end

