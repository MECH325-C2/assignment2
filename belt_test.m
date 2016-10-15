function [ output ] = belt_test( width, dN_1, dN_2  )
%% Independent Variables passed to function
w = imput_args(1); % [inches] width of belt
n_1 = input_args(4); % [rpm] angular velocity of driving sprocket
C = input_args(5); % [inches] center distance of sprockets
h = input_args(6); % [hours] expected lifetime
S = input_args(7); % Number of strands
dN_1 = input_args(8); % [in] diameter of driving sprocket
dN_2 = input_args(9); % [in] diameter of driven sprocket


%% Constants
g = 


%% Belt length calculation
ThetaN_1 = pi-2*asin((dN_2-dN_1)/(2*C));
ThetaN_2 = 2*pi-ThetaN_1;
belt_length = sqrt(4*C^2-(dN_2-dN_1)^2)+1/2*(dN_2*ThetaN_2+dN_1*ThetaN_1);

%% Force calculation
Fi % initial tension
Fc % hop tnsion due to centrifugal force

H_transmitted = (F_1 - F_2)V/33000;


%% Belt drive analisys steps
% 1 Find exp(f*phi)from belt-drive geometry and friction
phi = ThetaN_1;

% SUBSTITUTE VALUES FROM table 17-2
gamma = ;
f = ; 
Fa = ;

exp_f_rho=exp(f,rho); % useful quantaty for later calculations.


% 2 From belt geometry and speed find Fc
Fc = w/g*(V/60)^2; 

% 3 Find necessary torque
T = 64025*H_nom*K_s*n_d/n;

% 4 From torque T find the necessary (F_1)a - F_2 = 2T/d
force_difference = 2T/d;

% 5 From Tables 17?2 and 17?4, and Eq. (17?12) determine (F_1)a.
b = ;
F_A = ;
C_P = ;
C_V = ;
F_1a = b*F_A*C_p*C_v;

% 6 Find F2 from (F1)a - [(F1)a - F2]
F2 = F1a-force_difference;

% 7 From Eq. (i) find the necessary initial tension Fi
Fi = (F1a+F2)/2-Fc;

% 8 Check the friction development, f9 , f. Use Eq. (17?7) solved for f9:
fprime = 1/rho * log((F1a-Fc)/(F2-Fc));

% 9 Find the factor of safety from nfs 5 Hay(HnomKs)


