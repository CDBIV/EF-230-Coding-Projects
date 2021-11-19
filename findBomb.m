% EF 230 University of Tennessee
% Charles Bailey (cbaile55), Peyton Medley (pmedley2), Sam Dixon
% (sdixon22), Braden Fuller (bfuller7)
% Created: October 21,2021
% Section G3
% Find Bomb
% Objective: Causes the robot to move forward and look for a bomb. Once it 
% finds the bomb it will attempt to defuse the bomb.
% Method: Enter infinite loop for moving forward and detecting color. If
% the robot detects the bomb it will enter its bomb defusal mode where it
% will have a 50/50 chance of defusing the bomb. If it is succesful the
% loop will break. If it fails the robot will run away and then its loop
% will break.
% User Contributuions:
% Charles Bailey - Responsible for conditional statments
% Sam Dixon - Responsible for movement
% Input: Sphero Object (Robot)
% Output: The robot's actions
% Usage: findBomb(s) 
% function findBomb



function findBomb(s) % Main function
s.resetHeading
while 1==1 % Enter Loop
s.setDriveSpeed(60) % Start moving
pause(0.1)
s.getDetectedColor; % Looking for bomb
pause(0.1)
if ans.R <= 30 && ans.G >= 110 && ans.B >= 150 % Parameters for bomb
           disp('I have found the bomb.')
           s.setDriveSpeed(0)
           pause(1)
           disp('I am attempting to defuse the bomb. Please leave the area.')
           pause(1)
           s.setDriveSpeed(-180,180) % Shows that robot is attempting to defuse the bomb
           pause(3)
           defuse = randi(2); % Autogenerates either 1 or 2. If it generates 1 the bomb defusal is succesful
           if defuse == 1 % Bomb defusal is succesful
               s.setDriveSpeed(0)
               pause(.5)
               disp('Bomb defused succesfully!')
               pause(1)
               s.setDriveSpeed(-180,180) % Happy Dance
               pause(3)
               s.setDriveSpeed(0)      
               break % End infinite loop
           else % Bomb defusal is not succesful
               s.setDriveSpeed(0)
               pause(.5)
               disp('Bomb defusal failed! RUN!') 
               pause(1)
               s.setDriveSpeed(80) % Robot begins moving away from the bomb
               pause(3)
               s.setDriveSpeed(0)
               break % End infinite loop
           end
    end
end
end