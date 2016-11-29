function [A,b] = getSystemLaplaceSparse(nx,ny, xmin, xmax, ymin, ymax, Tleft, Tright, Tbottom, Ttop)

dx = (xmax - xmin)/(nx - 1);
dy = (ymax - ymin)/(ny - 1);

values = zeros(5*nx*ny,1);
rows = zeros(5*nx*ny,1);
cols = zeros(5*nx*ny,1);
counter = 1;
b = zeros(nx*ny,1);

for iy=1:ny
    for ix=1:nx
        
        rowindex = (iy-1)*nx + ix;
        values(counter) = -4;
        rows(counter) = rowindex;
        cols(counter) = rowindex;
        counter = counter +1;
        
        if (ix > 1)
            values(counter) = 1;
            rows(counter) = rowindex;
            cols(counter) = rowindex - 1;
            counter = counter+1;
        else
            b(rowindex,1) = b(rowindex,1) - Tleft;
        end
        
        if (ix < nx)
            values(counter) = 1;
            rows(counter) = rowindex;
            cols(counter) = rowindex + 1;
            counter = counter + 1;
        else
            b(rowindex,1) = b(rowindex,1) - Tright;
        end
        
        
        if (iy > 1)
            values(counter) = 1;
            rows(counter) = rowindex;
            cols(counter) = rowindex - nx;
            counter = counter + 1;           
        else
            b(rowindex,1) = b(rowindex,1) - Tbottom;
        end
        
        if (iy < ny)
            values(counter) = 1;
            rows(counter) = rowindex;
            cols(counter) = rowindex + nx;
            counter = counter + 1;
        else
            b(rowindex,1) = b(rowindex,1) - Ttop;
        end
    end
end

counter = counter - 1;

values = values(1:counter);
rows = rows(1:counter);
cols = cols(1:counter);

display('Matrix Fill Complete');

%Create the sparse matrix
A = sparse(rows,cols,values,nx*ny, nx*ny);












