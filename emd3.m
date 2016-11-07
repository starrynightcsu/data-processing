clc
clear
load ezgain  %读取地下模型数据
sample1=ezgain(105,401:1100); %提取一道数据
[c,ort,nbits] = emd(sample1); %经验模态分解 
%c固有模态函数 ort正交指数 nobits每个固有函数迭代次数 （ort最好0.03以下）
eIMF= eemd(sample1,0.2,9) %程序按列分解，第一列是原始数据。。最后一列余象
[m,n]=size(c);
%rail_imf8=sample1-c(1,:)-c(2,:)-c(3,:)-c(4,:)-c(5,:)-c(6,:)-c(7,:)-c(8,:);
rail_imf7=sample1-c(1,:)-c(2,:)-c(3,:)-c(4,:)-c(5,:)-c(6,:)-c(7,:);
rail_imf6=sample1-c(1,:)-c(2,:)-c(3,:)-c(4,:)-c(5,:)-c(6,:);
rail_imf5=sample1-c(1,:)-c(2,:)-c(3,:)-c(4,:)-c(5,:);
rail_imf4=sample1-c(1,:)-c(2,:)-c(3,:)-c(4,:); 
rail_imf3=sample1-c(1,:)-c(2,:)-c(3,:); 
rail_imf2=sample1-c(1,:)-c(2,:); 
rail_imf1=sample1-c(1,:); 
%画出每个IMF分量及剩余分量residual的hht瞬时幅频曲线,瞬时频率曲线
figure(1)
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

%IMF的HHT变换 
[A,fa,tt]=hhspectrum(c(1:end-1,:)); %A幅值，f频率，tt长度         
figure(3);
subplot(1,2,1);
plot(fa(1,:));ylabel('频率(Hz)');xlabel('时间(ms)');title('IMF1时间-频率特性曲线');
subplot(1,2,2);
plot(A(1,:)');ylabel('幅值(v)');xlabel('时间(ms)');title('IMF1时间-幅值特性曲线');

figure(4);
subplot(2,1,1);
plot(fa(2,:));ylabel('频率(Hz)');xlabel('时间(ms)');title('IMF2时间-频率特性曲线');
subplot(2,1,2);
plot(A(2,:)');ylabel('幅值(v)');xlabel('时间(ms)');title('IMF2时间-幅值特性曲线');gure(3)

