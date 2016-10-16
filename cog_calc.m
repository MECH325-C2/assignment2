%% Transmission ratio calculation
% We only know the motor can output 1hp at the speed it maintained before
% the refurbishment of the system. We can thus determine this speed from the old
% rotational speed of the drum (30rpm) and the previous 40:1 gearing:
rpm_motor = 30*40;          % [rpm] rotational speed of motor 

%%
% It is then nessecarry to determine what transmission will allow us to
% keep the jelly-beans and the drum rotating at a speed of 120rpm whilst
% the engine is mainained at the only point at which we know its behaviour.

%% Determined variables
weight = 50;                % [lbf] weight of jelly-beans 
power = 1;                  % [hp] power transferred from motor
r_drum = 12;                % [in] radius of drum 

%% Assumptions
% assume angle and distance of jelly-beans from side of drum.

r_beans = 9/10*r_drum;      % [in] distance from centre of drum of centroid of jelly-beans 
theta_beans = pi/3;         % [rad] angle from vertical of centroid of jelly-beans 
e = 0.95^2;                 % efficiency of flexible drive elements and bearings

%% Force Calculation
% We use the relationship between angular velocity and power to determine
% the desiered rotational speed,
% $\omega = \frac{E}{M}= \frac{E}{rW\sin(\theta)}$
power_transmitted = power*e;                    % [ft lbf/s] power transmitted to drum 

moment = r_beans * weight * sin(theta_beans);   % [lbf in] moment excerted by jelly-beans on drum
omega = power_transmitted*63025/moment;         % [rpm] rotations per minute of drum, where 63025 is constant of conversion. 

ratio = rpm_motor/omega;                        % transmission ratio requiered

disp(['rotational speed of drum ', num2str(omega), ' rpm, with transmission ratio ', num2str(ratio), ':1']);


%%
% We therefore ended up using a 10:1 transmission, that will drive the drum
% at approximatley the desiered 121 rpm speed. 