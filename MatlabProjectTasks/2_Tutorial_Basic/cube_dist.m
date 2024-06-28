function [Dist] = cube_dist(image,i_,j_,y,x,las_dist,ocam_model)
   
Z=las_dist;
a = 1;
x1=[];
y1=[];
t = [0;0;Z];
r = compose_rotation(-x, -y, 0);
r = [r(:,1),r(:,2),t];
for i=i_(1):i_(2)     % working image region
    for j=j_(1):j_(2)
        if image(j,i)>0   
            m=[j;i];       % image pixels
            M = cam2world(m,ocam_model); % transform from image plane to the camera plane    
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