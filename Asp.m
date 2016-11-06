%从GPRMAX中的out文件中提取数据并且做增益
[Header,Fields]=gprmax('subgrade2dl90m.out')
ez(1:2048,1:1332)=Fields.ez
for i=1:2048
    ezgain(i,1:1332)=ez(i,1:1332)*i.^2;
end

