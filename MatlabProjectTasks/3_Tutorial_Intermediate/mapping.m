function [x,y] = mapping(image,cvsyst_rot,cvsyst_y,cvsyst_x,camY,camX,...
    camZ,lasY,lasX,las_dist,ocam_model)

[height,width] = size(image);
Z=las_dist;
a = 2;
x=[];
y=[];
t = [0;0;Z];
r = compose_rotation(-lasX, -lasY, 0);
r1 = compose_rotation(camX, camY, camZ);
r = r1*[r(:,1),r(:,2),t];
for i=1:height      % working image region
    for j=1:width
        if image(i,j)>0
            m=[i;j];       % image pixels
            M = cam2world(m,ocam_model); % transform from image plane to the camera plane  
            a1 = ? 
            b1 = ? 
            c1 = ?       
            a2 = ? 
            b2 = ? 
            c2 = ? 

            Y = ? 
            X = ? 

            M1=[X;Y;1];
            r2 = compose_rotation( ? );
            M1 = r2*M1; % CV System rotation

            y(1)=cvsyst_x; % CV System translation
            x(1)=cvsyst_y;
                
            y(a)=M1(1)+cvsyst_x;
            x(a)=-M1(2)+cvsyst_y; 
            a=a+1;
        end
    end
end
end