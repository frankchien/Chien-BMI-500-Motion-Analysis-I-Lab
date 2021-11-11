function primary_component = pc1(filtered)
coefficient_matrix = pca(filtered); %returns the principal component coefficient matrix. It's going to be 3x3, since 3 channels were passed in
first_pca = coefficient_matrix(:,1); %coefficient matrix columns are the pca vectors in descending order. The first one is the best principal component
%taking the dot product will project the data onto the principal axis
primary_component = filtered * first_pca;
end