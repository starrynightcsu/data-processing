% new idea for getting a better data 
function [ output_args ] = Untitled( input_args )


clc
clear

load('ezgain.mat');
sample1=ezgain(105,401:1100); %提取一道数据
ez=sample1;
lenn=size(ez,2);%size(X,1),返回矩阵X的行数；size(X,2),返回矩阵X的列数；

%计算4个数字特征
maxez=max(ez);
minez=min(ez);
meanez=mean(ez);
stdez=std(ez);

time=1:lenn; 

%原始数据EZ分布图
figure(1);
   plot(ez,'*') 
   title('原始数据效果图)');
   ylabel('EZ');
   
% 用EMD降噪,通过水平速度的EMD分解，构建低通滤波 
ss=1;
x=ez(ss,:);
[c,ort,nbits] = emd(x); %经验模态分解
[m,n]=size(c);
%rail_imf8=x-c(1,:)-c(2,:)-c(3,:)-c(4,:)-c(5,:)-c(6,:)-c(7,:)-c(8,:);
rail_imf7=x-c(1,:)-c(2,:)-c(3,:)-c(4,:)-c(5,:)-c(6,:)-c(7,:);
rail_imf6=x-c(1,:)-c(2,:)-c(3,:)-c(4,:)-c(5,:)-c(6,:);
rail_imf5=x-c(1,:)-c(2,:)-c(3,:)-c(4,:)-c(5,:);
rail_imf4=x-c(1,:)-c(2,:)-c(3,:)-c(4,:); 
rail_imf3=x-c(1,:)-c(2,:)-c(3,:); 
rail_imf2=x-c(1,:)-c(2,:); 
rail_imf1=x-c(1,:); 
%通过不同组合选择低通，高通，以及带通
%画出每个IMF分量及剩余分量residual的hht瞬时幅频曲线,瞬时频率曲线
figure(2)
tl=length(sample1);
t2=1:tl;
subplot(m+1,1,1)
plot(t2,sample1)
set(gca,'fontname','times New Roman')
set(gca,'fontsize',14.0)
ylabel(['signal'])
title('EMD')


for i=1:m-1
subplot(m+1,1,i+1);
set(gcf,'color','w')
plot(t2,c(i,:),'k')
set(gca,'fontname','times New Roman')
set(gca,'fontsize',14.0)
ylabel(['imf ',int2str(i)])
end

subplot(m+1,1,m+1);
set(gcf,'color','w')
plot(t2,c(m,:),'k')
set(gca,'fontname','times New Roman')
set(gca,'fontsize',14.0)
ylabel(['r ',int2str(m)])

%计算降噪偏差均方差：变量替换  
%sudu_ifm7=rail_imf8;
sudu_ifm6=rail_imf7;
sudu_ifm5=rail_imf5;
sudu_ifm4=rail_imf4;
sudu_ifm3=rail_imf3;
sudu_ifm2=rail_imf2;
sudu_ifm1=rail_imf1;

%计算降噪折线弯曲度：
ii=1;
     for jj=3:lenn-2; 
            %SN7(ii,jj)=sudu_ifm7(ii,jj-2)-sudu_ifm7(ii,jj+2)-2*(sudu_ifm7(ii,jj-1)-sudu_ifm7(ii,jj+1));
            SN6(ii,jj)=sudu_ifm6(ii,jj-2)-sudu_ifm6(ii,jj+2)-2*(sudu_ifm6(ii,jj-1)-sudu_ifm6(ii,jj+1));
            SN5(ii,jj)=sudu_ifm5(ii,jj-2)-sudu_ifm5(ii,jj+2)-2*(sudu_ifm5(ii,jj-1)-sudu_ifm5(ii,jj+1));
            SN4(ii,jj)=sudu_ifm4(ii,jj-2)-sudu_ifm4(ii,jj+2)-2*(sudu_ifm4(ii,jj-1)-sudu_ifm4(ii,jj+1));
            SN3(ii,jj)=sudu_ifm3(ii,jj-2)-sudu_ifm3(ii,jj+2)-2*(sudu_ifm3(ii,jj-1)-sudu_ifm3(ii,jj+1));
            SN2(ii,jj)=sudu_ifm2(ii,jj-2)-sudu_ifm2(ii,jj+2)-2*(sudu_ifm2(ii,jj-1)-sudu_ifm2(ii,jj+1));
            SN1(ii,jj)=sudu_ifm1(ii,jj-2)-sudu_ifm1(ii,jj+2)-2*(sudu_ifm1(ii,jj-1)-sudu_ifm1(ii,jj+1));
     end
%残差标准差，折线光滑度标准差，目标函数
%Qe7=std(sudu_ifm7-x);
Qe6=std(sudu_ifm6-x);
Qe5=std(sudu_ifm5-x);
Qe4=std(sudu_ifm4-x);
Qe3=std(sudu_ifm3-x);
Qe2=std(sudu_ifm2-x);
Qe1=std(sudu_ifm1-x);

%sn7=std(SN7);
sn6=std(SN6);
sn5=std(SN5);
sn4=std(SN4);
sn3=std(SN3);
sn2=std(SN2);
sn1=std(SN1);

alpha = 0.3;
wfdt1s=alpha*Qe1+(1-alpha)*sn1;
wfdt2s=alpha*Qe2+(1-alpha)*sn2;
wfdt3s=alpha*Qe3+(1-alpha)*sn3;
wfdt4s=alpha*Qe4+(1-alpha)*sn4;
wfdt5s=alpha*Qe5+(1-alpha)*sn5;
wfdt6s=alpha*Qe6+(1-alpha)*sn6;
%wfdt7s=alpha*Qe7+(1-alpha)*sn7;
    
Amse=[Qe1,Qe2,Qe3,Qe4,Qe5,Qe6];
Asmse=[sn1,sn2,sn3,sn4,sn5,sn6];
Aminf=[wfdt1s,wfdt2s,wfdt3s,wfdt4s,wfdt5s,wfdt6s];

WD1='EIMF2';
WD2='EIMF3';
WD3='EIMF4';
WD4='EIMF5';
WD5='EIMF6';
WD6='EIMF7';  
%WD7='EIMF8'; 
%  画算法的3个指标图
tt=1:6;
figure(3)
   plot(tt,Asmse,'b-.') 
  
   set(gca,'xticklabel',{WD1,WD2,WD3,WD4,WD5,WD6});




 

