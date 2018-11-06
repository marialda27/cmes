function [times,dists,timesd,curve_d] = plotmoreton2(maxtime,hbeg,hend);

% maxtime: máximo tiempo a considerar
% hend-hbeg : franja donde se observa la Moreton

%%% SÓLO VÁLIDO PARA MALLA UNIFORME %%%


if hbeg > hend;
    disp('Error: hend debe ser mayor que hbeg')
    times = 0; dists = 0; timesd = 0; curve_d = 0;
    return
end

intervaltime = 5.0; 
time = 0.;
threshold = 0.08;  % umbral para detectar la moreton
nfile = 0;
niter = 1;

[coordsY,dens,currtime,nfile] = getdensline(0,'x',0,0);
dy = coordsY(2) - coordsY(1);
[dum,jbeg] = min(abs(coordsY-hbeg)); 
[dum,jend] = min(abs(coordsY-hend));

nintcells = 0.5+(coordsY(jbeg)-hbeg)/dy + 0.5+(hend-coordsY(jend))/dy + jend-jbeg-2;
       % Número de celdas a lo largo de donde se integra la densidad en la cromósfera

[coords,dens,currtime,nfile] = getdensline(0,'y',0,0);
nxcells = max(size(coords));

clear dens
dens = zeros(nxcells,jend-jbeg+1);
intdens = zeros(nxcells,1);


while time <= maxtime
        
    for jh = 1:jend-jbeg+1
        [coords,dens(:,jh),currtime,nfile] = getdensline(time,'y',hbeg+dy*(jh-1),nfile);
    end
    
    for i = 1:nxcells
        intdens(i) = sum(dens(i,2:jend-jbeg));
        intdens(i) = intdens(i) + dens(i,1)*(0.5+(coordsY(jbeg)-hbeg)/dy);
        intdens(i) = intdens(i) + dens(i,jend-jbeg+1)*(0.5+(hend-coordsY(jend))/dy);
    end
    intdens = intdens/(nintcells);
    
    ncoord = max(size(coords));
    densref = intdens(ncoord);
    if (niter <= 1) densref0 = densref; end
    
    
    for i = ncoord:-1:1
        if ((intdens(i) - densref)/densref0 > threshold)
            times(niter) = currtime;
            dists(niter) = coords(i);
            break        
        end
    end
    
    niter = niter + 1;
    nfile = nfile + 1;
    time = time + intervaltime; 
end

intervaltime = max(times)/(100-1);
for i = 1:100
    timesd(i) = (i-1)*intervaltime;

    c1 = 15.287; c2 = -108.609; delta = 0.578627;
    curve_d(i) = c1*(timesd(i))^(delta)+c2;
end



filenameout = 'moretonCME.pdf';

figure;
[wp,hp,xpos,ypos,wbox,hbox,fontsize,fontname,interpr] = papel1x1rect;
axes('Units','centimeters','Position',[xpos ypos wbox hbox]);

plot(times,dists/(1.e2*1.e6),'ob'), % dists en Mm
hold on; plot(timesd,curve_d,'--k')

xlabel('Time $t$ [s]','FontSize',fontsize,'FontName',fontname,'Interpreter',interpr)
ylabel('Distance [Mm]','FontSize',fontsize,'FontName',fontname,'Interpreter',interpr)
set(gca,'FontSize',fontsize,'FontName',fontname)

axis([0 200 0 250]); 

set(gcf, 'renderer', 'painters');
print(gcf, '-dpdf', filenameout);



    function [wp,hp,xpos,ypos,wbox,hbox,fontsize,fontname,interpr] = papel1x1rect

        % Establecer las propiedades del papel para graficar


        wp = 8.5 ; hp = 7.0;        % Dimensiones del papel: wp ancho, hp alto
        xpos = 1.0; ypos = 1.0;     % Posición del box
        wbox = 7.0; hbox = 5.5;     % Dimensiones del box

        fontsize = 8;
        fontname = 'Times';
        interpr  = 'latex';


        set(gcf, 'PaperUnits', 'centimeters');
            set(gcf, 'PaperSize', [wp hp]);
            set(gcf, 'PaperPositionMode', 'manual');
            set(gcf, 'PaperPosition', [0 0 wp hp]);

    end
end