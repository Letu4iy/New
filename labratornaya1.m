% Часть 1
% 1.1 Обучающая выборка
P=[4.3 2.3 3.6 4.8 2.8 -3.3; 2.2 -4.4 4.3 3.5 0.1 -1.1];
T=[1 0 1 1 1 0];
plotpv(P,T); grid;
% 1.2 Создать сеть
net=newp([-5 5; -5 5],[0 1]);
display(net);
view(net);
% 1.3 Обучение по правилу Розенблата
% 1.3.1 Инициализация весов
net.inputweights{1,1}.initFcn='rands';
net.biases{1}.initFcn='rands';
net=init(net);
IW1=net.IW{1,1};
b1=net.b{1};
IW=net.IW{1,1};
b=net.b{1};
% Отображение обучающей выборки
plotpv(P,T); grid;
plotpc(net.IW{1},net.b{1});
%1.3.2 Алгоритм обучения
passes=50;
for j=1:50
    for i=1:6
        p=P(:,i);
        t=T(:,i);
        IW=net.IW{1,1};
        b=net.b{1};
        A=sim(net,p);
        e=t-A;
        if(~mae(e))
            continue;
        else
            net.IW{1,1}=IW+e*transpose(p);
            net.b{1}=b+e;
        end;
    end;
end;
M1=mae(T - net(P));
% 1.3.3 Изображение границы
figure;
plotpv(P,T); grid;
plotpc(net.IW{1},net.b{1});
%1.4.1 Инициализация весов
net.inputweights{1,1}.initFcn='rands';
net.biases{1}.initFcn='rands';
net=init(net);
net.trainParam.epochs = 50;
net.trainParam.goal = 0.01;
net = train(net,P,T);
IW2=net.IW{1,1};
b2=net.b{1};
P1=rands(2,3);
A1=sim(net,P1);
P2=[P,P1];
T1=[T,A1];
 figure;
 plotpv(P2,T1); grid;
 plotpc(net.IW{1},net.b{1});
