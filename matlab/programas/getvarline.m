function [coords,vrble,currtime,fileidx] = getvarline(time,direction,pos,previdx,variable)

 if ~exist('previdx','var')
       previdx = 0;
 end


% direction 'x' o 'y'

[filename,nxb,nyb,nzb,ndim,xmin,xmax,ymin,ymax,zmin,zmax] = geth5data;

if (ndim < 2)
    disp('La funcion es valida solo para dos dimensiones')
    return
end

switch lower(direction)
    case 'x'
        dir1 = 1; dir2 = 2; ncll1 = double(nxb); ncll2 = double(nyb);
        if (pos > xmax || pos < xmin)
            disp('Posicion fuera de los limites del dominio')
            return
        end 
        
    case 'y'
        dir1 = 2; dir2 = 1; ncll1 = double(nyb); ncll2 = double(nxb);
        if (pos > ymax || pos < ymin)
            disp('Posicion fuera de los limites del dominio')
            return
        end 
        
    otherwise
        disp('Opción de dirección (x o y) no válida')
        return
end

h5var = strcat('/',variable);

for i = previdx:9999
    ichar = num2str(i,'%4i')
    if      (i > 999); currfile = strcat(filename,ichar);
    elseif  (i > 99); currfile = strcat(filename,'0',ichar);
    elseif  (i > 9); currfile = strcat(filename,'00',ichar);
    else   currfile = strcat(filename,'000',ichar);
    end
    
    if exist(currfile,'file')
        rlsclrs =  h5read(currfile,'/real scalars');
        currtime = rlsclrs.value(1);
        
        if (currtime >= time)
            intgrsclrs = h5read(currfile,'/integer scalars');
            intgrprmtrs = h5read(currfile,'/integer runtime parameters');
            boundbox = h5read(currfile,'/bounding box'); % Límites físicos de los bloques            

            
            
            dimarrays = 1;
            
            if (max(size(intgrprmtrs.value)) < 70) % Grilla uniforme
                                
                cell1 = (boundbox(2,dir1) - boundbox(1,dir1))/ncll1;
                coords1 = boundbox(1,dir1)+cell1/2:cell1:boundbox(2,dir1);
                [dummy,idxcll] = min(abs(coords1 - pos));
                cell2 = (boundbox(2,dir2) - boundbox(1,dir2))/ncll2;
                coords(dimarrays) = boundbox(1,dir2) + cell2/2;
                coords(dimarrays+1:dimarrays+ncll2-1) = boundbox(1,dir2) + cell2/2 + cell2:cell2:boundbox(2,dir2);
                dum = h5read(currfile,h5var);
                if (dir1 == 1); vrble(dimarrays:dimarrays+ncll2-1) = dum(idxcll,:,1);
                elseif (dir1 == 2); vrble(dimarrays:dimarrays+ncll2-1) = dum(:,idxcll,1);
                end
                dimarrays = dimarrays + ncll2;
            else
                nblocks = intgrsclrs.value(5);  % Número total de bloques
                reflevel = h5read(currfile,'/refine level'); % nivel de refinamiento de cada bloque            
                        
                for nb = 1:nblocks-1
                    if ((reflevel(nb) >= reflevel(nb+1))  && ...
                        (boundbox(1,dir1,nb) < pos && boundbox(2,dir1,nb) >= pos))
                        
                        idxblk = nb;
                    
                        cell1 = (boundbox(2,dir1,nb) - boundbox(1,dir1,nb))/ncll1;
                        coords1 = boundbox(1,dir1,nb)+cell1/2:cell1:boundbox(2,dir1,nb);
                        [dummy,idxcll] = min(abs(coords1 - pos));
                        
                        cell2 = (boundbox(2,dir2,nb) - boundbox(1,dir2,nb))/ncll2;
                        coords(dimarrays) = boundbox(1,dir2,nb) + cell2/2;
                        coords(dimarrays+1:dimarrays+ncll2-1) = boundbox(1,dir2,nb) + cell2/2 + cell2:cell2:boundbox(2,dir2,nb);
                        dum = h5read(currfile,h5var);
                        if (dir1 == 1); vrble(dimarrays:dimarrays+ncll2-1) = dum(idxcll,:,1,idxblk);
                        elseif (dir1 == 2); vrble(dimarrays:dimarrays+ncll2-1) = dum(:,idxcll,1,idxblk);
                        end
                        dimarrays = dimarrays + ncll2;
                    end
                end
            end
            fileidx = i;
            [coords,order] = sort(coords);
            vrble = vrble(order);
            break
        end
    else
        break
    end
end

    
