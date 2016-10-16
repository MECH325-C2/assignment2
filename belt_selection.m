function [  ] = belt_selection( )
%%
% Values from example 17-1 in book to confirm correct operation
% length = belt_test([6, 18, 96, 1750, 6, 0.13, 15, 1.25, 2.5, 0.70, 1, 100, 0.042, 0.8]);

%%
% Possible settup: 6:60 pulleys, 
length = belt_test([6, 60, 30, 1200, 6, 0.266, 1, 1.25, 1.05, 0.6, 1, 41, 0.045, 0.4]);

price = 188/8*60+96+57.88*length;
% part 5706K34 pulleys, 6080K22 2ply leather belt
disp(['total price: ', num2str(price)]); % Price very unreasonable!