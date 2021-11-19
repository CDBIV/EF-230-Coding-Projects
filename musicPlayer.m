% EF 230 University of Tennessee
% Charles Bailey (cbaile55), Peyton Medley (pmedley2), Sam Dixon
% (sdixon22), Braden Fuller (bfuller7)
% Created: October 26,2021
% Section G3
% Music Player
% Objective: Turns the robot into an instrument that can be played forever.
% Method: Define notes, enter infinte loop, set conditionals for colors, set
% unique notes to play for each color if conditional is true
% User Contributions:
% Charles Bailey - Responsible for conditional statments
% Braden Fuller - Responsible for notes in musicPlayer
% Input: Sphero Object (Robot), presented colors
% Output: The robot's actions
% Usage: musicPlayer(s) 
% function musicPlayer




function musicPlayer(s)
 % from https://uk.mathworks.com/matlabcentral/answers/48717-create-a-piece-of-music-using-matlab
 Fs=4000;
 Ts=1/Fs;
 t=0:Ts:1;

 F_A=440; %Frequency of note A 
 A=sin(2*pi*F_A*t); 

 F_B=493.88; %Frequency of note B 
 B=sin(2*pi*F_B*t);

 F_Db=554.37; %Frequency of note Db
 Db=sin(2*pi*F_Db*t);
 
 F_E=587.33; %Frequency of note E
 E=sin(2*pi*F_E*t);

while 1==1
    s.getDetectedColor;
    pause(0.1)
if ans.R <= 30 && ans.G >= 110 && ans.B >= 150 % Parameters for color blue
    s.setDriveSpeed(0)
    pause(0.1)
    sound(A,Fs) % Play A note
    disp('blue detected')
    pause(1)
elseif ans.R >= 220 && ans.G >= 200 && ans.B <= 90 % Parameters for color yellow
    s.setDriveSpeed(0)
    pause(0.1)
    sound(Db,Fs) % Play Db note
    disp('yellow detected')
    pause(1)
elseif ans.R >= 230 && ans.G <= 80 && ans.B <= 90 % Parameters for color red
    s.setDriveSpeed(0)
    pause(0.1)
    sound(E,Fs) % Play E note
    disp('red detected')
    pause(1)
end
end
end



