%__________________________________________
% fobj = @YourCostFunction
% dim = number of your variables
% Max_iteration = maximum number of generations
% SearchAgents_no = number of search agents
% lb=[lb1,lb2,...,lbn] where lbn is the lower bound of variable n
% ub=[ub1,ub2,...,ubn] where ubn is the upper bound of variable n
% If all the variables have equal lower bound you can just
% define lb and ub as two single number numbers

%__________________________________________

clear all 
clc

SearchAgents_no=100; % Number of search agents

Function_name='F15'; 
Max_iteration=500; 
 
% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
[Best,Worst,aver,fitness_SD,cg_curve]=CWDEPSO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);

x=1:26:500;
semilogy(x,cg_curve(x),'-r<','linewidth',1.25);
xlabel('Iteration');
ylabel('Best score obtained so far');
grid on


display(['',num2str(Best),'    ',num2str(Worst),'    ',num2str(aver),'    ',num2str(fitness_SD)]);


