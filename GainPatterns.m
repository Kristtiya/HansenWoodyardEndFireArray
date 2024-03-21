%% Parameters
N = 10;
f = 2*10^9;
c = 3*10^8;
lambda = c/f;
k = 2*pi/lambda;
theta = 0:.00001:2*pi;
%% Hansen-Woodyard Array
d = [(lambda./4),lambda./2,lambda,lambda./6];
beta = -k.*d - pi./N;
psi1 = k.*d(1).*cos(theta)+beta(1);
psi2 = k.*d(2).*cos(theta)+beta(2);
psi3 = k.*d(3).*cos(theta)+beta(3);
psi4 = k.*d(4).*cos(theta)+beta(4);
AF_n1 = (1./N).*(sin(N.*psi1./2))./(sin(.5.*psi1)); %Array Factor
AF_n2 = (1./N).*(sin(N.*psi2./2))./(sin(.5.*psi2)); %Array Factor
% AF_n3 = (1./N).*(sin(N.*psi3./2))./(sin(.5.*psi3)); %Array Factor
AF_n4 = (1./N).*(sin(N.*psi4./2))./(sin(.5.*psi4)); %Array Factor
% gain = 1.64.*(cos(cos(theta).*pi.*.5).^2)./(sin(theta).^2); %Gain of a Half-wave dipole
% D = gain.*AF_n./1.64;
figure
polarplot(theta,abs(AF_n4));
hold on
polarplot(theta,abs(AF_n1));
polarplot(theta,abs(AF_n2));
% polarplot(theta,abs(AF_n3))
legend('d = \lambda/6','d = \lambda/4','d = \lambda/2');
title('Array Factor as Distance between Elements Increases');
hold off
f = 2*10^9;
c = 3*10^8;
lam = c/f;
k = 2*pi/lam;
theta = 0:.00001:2*pi;
% 