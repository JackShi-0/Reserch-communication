function [ output_args ] = Func_convoCode( input_args ,  EnOrDe)
%FUNC_CONVCODE �˴���ʾ�йش˺�����ժҪ
%   �������


trellis = poly2trellis(7,[171 133]);
tbl = 32;%����������ܸģ����˾ʹ��ˣ���������%%zjע ����ǻ��ݳ���  �о���ү���32������ѽ��Ӧ����42��



if EnOrDe=='encode'
        output_args = convenc(input_args,trellis);
elseif EnOrDe=='decode'
        output_args = vitdec(input_args,trellis,tbl,'trunc','hard');
end

end

