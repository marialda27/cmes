function [times,cellvars] = cellvarvstime(tinit,tfinal,point,variable)

% tinit: tiempo inicial
% tfinal: tiempo final
% variable: variable ('dens','pres','temp', etc...)
% point = [x,y], coordenadas del punto considerado
% No olvidarse de actualizar la ruta y el nombre de los archivos hdf5 en
% la subrutina geth5data 


if (tinit < 0); tinit = 0; end
if (tinit > tfinal); tinit = 0; end
if (tfinal < 0);
    error('tfinal debe ser mayor que cero')
end

time = tinit;
nfile = 0;
niter = 1;
xpoint = point(1); ypoint = point(2);


while time <= tfinal
    
    [coords,vrble,currtime,nfile] = getvarline(time,'x',ypoint,nfile,variable);
    
    nxcells = max(size(coords));
    if (coords(nxcells) + 0.5*(coords(nxcells)+coords(nxcells-1)) < xpoint || ...
            coords(1) - 0.5*(coords(1)+coords(2)) > xpoint);
        error('Coordenada x fuera del dominio')
    end
    
    [dummy,idxcll] = min(abs(coords - xpoint));
    cellvars(niter) = vrble(idxcll);
    times(niter) = currtime;
    
    niter = niter + 1;
    nfile = nfile + 1;
    time = currtime;
end

identfile = '';   % Agregar algo para identificar el archivo
filedat = strcat(variable,identfile,'.dat');
fid=fopen(filedat,'w');
fprintf(fid, '%.8e  %.8e \n', [xpoint ypoint]);
for i = 1:niter-1
    fprintf(fid, '%.8e  %.8e \n', [times(i) cellvars(i)]);
end
fclose(fid);