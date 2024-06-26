%% Define the main function
% Defining the main function that we would like to optimize. For the
% Hansen-Woodyard array, we should focus on changing just the distance
% between elements and determining the ideal progressive phase shift. 
% This means we want to focus on changing the value of d and beta.
% My goal is to try to minimize the backlobe of the main lobe.
%% Parameters:
clear;
lambda = 0.15;      %(m)
k = 2*pi/lambda;    % Wave Number
N = 10;
theta = 0:.1:2*pi; 
mx = lambda/4;
x =  lambda/8:mx/length(theta):mx;
x = x(1:end-1).';
y = 0:.01:2*pi;
%% Functions to find minimum
% Array Factor
AF = @(x,y) sin(N.*(k.*x.*cos(0) + k.*x +y)./2)./ sin(.5.*(k.*x.*cos(0)+ k.*x +y));
% Backlobe of Array Factor
AF_backlobe = @(x,y) sin(N.*(k.*x.*cos(0) + y)./2)./ sin(.5.*(k.*x.*cos(0) +y));

%I want to reduce the backlobe while also making sure to retain the front
%lobe. I need to make a new function that can take this into account. 
%% Symbolic Functions
syms AF_Sym x_sym y_sym
AF_Sym = sin(N.*(k.*x_sym.*cos(0) + y_sym)./2)./ sin(.5.*(k.*x_sym.*cos(0) +y_sym));
%% Perfom Gradient Descent Algorithm
[X,Y] = meshgrid(x,y);
Z = AF_backlobe(X,Y);

%Partial Derivative of functions
Df_x = diff(AF_Sym,x_sym);                 % symbolic expression
Df_y = diff(AF_Sym,y_sym);

%Gradient of Functions
grad_x = matlabFunction(Df_x);      % symbolic --> anonymous function
grad_y = matlabFunction(Df_y);

% Initial Conditions 
x_n(1,1) = lambda/4;                       % initial x position
x_n(1,2) = pi;                       % initial y position
x_n(1,3) = AF_backlobe(x_n(1,1),x_n(1,2));    % initial z position
gamma = 0.001;                        % learning rate


% Algorithm
err_x = 5; err_y = 5;
i = 1;

while err_x > 0.01 || err_y > 0.01
    % Calculate next x,y,z (subtract partial derivs)
    x_n(i+1,1) = x_n(i,1) - gamma*grad_x(x_n(i,1),x_n(i,2)); %x
    x_n(i+1,2) = x_n(i,2) - gamma*grad_y(x_n(i,1),x_n(i,2)); %y
    x_n(i+1,3) = AF_backlobe(x_n(i+1,1),x_n(i+1,2)); %z (from x,y)

    % Update difference between consecutive points
    err_x = abs(x_n(i+1,1) - x_n(i,1));
    err_y = abs(x_n(i+1,2) - x_n(i,2));
   
    % increment i (move to next row)
    i = i + 1;

    % break loop if going too long
    if i > 200
        break
    end
end

fprintf("Reached target in %d iterations\n",length(x_n))
fprintf("Final pt is (x=%1.2f,y=%1.2f,z=%1.2f)\n",x_n(end,1),x_n(end,2),x_n(end,3))
%% Display Figures:

% surf(X,Y,Z), 
% figure
% contourf(X,Y,Z)
% hold on
% title('Contour of Backlobe Gain')
% xlabel('Progressive Phase Shift (radians)')
% ylabel('Distance Between Elements (m)')
% scatter(x_n(1,:),x_n(2,:))
% colorbar;
% hold off