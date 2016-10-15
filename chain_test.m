function [ output ] = chain_test( input_args )
%% Independent Variables passed to function
ANSI_chain_number = input_args(1);
N_1 = input_args(2); % number of teeth of driving sprocket
N_2 = input_args(3); % number of teeth of driven sprcket
n_1 = input_args(4); % [rpm] angular velocity of driving sprocket
C = input_args(5); % [inches] center distance of sprockets
h = input_args(6); % [hours] expected lifetime
S = input_args(7); % Number of strands
dN_1 = input_args(8); % [in] diameter of driving sprocket
dN_2 = input_args(9); % [in] diameter of driven sprocket

%% Force calculation
pound_force_constant = 126050.715; % [lb/rot] = [hp]/(pi/[min]/[in] 
F = pound_force_constant*h/n_1/dN_1; % force applied to driving sprocket

%% Tables And Formulas
% Table 17-19 Dimensions of American Standard Roller Chains Single Strand page 908
T17_19 =   [25  0.250 0.125 780    0.09  0.130 0.252;
            35  0.375 0.188 1760   0.21  0.200 0.399;
            41  0.500 0.25  1500   0.25  0.306 -1;
            40  0.500 0.312 3130   0.42  0.312 0.566;
            50  0.625 0.375 4880   0.69  0.400 0.713;
            60  0.750 0.500 7030   1.00  0.469 0.897;
            80  1.000 0.625 12500  1.71  0.625 1.153;
            100 1.250 0.750 19500  2.58  0.750 1.409;
            120 1.500 1.000 28000  3.87  0.875 1.789;
            140 1.750 1.000 38000  4.95  1.000 1.924;
            160 2.000 1.250 50000  6.61  1.125 2.305;
            180 2.250 1.406 63000  9.06  1.406 2.592;
            200 2.500 1.500 78000  10.96 1.562 2.817;
            240 3.00  1.875 112000 16.4  1.875 3.458];
        
% Table 17-20 Tabulated lubrication type for 17 tooth sprocket
% 0 - type A; 1 - type B; 2 - type C; 3 - type C'
keySet = [0 1 2 3];
valueSet =   {'type A', 'type B', 'type C', 'type C'};
T17_20_Lubrication = containers.Map(keySet,valueSet);
T17_20 = [-1	25	35	40	41	50	60	80	100	120	140	160	180	200	240
            50	0	0	0	0	0	0	0	0	0	1	1	1	1	1
            100	0	0	0	0	0	0	0	1	1	1	1	1	1	1
            150	0	0	0	0	0	0	1	1	1	1	1	1	1	1
            200	0	0	0	0	0	0	1	1	1	1	1	1	1	3
            300	0	0	0	0	1	1	1	1	1	1	1	2	3	3
            400	0	0	1	1	1	1	1	1	1	1	1	2	3	3
            500	0	0	1	1	1	1	1	1	1	2	2	3	3	-1
            600	0	0	1	1	1	1	1	1	2	2	2	3	3	-1
            700	0	1	1	1	1	1	1	1	2	2	2	3	-1	-1
            800	0	1	1	1	1	1	1	2	2	2	3	3	-1	-1
            900	0	1	1	1	1	1	1	2	2	2	3	3	-1	-1
        1000	0	1	1	1	1	1	2	2	2	2	3	3	-1	-1
        1200	0	1	1	1	1	1	2	2	2	3	3	-1	-1	-1
        1400	0	1	1	1	1	1	2	2	2	3	-1	-1	-1	-1
        1600	0	1	1	1	1	1	2	2	3	-1	-1	-1	-1	-1
        1800	1	1	1	1	1	2	2	3	3	-1	-1	-1	-1	-1
        2000	1	1	1	1	1	2	2	3	-1	-1	-1	-1	-1	-1
        2500	1	1	1	1	2	2	2	3	-1	-1	-1	-1	-1	-1
        3000	1	1	1	1	2	2	3	-1	-1	-1	-1	-1	-1	-1];


% Table 17-22 Tooth Correction Factor K1 page 913
K_1 = @(N,isPostExtreme) isPostExtreme*(N/17)^1.5 + ~isPostExtreme*(N/17)^1.08;
% where N = Number of Teeth on Driving Sprocket

% Table 17-23 Multiple Strand Factor K2 page 913
T17_23 = [  1 1.0;
            2 1.7;
            3 2.5;
            4 3.3;
            5 3.9;
            6 4.6;
            8 6.0];

% Eqn 17-32 Link-Plate Limited (Post Extreme) Nominal Power for All Cases page 911
H_1 = @(N_1, n_1, p, a) 0.004^(a~=41) * 0.0022^(a==41) * N_1^1.08 * n_1^.9 * p^(3-.07*p); % [hp]
% where N_1 = number of teeth in the smaller sprocket
% n_1 = sprocket speed, rev/min
% p = pitch of the chain, in
% a = ANSI chain number

% Eqn 17-33 Link-Plate (Pre Extreme) Limited Nominal Power for Magic 17 tooth Case page 911
K_r = @(a) 29*(a==25) + 29*(a==35) + 3.4*(a==41) + 17*(a>=40)*(a~=41);
H_2_17 = @(ANSI_chain_number, N_1, n_1, p) (1000 * K_r(ANSI_chain_number)  * N_1^1.5 * p^.8) / n_1^1.5; % [hp]
% where N_1 = number of teeth in the smaller sprocket
% n_1 = sprocket speed, rev/min
% p = pitch of the chain, in

% Eqn 17-19 Link-Plate (Pre Extreme) Limited Nominal Power for All Other Cases page 914
H_2 = @(ANSI_chain_number, N_1, n_1, p, L_p, h) 1000*(K_r(ANSI_chain_number)*((N_1)/(n_1))^1.5*p^.8*(L_p/100)^.4*(15000/h)); % [hp]
% where N_1 = number of teeth in the smaller sprocket
% n_1 = sprocket speed, rev/min
% p = pitch of the chain, in
% h = lifetime, hours
% L_p = number of pitches


%% Dependent Variables Table Lookups
% Table 17_19 for ANSI Chain Number
for i=1:length(T17_19(:,1))
    if (T17_19(i,1)==ANSI_chain_number)
        pitch = T17_19(i,2); % [inches] chain
        width = T17_19(i,3); % [inches] chain
        minimum_tensile_strength = T17_19(i,4); % [lbf] chain
        average_weight = T17_19(i,5); % [lbf/ft] chain
        roller_diameter = T17_19(i,6); % [inches] chain
        multiple_strand_spacing = T17_19(i,7); % [inches] chain
        break
    end    
end

% Table 17_23 for Multiple Strand Factor K2
for i=1:length(T17_23(:,1))
    if (T17_23(i,1)==S)
        K_2 = T17_23(i,2);
        break
    end    
end

% Table 17_20 Lubrication Type
for i=1:length(T17_20(1,:))
    a = T17_20(1,i);
    if (a==ANSI_chain_number)
       for j= length(T17_20(:,1)):-1:1
           b = T17_20(j,1);
           if (b<n_1)
               lubrication_type = T17_20(j,i);
               break;
           end
       end
    end
end

%% Calculations

L_p = ceil(2*C/pitch+(N_1+N_2)/2+(N_1-N_2)^2/(4*pi^2*C/pitch)); % number of pitches
L = L_p*pitch; % [inches] chain length

[H_tab,isPostExtreme] = min([H_1(17,n_1,pitch,ANSI_chain_number),H_2_17(ANSI_chain_number,17,n_1,pitch)]); % [hp] Tabulated horsepower for magic case 17
isPostExtreme = isPostExtreme-1; % boolean isPostExtreme
constant = H_tab^2.5*15000/100/(17^3.75^0); % eqn 17-40 Some Magic Constant
% SOMEONE ASK MIKELSON ABOUT 17^3.75 ???
if N_1~=17
    H_tab_prime = (constant*L_p/h)^(1/2.5); % [hp] Normalized Tabulated Horsepower
    [~,isPostExtreme] = min([H_1(N_1,n_1,pitch,ANSI_chain_number),H_2(ANSI_chain_number,N_1,n_1,pitch,L_p,h)]); % [int] integer [1 2] isPostExreme for our case
    isPostExtreme = isPostExtreme-1; % boolean isPostExtreme
    % FOR SOME REASON WE USED PRE-EXTREME IN TUTORIAL EVEN THOUGH WE GET POST WHY ???
else
    H_tab_prime = H_tab;
end

H_allowable = H_tab_prime*K_1(N_1,isPostExtreme)*(K_2^(N_1~=17)); % [hp] Allowable Horsepower
F_allowable = H_allowable*33000*12/N_1/pitch/2000; % [lbf] Allowable max force
n_allowable = 1000*(82.5/(7.95^pitch*1.0278^N_1*1.323^(F/1000)))^(1/(1.59*log(pitch+1.873))); % [rev/min] Maximum allowable rotational speed on driving sprocket

display(H_allowable)
display(life_allowable)
display(n_allowable)
display(['Lubrication type only if N_1=17 : ' T17_20_Lubrication(lubrication_type)])

output = chain_length;

end