[filename,nxb,nyb,nzb,ndim,xmin,xmax,ymin,ymax,zmin,zmax] = geth5data

[coords,vrble,currtime,fileidx] = getvarline(10,'y',0.1,1,'dens')
plot(coords,vrble)

[varcell,currtime,fileidx] = getvarcell(10,[0.1,0.0],1,'dens')

[vrble,times] = getvartime(0,10,10)


[times,cellvars] = cellvarvstime(0,10,[0.1,0.0],'dens')



slicevarvstime(0,50,'y',0.0,'dens')


[coords,vrble,currtime,fileidx] = getvarline(10,'y',0.1,1,'dens')



[filename,nxb,nyb,nzb,ndim,xmin,xmax,ymin,ymax,zmin,zmax] = geth5data
[coords,vrble,currtime,fileidx] = getvarline(10,'y',2500e5,1,'dens')
plot(coords,vrble)
slicevarvstime(0,220,'y',3500e5,'dens')

h=2800e5;t0=0;t1=50;t2=100;dir='y';
[coords0,dens0,currtime0,fileidx] = getvarline(t0,dir,h,1,'dens'); 
[coords1,dens1,currtime1,fileidx] = getvarline(t1,dir,h,1,'dens'); 
[coords2,dens2,currtime2,fileidx] = getvarline(t2,dir,h,1,'dens');

semilogy(coords0,dens0,'-k'),hold on, semilogy(coords1,dens1,'-r'),  semilogy(coords2,dens2,'-b')

[times1,dists1,timesd,curve_d] = plotmoreton(235,2000.e5);
(1.085e10-1.31e10)/(currtime1-currtime2)

polyfit(times2(40:45),dists2(40:45),1),
format long g

semilogy(coords,vrble,'-r')

plot(times1,dists1,'ok')
 
[coords,vrble,currtime,fileidx] = getvarline(125,'y',2550e5,1,'dens')

[times1,dists1,timesd,curve_d] = plotmoreton(270,1500.e5);
[times2,dists2,timesd,curve_d] = plotmoreton(230,1500.e5);
[times8,dists8,timesd,curve_d] = plotmoreton(290,1500.e5);
[times3,dists3,timesd,curve_d] = plotmoreton(285,1500.e5);

[times4,dists4,timesd,curve_d] = plotmoreton(115,1500.e5);
[times7,dists7,timesd,curve_d] = plotmoreton(165,1500.e5);
[times6,dists6,timesd,curve_d] = plotmoreton(135,1500.e5);
[times5,dists5,timesd,curve_d] = plotmoreton(115,1500.e5);



plot(times1,dists1,'ob')
hold on
plot(times2,dists2,'xb')
plot(times8,dists8,'db')
plot(times3,dists3,'sb')

plot(times4,dists4,'or')
plot(times7,dists7,'xr')
plot(times6,dists6,'dr')
plot(times5,dists5,'sr')



intervaltime = 285/(100-1);
for i = 1:100
    timesd(i) = (i-1)*intervaltime;

    c1 = 15.287; c2 = -108.609; delta = 0.578627;
    curve_d(i) = (c1*(timesd(i))^(delta)+c2)*1e8;
end

hold on; plot(timesd,curve_d,'--k')

polyfit(timesd(50:100),curve_d(50:100),1),

intervaltime = 285/(100-1);
for i = 1:100
    timesd(i) = (i-1)*intervaltime;

    a = 93060885.884105; b = 3157906873.54455;
    curve_d(i) = a*timesd(i)+b;
end
plot(timesd,curve_d,'-k')


[times4,dists4,timesd,curve_d] = plotmoreton(115,1500.e5);
plot(times4,dists4,'db')

polyfit(times4(7:24),dists4(7:24),1),

intervaltime = 115/(100-1);
for i = 1:100
    times(i) = (i-1)*intervaltime;

    a =  7.85847e+07; b = 2.242031e+09;
    curve_1(i) = a*times(i)+b;
end

hold on; plot(times,curve_1,'--b')


[times3,dists3,timesd,curve_d] = plotmoreton(115,1500.e5);
hold on; plot(times3,dists3,'sr')

polyfit(times3(7:24),dists3(7:24),1),

intervaltime = 115/(100-1);
for i = 1:100
    timesd(i) = (i-1)*intervaltime;
    
 a =  48979364; b = 818522432;
    curve_2(i) = a*times(i)+b;
end

hold on; plot(times,curve_2,'--r')

polyfit(timesd(50:100),curve_d(50:100),1),


intervaltime = 115/(100-1);
for i = 1:100
    times(i) = (i-1)*intervaltime;
    
 a =  136411220.464725; b =   -2569135759.81432;
    curve_3(i) = a*times(i)+b;
end

hold on; plot(times,curve_3,'--k')

%para medir la velocidad coronal
[coords1,vrble1,currtime,fileidx] = getvarline(125,'y',2550e5,1,'dens')
[coords2,vrble2,currtime,fileidx] = getvarline(130,'y',2550e5,1,'dens')
[coords3,vrble3,currtime,fileidx] = getvarline(135,'y',2550e5,1,'dens')
%[coords4,vrble4,currtime,fileidx] = getvarline(140,'y',2550e5,1,'dens')
%[coords5,vrble5,currtime,fileidx] = getvarline(145,'y',2550e5,1,'dens')

semilogy(coords1,vrble1,'k')
hold on
semilogy(coords2,vrble2,'r')
semilogy(coords3,vrble3,'b')
%semilogy(coords4,vrble4,'m')
%semilogy(coords5,vrble5,'c')

%para medir el % 
[coords1,vrble1,currtime,fileidx] = getvarline(145,'y',1500e5,1,'dens')
semilogy(coords1,vrble1,'k')

[coords2,vrble2,currtime,fileidx] = getvarline(145,'y',1500e5,1,'dens')
hold on
semilogy(coords2,vrble2,'r')

[coords3,vrble3,currtime,fileidx] = getvarline(145,'y',1500e5,1,'dens')
semilogy(coords3,vrble3,'b')

[coords4,vrble4,currtime,fileidx] = getvarline(145,'y',1500e5,1,'dens')
semilogy(coords4,vrble4,'g')

%para medir el flux rope
[times1,dists1] = plotfluxrope(200,3000e5)
[times2,dists2] = plotfluxrope(200,3000e5)
[times3,dists3] = plotfluxrope(200,3000e5)
[times4,dists4] = plotfluxrope(200,3000e5)

plot(times1,dists1,'xk')
hold on
plot(times2,dists2,'or')
plot(times3,dists3,'db')
plot(times4,dists4,'sm')



[coords1,vrble1,currtime,fileidx] = getvarline(140,'x',1.,1,'dens')
[coords2,vrble2,currtime,fileidx] = getvarline(145,'x',1.,1,'dens')
semilogy(coords1,vrble1,'k')
hold on
semilogy(coords2,vrble2,'r')



%para medir la moreton
[times1,dists1,timesd,curve_d] = plotmoreton(200,1500.e5);  %j 2000 T 1MK
[times2,dists2,timesd,curve_d] = plotmoreton(200,1500.e5);  %j 4000 T 1MK
[times3,dists3,timesd,curve_d] = plotmoreton(150,1500.e5);  %j 9000 T 1MK
[times4,dists4,timesd,curve_d] = plotmoreton(200,1500.e5);  %j 1000 T 10MK
[times5,dists5,timesd,curve_d] = plotmoreton(165,1500.e5);  %j 4000 T 10MK
[times6,dists6,timesd,curve_d] = plotmoreton(165,1500.e5);  %j 2000 T 10MK
[times7,dists7,timesd,curve_d] = plotmoreton(85,1500.e5);  %j 5500 T 5MK
[times8,dists8,timesd,curve_d] = plotmoreton(80,1500.e5);  %j 8000 T 2.5MK

plot(times1,dists1,'or')
hold on
plot(times2,dists2,'xr')
plot(times3,dists3,'dr')
plot(times4,dists4,'sb')
plot(times5,dists5,'xb')
plot(times6,dists6,'ob')


polyfit(times1(30:40),dists1(30:40),1),
