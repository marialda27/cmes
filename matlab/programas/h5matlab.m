
%dens= h5read('Columna_hdf5_plt_cnt_0000', '/runtime parameters');
coords= h5read('Columna_hdf5_plt_cnt_0000','/coordinates');
dens0= h5read('Columna_hdf5_chk_0000', '/dens');
info= h5info('Columna_hdf5_plt_cnt_0000');
coords(1:2,:)= coords(1:2,:)/1e9;
% figure(1)
% plot(coords(1,:),coords(2,:), '.')
% legend

info2= h5info('Columna_hdf5_chk_0001');
blockcenter= h5read('Columna_hdf5_chk_0001', '/coordinates');
blocksize= h5read('Columna_hdf5_chk_0001', '/block size');


real_scalars= h5read('Columna_hdf5_chk_0001', '/real scalars');
sim_info= h5read('Columna_hdf5_chk_0001', '/sim info');
fcx1= h5read('Columna_hdf5_chk_0001', '/fcx1');
fcx2= h5read('Columna_hdf5_chk_0001', '/fcx2');
fcy1= h5read('Columna_hdf5_chk_0001', '/fcy1');
fcy2= h5read('Columna_hdf5_chk_0001', '/fcy2');
string_scalars= h5read('Columna_hdf5_chk_0001', '/string scalars');
xcoord= -blocksize(1)/2+blockcenter(1): blocksize(1)/size(dens0,1):blocksize(1)/2+blockcenter(1);
%ycoord= -blocksize(2)/2+blockcenter(2): blocksize(2)/size(dens0,1):blocksize(2)/2+blockcenter(2);
ycoord=50:100:950;

%% valores de densidad en función del tiempo
dens0= h5read('Columna_hdf5_chk_0000', '/dens');
dens1= h5read('Columna_hdf5_chk_0001', '/dens');
dens2= h5read('Columna_hdf5_chk_0002', '/dens');
% dens3= h5read('Columna_hdf5_chk_0003', '/dens');
% dens4= h5read('Columna_hdf5_chk_0004', '/dens');
dens5= h5read('Columna_hdf5_chk_0005', '/dens');
dens10= h5read('Columna_hdf5_chk_0010', '/dens');
dens20= h5read('Columna_hdf5_chk_0020', '/dens');

time1= h5read('Columna_hdf5_chk_0001', '/real scalars',1,1);
time1=time1.value;
time2= h5read('Columna_hdf5_chk_0002', '/real scalars',1,1);
time2=time2.value;
time5= h5read('Columna_hdf5_chk_0005', '/real scalars',1,1);
time5=time5.value;
time10= h5read('Columna_hdf5_chk_0010', '/real scalars',1,1);
time10=time10.value;
time20= h5read('Columna_hdf5_chk_0020', '/real scalars',1,1);
time20=time20.value;
leg=[num2str(time1,'%10.5e'); num2str(time2,'%10.5e'); num2str(time5,'%10.5e');num2str(time10,'%10.5e');num2str(time20,'%10.5e')];

figure(2)
plot(ycoord, dens0(1,:),ycoord, dens1(1,:),...
    ycoord, dens5(1,:),ycoord, dens10(1,:),ycoord, dens20(1,:)) 
%legend (str(time1); str(time2); str(time5);str(time10);str(time20))
legend (leg)