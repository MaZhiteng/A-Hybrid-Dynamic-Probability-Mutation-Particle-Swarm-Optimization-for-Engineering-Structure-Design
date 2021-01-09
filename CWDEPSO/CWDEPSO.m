function  [Best,Worst,aver,fitness_SD,cg_curve]=CWDEPSO(N,Max_iter,lb,ub,dim,fobj)
NN = 20; %运行次数
nb=zeros(NN,Max_iter); %为了计算平均适应度
nb_1=zeros(1,Max_iter);
nb_2=zeros(1,NN);
% aver=0;
fitness_Variance=0;
% fitness_Variance_chu=0;
for ii=1:NN
xx=0;
Vmax=0.2*(ub-lb);
noP=N;
NP=N;
uCR=0.5;
uF=0.5;
D=dim;
% Initializations
iter=Max_iter;
v=zeros(noP,dim);
v1=zeros(noP,dim);
pBestScore=zeros(noP);
pBest=zeros(noP,dim);
gBest=zeros(1,dim);
fitness=zeros(1,NP);
fitnessU=zeros(1,NP);
CR=zeros(noP);
F=zeros(noP);
zuihao=zeros(1,D);
ag_curve=zeros(1,iter);
% Random initialization for agents.
pos=initialization(noP,dim,ub,lb); 
bz1=zeros(NP,1);
u=zeros(NP,D);
zanshi=zeros(NP,D);
for i=1:noP
    pBestScore(i)=inf;
end

% Initialize gBestScore for a minimization problem
 gBestScore=inf;
     for i=1:size(pos,1)     
        %Calculate objective function for each particle
        fitness(i)=fobj(pos(i,:));  

        if(pBestScore(i)>fitness(i))
            pBestScore(i)=fitness(i);
            pBest(i,:)=pos(i,:);
        end
        if(gBestScore>fitness(i))
            gBestScore=fitness(i);
            gBest=pos(i,:);
        end
     end   
    gBestScore1=gBestScore;
 mm2=rand();
    while(mm2==0.25)||(mm2==0.5)||(mm2==0.75)
        mm2=rand();  
    mm2=4*mm2.*(1-mm2);
    end   
    mm1=rand();
    while(mm1==0.25)||(mm1==0.5)||(mm1==0.75)
        mm1=rand();  
    mm1=4*mm1.*(1-mm1);
    end  
%%-----------
for l=1:iter
        mm1=4*mm1*(1-mm1);
        mm2=4*mm2*(1-mm2);
        if rand<0.5
            x1=1;
        else x1=-1;
        end
    c1=-2*sin((l/iter)*pi/2)+2.5;
    c2=2*sin((l/iter)*pi/2)+0.5;
     Scr=[];%初始成功参加变异的个体的交叉概率为空集
     Sf=[];%初始成功参加变异的个体的缩放因子为空集
     n1=1;%记录Scr中的元素个数
     n2=1;%记录Sf中的元素  
        for i=1:NP
            %对第G代的每个个体计算交叉概率和缩放因子
            CR(i)=normrnd(uCR,0.1);%服从正态分布
            F(i)=cauchyrnd(uF,0.1);%服从柯西分布
            while (CR(i)>1||CR(i)<0)
                CR(i)=normrnd(uCR,0.1);
            end
            if (F(i)>1)
                F(i)=1;
            end
            while (F(i)<=0)
                F(i)=cauchyrnd(uF,0.1);
            end
        end
if bz1>1
    xx=xx+1;
end
if rand<1/(exp((iter-10*xx)/iter))
    bz=1;
else bz=0;
end
    %Update the W of PSO
     w=0.65+0.9*atan(-1+2*(iter-l)/iter)/pi+0.05*x1*mm2;
 w1=0.8+0.2*(l/iter);

    w2=0.2*(l/iter);
    %Update the Velocity and Position of particles
    for i=1:size(pos,1)
        for j=1:size(pos,2)        
             v(i,j)=w*v(i,j)+c1*rand()*(pBest(i,j)-pos(i,j))+c2*rand()*(gBest(j)-pos(i,j));         
            if(v(i,j)>Vmax)
                v(i,j)=Vmax;
            end
            if(v(i,j)<-Vmax)
                v(i,j)=-Vmax;
            end            
        end
        pos(i,:)=pos(i,:)+v(i,:);            
    end

        for i=1:NP
           if bz1(i)>=100
               if rand<0.01
               pos(i,:)=lb+(ub-lb)*rand;
               end
           end
           if bz>=1
            r1=randi([1,NP],1,1);
            while (r1==i)
                r1=randi([1,NP],1,1);
            end
            r2=randi([1,NP],1,1);
            while(r2==r1)||(r2==i)
                r2=randi([1,NP],1,1);
            end
 
            r3=randi([1,NP],1,1);
            while (r3==i)||(r3==r2)||(r3==r1)
                r3=randi([1,NP],1,1);
            end
            v1(i,:)=w1*pos(i,:)+F(i)*(gBest-pos(i,:))+(0.1+w2)*(pos(r1,:)-pos(r2,:));
            if(v1(i,:)>Vmax)
                v1(i,:)=Vmax;
            end
            if(v1(i,:)<-Vmax)
                v1(i,:)=-Vmax;
            end  
            jrand=randi([1,D]);
            for j=1:D
                k3=rand;
                if(k3<=CR(i)||j==jrand)
                    u(i,j)=v1(i,j);
                else
                    u(i,j)=pos(i,j);
                end
                %边界处理
                if u(i,j)<lb
                  u(i,j)=lb;
                end
                if u(i,j)>ub
                  u(i,j)=ub;
                end
            end   
           end
    end
    %更新pos
    for i=1:NP
        if bz>=1
        fitnessU(i)=fobj(u(i,:));
        fitness(i)=fobj(pos(i,:));
        if fitnessU(i)< fitness(i)
            zanshi(i,:)=pos(i,:);
            zuihao(i)=  fitness(i);
            fitness(i)=fitnessU(i);
            pos(i,:)=u(i,:);
            Scr(n1)=CR(i);
            Sf(n2)=F(i);
            n1=n1+1;
            n2=n2+1;
           
        else
            zanshi(i,:)=u(i,:);
            pos(i,:)=pos(i,:);
            zuihao(i)= fitnessU(i);
        end  
        end
    end  
    if bz>=1   
          [~,zuih]=sort(zuihao);

             if zuihao(zuih(1))<fitness(zuih(NP))
                 pos(zuih(NP),:)=zanshi(zuih(1),:);
             end
    end
    for i=1:size(pos,1)     
        %Calculate objective function for each particle

        if(pBestScore(i)>fitness(i))
            pBestScore(i)=fitness(i);
            pBest(i,:)=pos(i,:);
        end
        if(gBestScore>fitness(i))
            gBestScore=fitness(i);
            gBest=pos(i,:);
             bz1(i)=0;
        else bz1(i)=bz1(i)+1;
        end
    end
          c=0.1;
        [~,ab]=size(Scr);
        if ab~=0
            newSf=(sum(Sf.^2))/(sum(Sf));
            newScr=((sum(Scr.^2))/(ab))^(1/2);
            uCR=(1-c)*uCR+c.*newScr;

            uF=(1-c)*uF+c.*newSf;
        end 
    ag_curve(l)=gBestScore;
    if l==500

    end
   ag_curve(1)= gBestScore1;
end   
  nb(ii,:)=ag_curve;
  nb_2(1,ii)=gBestScore;
end
 cg_curve=mean(nb,1);
 
  
%%
Best=min(nb_2);  %寻优最佳值
Worst=max(nb_2);   %寻优最差值
for i=1:Max_iter
 nb_1(1,i)=sum(nb(:,i))/NN;
end
aver = sum(nb_2(1,:))/NN;  %平均值
if(abs(aver)<10^-100)
   for  b=1:NN
   fitness_Variance= fitness_Variance+(aver*10^200-nb_2(1,b)*10^200)^2; %求p次循环的方差
   end
%     fitness_Variance_chu=fitness_Variance/(NN-1);
    fitness_SD=sqrt(fitness_Variance)/10^200;  
else
    for  b=1:NN
    fitness_Variance= fitness_Variance+(aver-nb_2(1,b))^2;        %求p次循环的方差
    end 
%     fitness_Variance_chu=fitness_Variance/(NN-1);
    fitness_SD=sqrt(fitness_Variance);
end



