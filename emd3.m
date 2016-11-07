clc
clear
load ezgain  %��ȡ����ģ������
sample1=ezgain(105,401:1100); %��ȡһ������
[c,ort,nbits] = emd(sample1); %����ģ̬�ֽ� 
%c����ģ̬���� ort����ָ�� nobitsÿ�����к����������� ��ort���0.03���£�
eIMF= eemd(sample1,0.2,9) %�����зֽ⣬��һ����ԭʼ���ݡ������һ������
[m,n]=size(c);
%rail_imf8=sample1-c(1,:)-c(2,:)-c(3,:)-c(4,:)-c(5,:)-c(6,:)-c(7,:)-c(8,:);
rail_imf7=sample1-c(1,:)-c(2,:)-c(3,:)-c(4,:)-c(5,:)-c(6,:)-c(7,:);
rail_imf6=sample1-c(1,:)-c(2,:)-c(3,:)-c(4,:)-c(5,:)-c(6,:);
rail_imf5=sample1-c(1,:)-c(2,:)-c(3,:)-c(4,:)-c(5,:);
rail_imf4=sample1-c(1,:)-c(2,:)-c(3,:)-c(4,:); 
rail_imf3=sample1-c(1,:)-c(2,:)-c(3,:); 
rail_imf2=sample1-c(1,:)-c(2,:); 
rail_imf1=sample1-c(1,:); 
%����ÿ��IMF������ʣ�����residual��hht˲ʱ��Ƶ����,˲ʱƵ������
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

%IMF��HHT�任 
[A,fa,tt]=hhspectrum(c(1:end-1,:)); %A��ֵ��fƵ�ʣ�tt����         
figure(3);
subplot(1,2,1);
plot(fa(1,:));ylabel('Ƶ��(Hz)');xlabel('ʱ��(ms)');title('IMF1ʱ��-Ƶ����������');
subplot(1,2,2);
plot(A(1,:)');ylabel('��ֵ(v)');xlabel('ʱ��(ms)');title('IMF1ʱ��-��ֵ��������');

figure(4);
subplot(2,1,1);
plot(fa(2,:));ylabel('Ƶ��(Hz)');xlabel('ʱ��(ms)');title('IMF2ʱ��-Ƶ����������');
subplot(2,1,2);
plot(A(2,:)');ylabel('��ֵ(v)');xlabel('ʱ��(ms)');title('IMF2ʱ��-��ֵ��������');gure(3)

