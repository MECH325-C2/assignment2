%% Determined variables
weight = 50;                % [lbf] weight of jelly-beans 
power = 1*550;              % [ft lbf/s] 1hp, power transferred from motor
r_drum = 12/12;             % [ft] 12 in, radius of drum 

%%
% We only know the motor can output 1hp at the speed it assertained before
% the refurbishment of the system. We thus calculate this from the old
% rotational speed of the drum (30rpm) and the previous 40:1 gearing:
rpm_motor = 30*40;          % [rpm] rotational speed of motor 

%% Assumptions
% assume angle and distance of jelly-beans from side of drum.

r_beans = 7/8*r_drum;       % distance from centre of drum of centroid of jelly-beans 
theta_beans = pi/4;         % [rad] angle from vertical of centroid of jelly-beans 
e = 0.95^2;                 % efficiency of flexible drive elements and bearings

%% Force Calculation
%
power_transmitted = power*e;        % power transmitted to drum 

force = weight * cos(theta_beans);  % [lb] vertical component of force excerted by jelly-beans on drum
moment = r_beans * force;           % [lbf] moment excerted by jelly-beans on drum
omega = power_transmitted/moment;   % [rad/s] angular velocity
rpm = omega * 60/(2*pi);            % [rpm] rotations per minute of drum

ratio = rpm_motor/rpm;              % transmission ratio requiered

disp(['rotational speed of drum ', num2str(rpm), ' rpm, with transmission ratio ', num2str(ratio), ':1']);
