
%% mali�޸�
% ��1��npred=ntrue;ʹ��Ԥ���������=ʵ����𣬼�ʹ�е����û�б�Ԥ�⵽������=0������ôacc_true=0�����ˡ�
% ��2��48�б��Ƶ�53�У����е����û�б�Ԥ�⵽ʱ��total�������Ͳ�����������ˣ���ʹ��total�������ԣ�OA����Ͳ��ԡ�

function [fid,acc,acc_true,kappa,acc_pred] = confusion_ML(true,pred,fid)  ;
%  USAGE: [fid,acc,kappa] = confusion
% 
% PURPOSE: Lines are true classes and columns are the pred classes
% HCFS.m -> confusion.m

%% Handle input arguments 
if nargin<2, eval('help confusion'); return; end;  
if nargin<3, fid = 1; end;
utrue = unique(true)'; ntrue = length(utrue);
upred = unique(pred)'; npred = length(upred);%%�����е����û���κη����������һ��Ϊ�գ�������Զ�����Ϊ0.������npred=ntrue
npred=ntrue;upred=utrue; %% mali�޸ģ�����
%% Compute the numbers in the confusion matrix
% Original classes
for i=1:npred
    for j=1:ntrue
    confusion(i,j) = length(find(pred==upred(i) & true==utrue(j))); %��Ԥ��������ʵ������س̶�
    end; 
end;
% Additional class
if length(find(pred==0))~=0 %������Ч����ĵ�
  for j=1:ntrue
  confusion(npred+1,j) = length(find(pred==0 & true==utrue(j)));%�����Ѿ�ͳ���ˣ�����confusion�ĵ�һ�У��ʹ���Ԥ��Ϊ0ʱ��Ľ��
  end;
end;

% Accuracies
for i=1:npred
    NumPred(i) = length(find(pred==upred(i)));
    j = find(utrue==upred(i));
    if length(j)~=0 & NumPred(i)>0
	acc_pred(i) = confusion(i,j)/NumPred(i); %����׼ȷ��(user accuracy),��ȷ�������/��⵽�ĸ���
    else 
	acc_pred(i) = NaN; 
    end;
end;

total = 0;
for j=1:ntrue
    NumTrue(j) = length(find(true==utrue(j) & pred~=0));
    i = find(upred==utrue(j));
    if length(i)~=0 & NumTrue(j)>0
%         total = total + NumTrue(j);
	acc_true(j) = confusion(i,j)/NumTrue(j);%����׼ȷ��(product accuracy),��ȷ�������/�����ܵĸ���
    else 
	acc_true(j) = NaN;
    end; 
    total = total + NumTrue(j);
end;

% kappa = (total*sum(diag(confusion))-sum(diag(confusion*confusion')))/(total^2-sum(diag(confusion*confusion')));
acc = length(find(true==pred))/total;

%use Wonkook's code to calculate kappa value
%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
kappa=wkKappa(pred',true', utrue);%input:1*nsamp
%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

%% Print out the confusion matrix
fprintf(fid,'\n\nOverall Accuracy: %3.2f',100*acc);
fprintf(fid,'\nKappa: %3.2f',abs(100*kappa));
fprintf(fid,'\n\n    ');
for j = 1:ntrue
    fprintf(fid,'&  %2d  ',utrue(j));
end; 
fprintf(fid,'\n');
fprintf(fid, repmat('-',7*ntrue+14,1));
% myMatrix = [];
for i = 1:npred 
  fprintf(fid,'\n %2d ',upred(i));
  for j = 1:ntrue
    fprintf(fid,'& %4d ',confusion(i,j)); 
  end;
  fprintf(fid,'&  %3.1f',100*acc_pred(i));%myMatrix = cat(1,myMatrix,100*acc_pred(i)); 
end;
% myMatrix
% myMatrix2 = [];
if length(find(pred==0))~=0
  fprintf(fid,'\n %2d ',0);
  for j=1:ntrue
    fprintf(fid,'& %4d ',confusion(npred+1,j));
  end;
end;
fprintf(fid,'\n');
fprintf(fid, repmat('-',7*ntrue+14,1)); 

fprintf(fid,'\n');
fprintf(fid,'    ');
for j=1:ntrue 
  fprintf(fid,'& %3.1f ',100*acc_true(j)); %myMatrix2 = cat(1,myMatrix2,100*acc_true(j));
end;
fprintf(fid,'\n\n');
% myMatrix2
