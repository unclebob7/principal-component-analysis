function [ ClassificationMap ] = GenerateClassificationMap( LINES, SAMPLES, COLORTABLE, DATA )
%	CreatClassificationMap����˵��
%   �������Ǹ���clsͷ�ļ�����Ϣ�ͷ���������bmp��ʽ�ķ�����ͼ
%   ����˵����
%   LINES��ԭʼ���ݵ�����
%   SAMPLES��ԭʼ���ݵ�����
%   COLORTABLE����ɫ����ʽΪn*3������n�������������ԭ���ݹ���Ϊ������
%   DATA��ԭ����ÿһ����������Ϣ����СΪ��LINES*SAMPLES��*1
%%
lines = LINES;
samples = SAMPLES;
clsnum = max(DATA);
ClassificationMap = uint8(ones(lines, samples, 3));%���е���cls�ļ����ɵ�BMP��ʽ�ļ�����matlab�о�Ϊuint8��ʽ�����������в�����uint8�����������ĸ�ʽΪdouble���õ������շ�����ͼ�����϶��Ǵ����

for i = 1 : lines;
    for j = 1 : samples;
        ClassificationMap(i, j, :) = COLORTABLE(DATA((i - 1) * samples + j, 1), :);
    end;
end;

% imwrite(ClassificationMap, 'file.bmp', 'bmp'); 

end

