function [ Phi_mtx ] = Phi( k )
Phi_mtx = zeros(k,k);
if(mod(k,2)==0)
    for m = 0:k-1
        for n = 0:k-1
            Phi_mtx(m+1,n+1) = 1/(k^0.5)*exp(-1j*pi/4)*exp(1j*pi*((m-n)^2)/k);
        end
    end
else
    for m = 0:k-1
        for n = 0:k-1
            Phi_mtx(m+1,n+1) = 1/(k^0.5)*exp(-1j*pi/4)*exp(1j*pi*((m-n+0.5)^2)/k);
        end
    end
end
end

