function [ output_args ] = Func_convoCode( input_args ,  EnOrDe)
%FUNC_CONVCODE 此处显示有关此函数的摘要
%   卷积编码


trellis = poly2trellis(7,[171 133]);
tbl = 32;%这个数好像不能改，改了就错了，，，！！%%zj注 这个是回溯长度  感觉琦爷这个32有问题呀，应该是42？



if EnOrDe=='encode'
        output_args = convenc(input_args,trellis);
elseif EnOrDe=='decode'
        output_args = vitdec(input_args,trellis,tbl,'trunc','hard');
end

end

