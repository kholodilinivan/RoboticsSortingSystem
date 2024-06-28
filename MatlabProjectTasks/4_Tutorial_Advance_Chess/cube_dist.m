function [Dist] = cube_dist(I,i_,j_,camY,camX,camZ,lasY,lasX,las_dist,ocam) 
Z=-las_dist;
a = 1;
x1=[];
y1=[];
t = [0;0;Z];
r = compose_rotation(-lasX, -lasY, 0);
r1 = compose_rotation(camX,camY, camZ);
r = r1*[r(:,1),r(:,2),t];
for i=i_(1):i_(2)     % working image region
    for j=j_(1):j_(2)
        if I(j,i)>0   
            m=[j;i];       % image pixels
            M = cam2world(m,ocam); % transform from image plane to the camera plane   
            a1 = ? 
            b1 = ? 
            c1 = ?       
            a2 = ? 
            b2 = ? 
            c2 = ? 
 
            Y = ? 
            X = ? 
                
            y1(a)= ? 
            x1(a)= ? 
            a=a+1;
        end
    end
end
Dist=[y1',x1'];
end  