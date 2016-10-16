function [ output ] = belt_test( input )
%% For flat belts.
%% Independent Variables passed to function
% 1 -> small pulley
% 2 -> large pulley

D1 =    input(1); % [in] diameter of small pulley
D2 =    input(2); % [in] diameter of large pulley
C =     input(3); % [in] center distance of pulleys

n1 =    input(4); % [rpm] angular velocity of small pulley

b =     input(5); % [in] width of belt
t =     input(6); % [in] thickness of belt

Hnom =  input(7); % [hp] transmitted power
Ks =    input(8); % service factor
nd =    input(9); % design factor, for exigencies

Cp =    input(10); % pulley correction factor (table 17-4, flat belts)
Cv =    input(11); % velocity correction factor (=1 for polyamide belts)

Fa =    input(12); % [lbf/in] manufacturers' allowed tension, allowable tension per unit width at 600 ft/min (table 17-2)
gamma = input(13); % [lbf/in^3] spesific weight (table 17-2)
f =     input(14); % coefficint of friction (table 17-2)

%% Constants
g = 32.17; % [ft/s^2] gravitational acceleration


%% Belt length calculation
ThetaN_1 = pi-2*asin((D2-D1)/(2*C));                                  % [rad] angle of contact for small pulley
ThetaN_2 = 2*pi-ThetaN_1;                                               % [rad] angle of contact for large pulley
belt_length = sqrt(4*C^2-(D2-D1)^2)+1/2*(D2*ThetaN_2+D1*ThetaN_1);  % [in] total belt length 


%% Belt drive analisys steps
% 1. Find exp(f*phi)from belt-drive geometry and friction
phi = ThetaN_1;
% exp_f_phi=exp(f,phi);               % useful quantaty for later calculations.

%%
% 2. From belt geometry and speed find Fc
V = pi*D1*n1/12;                   % [ft/min] belt speed
weight_per_length = 12*gamma*b*t;   % [lbf/ft] weight per foot of belt

Fc = weight_per_length/g*(V/60)^2;  % [lbf] hoop tension due to centrifugal force

% 3. Find necessary torque
T = 63025*Hnom*Ks*nd/n1;            % [lbf in] transmitted torque 

% 4. From torque T find the necessary (F_1)a - F_2 = 2T/d
force_difference = 2*T/D1;           % [lbf] (F_1)a - F_2

% 5. From Tables 17-2 and 17-4 and eq. 17-12, determine F1a.
F1a = b*Fa*Cp*Cv;                   % [lbf] allowable largest belt tension

% 6. Find F2 from (F1)a - [(F1)a - F2]
F2 = F1a-force_difference;          % [lbf] slack side tension in belt

% 7. From Eq. (i) find the necessary initial tension Fi
Fi = (F1a+F2)/2-Fc;                 % [lbf] initial tension

disp(['Initial tension: ', num2str(Fi)]);

% 8. Check the friction development, fprime < f. Use eq. 17-7 solved for fprime:
fprime = 1/phi * log((F1a-Fc)/(F2-Fc)); % developed friction

if (f<fprime)
    disp('DANGER: developed friction ', fprime, ' exceeds allowed friction ', f);
else
    disp(['friction: ', num2str(f)]);
    disp(['developed friction: ', num2str(fprime)]);
end

% 9 Find the factor of safety
Ha = (F1a - F2)*V/33000;            % [hp] transmitted power

nfs = Ha/(Hnom*Ks);                 % safety factor

disp(['allowable power: ', num2str(Ha)]);
disp(['safety factor: ', num2str(nfs)]);

% dip = C^2*w/(96*Fi);              % [in] catenary dip

output = belt_length;



