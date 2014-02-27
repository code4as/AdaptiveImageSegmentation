function merged = merge(image, label_image, region_no)
    threshold = 2;
    [rows cols] = size(image);
    mean = zeros(region_no, 1);
    standardDeviation = zeros(region_no, 1);
    nop = zeros(region_no, 1); %defines number of pixels in a region
    sum = zeros(region_no, 1); %defines sum of the values of pixels of the region
    sum_of_diff = zeros(region_no, 1);
    sim = zeros(region_no, region_no);
    c_size = zeros(region_no, region_no);
    adjacent = zeros(region_no);
    circumference = zeros(region_no, 1);
    for i=1:region_no
        for x=1:rows
            for y=1:cols
                if (label_image(x,y)==i)
                    nop(i) = nop(i) + 1;
                    sum(i) = sum(i) + image(x,y);
                end
            end
        end
        mean(i) = sum(i)/nop(i);
    end
    
    for i=1:region_no
        for x=1:rows
            for y=1:cols
                if (label_image(x,y)==i)
                    sum_of_diff(i) = sum_of_diff(i) + ((mean(i) - image(x,y))^2);
                end
            end
        end
        standardDeviation(i) = sqrt(sum_of_diff(i)/nop(i));
    end
    
        [r, c] = size(label_image);
    for i=1:r
        for j=1:c
           if (i-1>=1)&&(label_image(i,j)~=label_image(i-1,j))
               adjacent(label_image(i,j),label_image(i-1,j)) = adjacent(label_image(i,j),label_image(i-1,j))+1;
           end
           if (i+1<=r)&&(label_image(i,j)~=label_image(i+1,j))
               adjacent(label_image(i,j),label_image(i+1,j)) = adjacent(label_image(i,j),label_image(i+1,j))+1;
           end
           if (j-1>=1)&&(label_image(i,j)~=label_image(i,j-1))
               adjacent(label_image(i,j),label_image(i,j-1)) = adjacent(label_image(i,j),label_image(i,j-1))+1;
           end
           if (j+1<=c)&&(label_image(i,j)~=label_image(i,j+1))
               adjacent(label_image(i,j),label_image(i,j+1)) = adjacent(label_image(i,j),label_image(i,j+1))+1;
           end
        end
    end
    
    for i=1:region_no
        for j=1:region_no
            circumference(i) = circumference(i) + adjacent(i,j);
        end
    end
    
    k = 10;
    for i=1:region_no
        for j=1:region_no
            %if (i~=j && adjacent(i,j)~=0)
            sim(i,j) = (abs(mean(i)-mean(j)))/max(0.1,(standardDeviation(i)+standardDeviation(j)));
        end
    end
     
    for i=1:region_no
        for j=1:region_no
            c_size(i,j) = min(2.0,min(nop(i),nop(j))/k);
        end
    end
    
   [ar ac] = size(adjacent);
   for i=1:ar
        for j=1:ac
            conn(i,j)=min(circumference(i),circumference(j))/(4*adjacent(i,j));
            if (conn(i,j)>=0.5 && conn(i,j)<=2.0)
                conn(i,j) = conn(i,j);
            else if(conn(i,j)<0.5)
                conn(i,j) = 0.5;
            else
                conn(i,j) = 2.0;
                end
            end
        end
   end 
   
      for i=1:ar
        for j=1:ac
            if (i~=j && adjacent(i,j)~=0)
            S(i,j) = sim(i,j)*sqrt(c_size(i,j))*conn(i,j);
            if (S(i,j)<threshold)
                if(i<j)
                    for x=1:rows
                        for y=1:cols
                            if(label_image(x,y) == j)
                                label_image(x,y) = i;
                            end
                        end
                    end
                else
                    for x=1:rows
                        for y=1:cols
                            if(label_image(x,y) == i)
                                label_image(x,y) = j;
                            end
                        end
                    end
                end
            end
            end
        end
      end
    
    merged = label_image;
end