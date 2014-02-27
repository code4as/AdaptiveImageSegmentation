function labelled = grow(image,x,y,label,labelled_image)
     [rows, cols] = size(image);
     neighboursX = [-1 1 0 0];
     neighboursY = [0 0 1 -1];
     qX = zeros(rows, 1);
     qY = zeros(cols, 1);
     rear = 1;
     front = 1;
     seed = image(x,y);
     qX(front) = x;
     qY(front) = y;
     labelled_image(x,y) = label;
     for i=1:rows
         for j=1:cols
             while(front<rear || front == 1)
                 for z=1:4
                     rx = qX(front) + neighboursX(z);
                     ry = qY(front) + neighboursY(z);
                     if (((rx > 1) && (ry > 1) && (ry < rows) && (rx < cols))) %% avoiding boundaries
                           if ((abs(int32(seed) -  int32(image(rx,ry))) <= 11) && labelled_image(rx,ry)==0)
                                 labelled_image(rx,ry) = label;
                                 rear = rear+1;
                                 qX(rear) = rx;
                                 qY(rear) = ry;
                           end           
                      end
                 end
                 front = front + 1;
             end
        end
     end
     labelled = labelled_image;
end