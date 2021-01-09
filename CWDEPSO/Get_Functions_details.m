
function [lb,ub,dim,fobj] = Get_Functions_details(F)


switch F
    case 'F1'
        fobj = @F1;
        lb=-100;
        ub=100;
        dim=30;
        
    case 'F2'
        fobj = @F2;
        lb=-10;
        ub=10;
        dim=30;

    case 'F3'
        fobj = @F3;
        lb=-100;
        ub=100;
        dim=30;
        
    case 'F4'
        fobj = @F4;
        lb=-5;
        ub=10;
        dim=30;
        
    case 'F5'
        fobj = @F5;
        lb=-1.28;
        ub=1.28;
        dim=30;
        
    case 'F6'
        fobj = @F6;
        lb=-10;
        ub=10;
        dim=30;
        
    case 'F7'
        fobj = @F7;
        lb=-5.12;
        ub=5.12;
        dim=30;
        
      case 'F8'
        fobj = @F8;
        lb=-32;
        ub=32;
        dim=30;
        
    case 'F9'
        fobj = @F9;
        lb=-10;
        ub=10;
        dim=30;
        
    case 'F10'
        fobj = @F10;
        lb=-10;
        ub=10;
        dim=30;
        
        
    case 'F11'
        fobj = @F11;
        lb=-10;
        ub=10;
        dim=30;
        
        
    case 'F12'
        fobj = @F12;
        lb=-10;
        ub=10;
        dim=30;
        
    case 'F13'
        fobj = @F13;
        lb=-600;
        ub=600;
        dim=30;
        
        
    case 'F14'
        fobj = @F14;
        lb=0;
        ub=1;
        dim=6;     
         
    case 'F15'
        fobj = @F15;
        lb=0;
        ub=10;
        dim=4;            
end

end

% F1

function o = F2(x) %f1

o=x(1)^2+10^6*(sum(x(2:30).^2));


 end


% F2

function o = F3(x) 

sum_1=0;
for i=1:30
  sum_1=sum_1+abs(x(i))^(i+1);
end
o=sum_1;

end

% F3

function o = F4(x)  %f3

sum_1=0;
for i=1:30
    sum_1=sum_1+0.5*i*x(i);
end
o=sum(x.^2)+sum_1^2+sum_1^4;

end

% F4

function o = F5(x)

dim=size(x,2);
o=sum([1:dim].*(x.^4))+rand;
end


function o = F6(x)  
dim=size(x,2);
o=sum(100*(x(2:dim)-(x(1:dim-1).^2)).^2+(x(1:dim-1)-1).^2);
end


function o = F7(x)  
o=sum(x.^2-10*cos(2*pi*x)+10);
end

function o = F8(x)   
dim=size(x,2);
o=-20*exp(-.2*sqrt(sum(x.^2)/dim))-exp(sum(cos(2*pi.*x))/dim)+20+exp(1);
end




function o = F9(x)
dim=size(x,2);
w=1+(x-1)/4;
sum_1=sum(((w(1:dim-1)-1).^2).*(1+(10*((sin(pi*w(1:dim-1)+1)).^2))));
sum_2=(sin(pi*w(1)))^2;
sum_3=((w(dim)-1)^2)*(1+10*((sin(pi*w(dim)))^2));
o=sum_1+sum_2+sum_3;


end



function o = F10(x)

dim=size(x,2);
o=sum(((10^6).^(((1:dim)-1)/(dim-1))).*x(1:dim).^2);


end

function o = F20(x)   %f7
dim=size(x,2);
sum_1=0;
sum_2=0;
temp1=0;
temp2=0;
for i=1:dim
sum_1=sum_1+x(i)^2;
sum_2= sum_2+x(i);
end
temp1 = (abs(sum_1-dim)).^(1/4);
temp2 = (0.5* sum_1+ sum_2)/dim;
o= temp1+ temp2+0.5;

end

% F11

function o = F11(x)  
dim=size(x,2);
tem1=10.^6*((x(1)).^2);
tem2=sum ((x(2:dim)).^2);
o=tem1+tem2;

end



function o = F13(x)   
dim=size(x,2);
sum_1=0;
for i=1:dim
    sum_1=sum_1+x(i)^2;
end
z1=1/4000*sum_1;
z2=1;
for i=1:dim
    z2=z2*cos(x(i)/sqrt(i));
end
o=z1-z2+1;

end



function o = F12(x)
dim=size(x,2);
sum_1 = 0;
sum_2=0;
for i=1:dim
sum_1=sum_1+x(i)^2;
sum_2= sum_2+x(i);
end
o=(abs(sum_1.^2- sum_2.^2)).^(1/2)+(0.5* sum_1+ sum_2)/dim+0.5;


end

% F14

function o = F1(x)

o=sum(x.^2);
end










function o = F14(x) 
aH=[10 3 17 3.5 1.7 8;.05 10 17 .1 8 14;3 3.5 1.7 10 17 8;17 8 .05 10 .1 14];
cH=[1 1.2 3 3.2];
pH=[.1312 .1696 .5569 .0124 .8283 .5886;.2329 .4135 .8307 .3736 .1004 .9991;...
.2348 .1415 .3522 .2883 .3047 .6650;.4047 .8828 .8732 .5743 .1091 .0381];
o=0;
for i=1:4
    o=o-cH(i)*exp(-(sum(aH(i,:).*((x-pH(i,:)).^2))));
end
end










function o = F15(x) 
aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];

o=0;
for i=1:10
    o=o-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
end
end

function o=Ufun(x,a,k,m)
o=k.*((x-a).^m).*(x>a)+k.*((-x-a).^m).*(x<(-a));
end