function final_image = boundary_elimination(image, label_image)
t = 230;
region_no = max(max(label_image));
length = zeros(region_no,1);
[r c]=size(label_image);
connectivity=zeros(region_no,1);

for i = 1:r
    for j = 1:c
           if (i-1>=1)&&(label_image(i,j)~=label_image(i-1,j))
               length(label_image(i,j),1)=length(label_image(i,j),1)+1;
               connectivity(label_image(i,j),1)=connectivity(label_image(i,j),1)+abs(image(i,j)-image(i-1,j));
           end
           if (i+1<=r)&&(label_image(i,j)~=label_image(i+1,j))
               length(label_image(i,j),1)=length(label_image(i,j),1)+1;
               connectivity(label_image(i,j),1)=connectivity(label_image(i,j),1)+abs(image(i,j))-image(i+1,j);
           end
           if (j-1>=1)&&(label_image(i,j)~=label_image(i,j-1))
               length(label_image(i,j),1)=length(label_image(i,j),1)+1;
               connectivity(label_image(i,j),1)=connectivity(label_image(i,j),1)+abs(image(i,j)-image(i,j-1));
           end
           if (j+1<=c)&&(label_image(i,j)~=label_image(i,j+1))
               length(label_image(i,j),1)=length(label_image(i,j),1)+1;
               connectivity(label_image(i,j),1)=connectivity(label_image(i,j),1)+abs(image(i,j)-image(i,j+1));
           end
           if (i-1>=1)&&(j-1>=1)&&(label_image(i,j)~=label_image(i-1,j-1))
               length(label_image(i,j),1)=length(label_image(i,j),1)+1;
               connectivity(label_image(i,j),1)=connectivity(label_image(i,j),1)+abs(image(i,j)-image(i-1,j-1));
           end
           if (i+1<=r)&&(j+1<=c)&&(label_image(i,j)~=label_image(i+1,j+1))
               length(label_image(i,j),1)=length(label_image(i,j),1)+1;
               connectivity(label_image(i,j),1)=connectivity(label_image(i,j),1)+abs(image(i,j)-image(i+1,j+1));
           end
           if (i+1<=r)&&(j-1>=1)&&(label_image(i,j)~=label_image(i+1,j-1))
               length(label_image(i,j),1)=length(label_image(i,j),1)+1;
               connectivity(label_image(i,j),1)=connectivity(label_image(i,j),1)+abs(image(i,j)-image(i+1,j-1));
           end
           if (i-1>=1)&&(j+1<=c)&&(label_image(i,j)~=label_image(i-1,j+1))
               length(label_image(i,j),1)=length(label_image(i,j),1)+1;
               connectivity(label_image(i,j),1)=connectivity(label_image(i,j),1)+abs(image(i,j)-image(i-1,j+1));
           end
    end
end

[rows cols] = size(connectivity);
merit = zeros(rows, cols);
for i = 1:region_no
    merit(i,1)=round(connectivity(i)/length(i));
end

for i=1:r
    for j=1:c
        if merit(label_image(i,j),1) <= t
            label_image(i,j)=0;
        end
    end
end

final_image = label_image;
end