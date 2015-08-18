%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to print the reduced matrices for ROM analysis in Dymola.
% The matrices B and D are extended with the initial conditions.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
clc;

nRom = [5];

load('E:\work\modelica\SimulationResults\linCase900_ssm.mat')

% Extend matrices with initial conditions x0
x0 = 293.15*ones(size(A,1),1);
B_ext = [B A*x0];
D_ext = [D C*x0];

% A = ssmObj.A;
% B = ssmObj.B;
% C = ssmObj.C(1:ssmObj.ny_cont,:);
% D = ssmObj.D(1:ssmObj.ny_cont,:);

sys = ss(A,B_ext,C,D_ext);


for i=1:length(nRom)
    display(['-------- ROM of order ' num2str(nRom(i)) ' -----------------------------------------------'])
    sys_r = reduce(sys,nRom(i));
    strMat{i} = printStateSpace(sys_r, 0);
    display('--- Compact string: A = [],B=[],C=[]')
    display(strMat{i})
end



