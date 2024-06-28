function [x1,y1] = mapping(image,y,x,las_dist,ocam_model)
[height,width] = size(image);
Z=las_dist;
a = 1;
x1=[];
y1=[];
t = [0;0;Z];
r = compose_rotation(-x, -y, 0);
r = [r(:,1),r(:,2),t];
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
              
            y1(a)= ? 
            x1(a)= ?  
            a=a+1;
        end
    end
end
end