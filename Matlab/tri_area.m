function Area = tri_area(file_name)

for i = 1:size(file_name.faces,1)
    AB(i,:) = file_name.vertices(file_name.faces(i,2),:) - file_name.vertices(file_name.faces(i,1),:);
    AC(i,:) = file_name.vertices(file_name.faces(i,3),:) - file_name.vertices(file_name.faces(i,1),:);
    Cross(i,:) = cross(AB(i,:),AC(i,:));
    Norm(i,1) = norm(cross(AB(i,:),AC(i,:)));
    Area(i,1) = 1/2 * norm(cross(AB(i,:),AC(i,:)));
end
end