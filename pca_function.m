function [ pcaData ] = pca_function( image , factor_sum )
[Row Col] = size(image);
%acquiring covariance matrix
cov_mat = cov(image);
% acquiring eigenvector(factor) for cov_mat
if factor_sum<=6
    [eigenvector eigenvalue] = eigs(cov_mat);
else
    [eigenvector eigenvalue] = eig(cov_mat);
end
mean_mat = mean(image); %return col-mean
temp_mat = repmat(mean_mat,Row,1);
trans_mat = (image-temp_mat)*eigenvector;
pcaData = trans_mat(:,1:factor_sum);
 end

