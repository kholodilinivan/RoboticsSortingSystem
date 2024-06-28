function [x,y] = mapping(image,camY,camX,camZ,lasY,lasX,las_dist,ocam_model)
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

            y(a)= ? 
            x(a)= ? 
            a=a+1;
        end
    end
end
end