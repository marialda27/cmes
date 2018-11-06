function pruebaequilibrio

j0 = 100;
h0  = 6.25e8;     % 0.625e3 km
r0  = 2.5e8;      % 2.5e3 km
Del = 1.25e8;     % 1.25e3 km (Delta)
c = 29979245800;  % speed of light cm/s
p0 = 0.01657;


n = 100;
r = -(r0+Del):2*(r0+Del)/(n-1):r0+Del;
Bphi = zeros(n,1);
jz = Bphi;
pres = Bphi;

ni = 100; % intervals


for i = 1:n
    if (abs(r(i)) < r0);
        Bphi(i) = 2*pi/c*j0*r0*sin(pi/2*r(i)/r0);
        jz(i)   = 0.5*j0*r0/r(i)*(pi/2*r(i)/r0*cos(pi/2*r(i)/r0) + ...
                  sin(pi/2*r(i)/r0));
    else
        Bphi(i) = sign(r(i))*pi*j0/c*r0*(1 - sin(pi*(r(i) - (r0 + Del/2))/Del));
        jz(i) = sign(r(i))*0.25*j0*r0/r(i)*(1 - pi*r(i)/Del*cos(pi/Del*(r(i) - r0 - Del/2)) - ...
                                 sin(pi/Del*(r(i) - r0 - Del/2)));
    end
    
    intBphij = 0;
    interval = (r0 + Del - abs(r(i)))/(ni-1);
    for j = 1:ni
        Ri = abs(r(i)) + (j-0.5)*interval;
        if (abs(Ri) < r0)
            
%             disp('oooooooooooooooooooooooooooo')
            Bj = 2*pi/c*j0*r0*sin(pi/2*Ri/r0);
            jj   = -0.5*j0*r0/Ri*(pi/2*Ri/r0*cos(pi/2*Ri/r0) + ...
                  sin(pi/2*Ri/r0));
%             pause
        else
            Bj = sign(Ri)*pi*j0/c*r0*(1 - sin(pi*(Ri - (r0 + Del/2))/Del));
            jj = sign(Ri)*0.25*j0*r0/Ri*(1 - pi*Ri/Del*cos(pi/Del*(Ri - r0 - Del/2)) - ...
                                 sin(pi/Del*(Ri - r0 - Del/2)));            
        end
                
%       intBphij
        intBphij = intBphij + 1/c*Bj*jj*interval;        
    end
    pres(i) = p0 - intBphij;
    
    
end
                             
         
BphiW = zeros(n,1);
jzW = BphiW;
presW = BphiW;
for i = 1:n
    R = abs(r(i));
    if (R >= 0. && R <= r0 - Del/2)
        BphiW(i) = -2.*pi/c*j0*R;
        jzW(i) = j0;
    elseif (R > r0 - Del/2 && R <= r0 + Del/2)
        BphiW(i) = -2.*pi*j0/(c*R)*(0.5*(r0 - Del/2.)^2 - (Del/pi)^2 + ...
                    R^2/2. + Del*R/pi*sin(pi/Del*(R - r0 + Del/2.)) + ...
                    (Del/pi)^2*cos(pi/Del*(R - r0 + Del/2.)) );
        jzW(i) = 0.5d0*j0*(cos(pi*(R - r0 + Del/2)/Del) + 1.);
           
    else
        BphiW(i) = -2.*pi*j0/(c*R)*(r0^2 + (Del/2.)^2 - 2.*(Del/pi)^2);
        BphiW(i)
        jzW(i) = 0;
    end    
    
    intBphij = 0;
    interval = r0 + Del/2 - R/(ni-1);
    for j = 1:ni
        Ri = R + (j-0.5)*interval;
        if (Ri <= r0 - Del/2)
            Bj = -2.*pi/c*j0*Ri;
            jj = j0;
        elseif (Ri > r0 - Del/2 && Ri <= r0 + Del/2) 
            Bj = -2.*pi*j0/(c*Ri)*(0.5*(r0 - Del/2.)^2 - (Del/pi)^2 + ...
                    Ri^2/2. + Del*Ri/pi*sin(pi/Del*(Ri - r0 + Del/2.)) + ...
                    (Del/pi)^2*cos(pi/Del*(Ri - r0 + Del/2.)) );
            jj = 0.5d0*j0*(cos(pi*(Ri - r0 + Del/2)/Del) + 1.);
        else
            jj = 0;
        end
                
        intBphij = intBphij + 1/c*Bj*jj*interval;        
    end
    presW(i) = p0 - intBphij;
    
    
    
    
end   
figure; plot(r,Bphi,'-b'); hold on; plot(r,BphiW,'-r')
figure; plot(r,jz,'-b'), hold on; plot(r,jzW,'-r')
figure; plot(r,pres,'-b'), hold on, plot(r,presW,'-r')