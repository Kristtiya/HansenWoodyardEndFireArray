% Optimization of the Hansen-Woodyard Design
% Based off of S. Koziel, S. Ogurtsov Publication
% Study's goal is to suppress the first sidelobe

%% Parameters
N = 10;
f = 2*10^9;
c = 3*10^8;
lambda = c/f;
k = 2*pi/lambda;
theta = 0:.00001:2*pi;
%% Hansen-Woodyard Array
d = lambda./6
beta = -k.*d - pi./N;
psi = k.*d.*cos(theta)+beta;
AF_n = (1./N).*(sin(N.*psi./2))./(sin(.5.*psi)); %Array Factor
% gain = 1.64.*(cos(cos(theta).*pi.*.5).^2)./(sin(theta).^2); %Gain of a Half-wave dipole
% D = gain.*AF_n./1.64;
figure
polarplot(theta,abs(AF_n));
hold on
legend('d = \lambda/6');
hold off