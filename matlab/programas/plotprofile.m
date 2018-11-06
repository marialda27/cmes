
function plotprofile(xcoords,dens)

filenameout = 'perfil_100c.pdf';

figure;
[wp,hp,xpos,ypos,wbox,hbox,fontsize,fontname,interpr] = papel1x1;
axes('Units','centimeters','Position',[xpos ypos wbox hbox]);

plot(xcoords,dens,'-b')

xlabel('$x$ [cm]','FontSize',fontsize,'FontName',fontname,'Interpreter',interpr)
ylabel('$\rho$ [g$\,$cm$^{{-}3}$]','FontSize',fontsize,'FontName',fontname,'Interpreter',interpr)
set(gca,'FontSize',fontsize,'FontName',fontname)

axis([0 2e10 0 0.50e-12]); % cromosfera
%axis([0 2e10 0 1.0e-15]); % interfaz

set(gcf, 'renderer', 'painters');
print(gcf, '-dpdf', filenameout);


 
    function [wp,hp,xpos,ypos,wbox,hbox,fontsize,fontname,interpr] = papel1x1

        % Establecer las propiedades del papel para graficar


        wp = 6.5 ; hp = 5.6;        % Dimensiones del papel: wp ancho, hp alto
        xpos = 1.1; ypos = 1.0;     % Posición del box
        wbox = 5.; hbox = 4.0;     % Dimensiones del box

        fontsize = 8;
        fontname = 'Times';
        interpr  = 'latex';


        set(gcf, 'PaperUnits', 'centimeters');
            set(gcf, 'PaperSize', [wp hp]);
            set(gcf, 'PaperPositionMode', 'manual');
            set(gcf, 'PaperPosition', [0 0 wp hp]);

    end


end