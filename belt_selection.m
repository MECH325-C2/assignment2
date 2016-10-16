function [  ] = belt_selection( )
%%
% Values from example 17-1 in book to confirm correct operation
length = belt_test([6, 18, 96, 1750, 6, 0.13, 15, 1.25, 1.1, 0.70, 1, 100, 0.042, 0.8]);

%length = belt_test([2, 20, 30, 1200, 3, 0.062, 1, 1.25, 1.05, 0.95, 1, 5.2, 0.038, 0.7]);

price = 340+71+4.58*length;

disp(['total price: ', num2str(price)]);