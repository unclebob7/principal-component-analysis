# principal-component-analysis
pca algorithmic implementation on inp
Principal component analysis
Detailed-project_addr :  https://github.com/unclebob7/principal-component-analysis
Algorithmic specification：
 
flowchart-display
(i) reduction of the original variables into a lower number which are mutually orthogonal (non-correlated)
(ii)visualizing correlations among the original variables and between these variables (or factors)
(iii) visualizing proximities among statistical units

 
Implementation with MATLAB
Core function displays as follows:
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
Q&A
1.	image display for first 5 principal images of the highest eigenvalues
    

2.	image display for inp after [PCA] to 5-dimension and kNN along after
 。

