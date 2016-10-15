function [  ] = chain_selection( )

% test function variable order:

% ANSI_chain_number, N_1, N_2, n_1, C, h, S, F, dN_1, dN_2

h = (2+2)*4*365*4;


%% First stage drive, 2:1 ratio
chain_length = chain_test([40, 20, 40, 1200, 8, h, 1, 3.46, 6.65]);
% driving: 6793K152
cost_1 = 22.34;
% driven: 6793K161
cost_1 = cost_1 + 46.10;
% chain: 
cost_per_foot = 4.54;
cost_1 = cost_1 + ceil(chain_length/12)*cost_per_foot + 0.87;


%% Second stage drive, 5:1 ratio, parallel drives 2x
chain_length = chain_test([50, 12, 60, 1200/2, 22, h, 1, 2.71, 12.3]);
% driving: 6793K166
cost_2 = 17.85;
% driven: 6793K186
cost_2 = cost_2 + 79.91;
% chain: 
cost_per_foot = 5.98;
cost_2 = cost_2 + ceil(chain_length/12)*cost_per_foot + 1.09;

cost_2 = 2*cost_2; % due to parallel drives

%% Extra Costs
cost_lubrication = 400;

%% Total cost:
total_cost = cost_1+cost_2+cost_lubrication;
display(total_cost);

%% Tutorial values
% ANSI_chain_number = 40;
% N_1 = 21; % number of teeth of driving sprocket
% N_2 = 84; % number of teeth of driven sprcket
% n_1 = 2000; % [rpm] angular velocity of driving sprocket
% C = 20; % [inches] center distance of sprockets
% h = 20000; % [hours] expected lifetime
% S = 4; % Number of strands

end
