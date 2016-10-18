%% Chain selection and price metric calculations
% Calculations for chain safety-factors/strength. All part numbers
% refference McMasterCarr parts with corresponding prices. 

%%
% Inputs to chain_test: [ANSI_chain_number, N_1, N_2, n_1, C, h, S, H_nom]

h = (2+2)*4*250*4;          % hours of operation
disp(['Hours of operation: ', num2str(h)]);

%% First stage drive, ~2:1 ratio
chain_length = chain_test([35, 21, 40, 1200, 8, h, 1, 1]);
cost_1 = 14.65;             % driving: 6793K129
cost_1 = cost_1 + 28.13;    % driven: 6793K137
cost_1 = cost_1 + 70.64;    % chain tensioner: 5896K1

cost_per_foot = 3.90;       % chain: 6261K172
cost_1 = cost_1 + ceil(chain_length/12)*cost_per_foot + 0.82; % total cost of chain + link


%% Second stage drive, ~5:1 ratio
chain_length = chain_test([40, 17, 89, 1200/40*21, 22, h, 1, 1]);
cost_2 = 16.08;                 % driving: 6793K148
cost_2 = cost_2 + 57.09*89/60;  % driven: 6793K163, linear scaling from 60 to 89 teeth 
cost_2 = cost_2 + 68.62;        % chain tensioner: 5896K2

cost_per_foot = 4.54;           % chain: 6261K173
cost_2 = cost_2 + ceil(chain_length/12)*cost_per_foot + 0.87; % total cost of chain + link


%% Extra Costs
cost_lubrication = 400;

%% Total cost:
total_cost = cost_1+cost_2+cost_lubrication;
display(total_cost);

