function [times,dists,timesd,curve_d] = plotmoreton(maxtime,hmor);

% maxtime: máximo tiempo a considerar
% hmor: altura donde se toma el perfil de densidad

intervaltime = 5.0; 
time = 0.;
threshold = 0.08;  % umbral para detectar la moreton
nfile = 0;
niter = 1;

while time <= maxtime
    
    
    [coords,dens,currtime,nfile] = getdensline(time,'y',hmor,nfile); %dir x
    %[coords,dens,currtime,nfile] = getdensline(time,'x',hmor,nfile); %dir y
    
    ncoord = max(size(coords));
    densref = dens(ncoord);
    
    for i = ncoord:-1:ncoord/2
        if ((dens(i) - densref)/densref > threshold)
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
%hold on; plot(timesd,curve_d,'--k')

xlabel('Time $t$ [s]','FontSize',fontsize,'FontName',fontname,'Interpreter',interpr)
ylabel('Distance [Mm]','FontSize',fontsize,'FontName',fontname,'Interpreter',interpr)
set(gca,'FontSize',fontsize,'FontName',fontname)

axis([0 200 0 200]); 

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