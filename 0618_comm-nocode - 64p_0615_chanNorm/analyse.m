function [Pd]=analyse(TT)
pp = zeros(1,21);
[nouse,times] = size(TT);
for i = 1:times
    if TT(i)>men(1)
        pp(1) = pp(1)+1;
    end
    if TT(i)>men(2)
        pp(2) = pp(2)+1;
    end
    if TT(i)>men(3)
        pp(3) = pp(3)+1;
    end
    if TT(i)>men(4)
        pp(4) = pp(4)+1;
    end
    if TT(i)>men(5)
        pp(5) = pp(5)+1;
    end
    if TT(i)>men(6)
        pp(6) = pp(6)+1;
    end
    if TT(i)>men(7)
        pp(7) = pp(7)+1;
    end
    if TT(i)>men(8)
        pp(8) = pp(8)+1;
    end
    if TT(i)>men(9)
        pp(9) = pp(9)+1;
    end
    if TT(i)>men(10)
        pp(10) = pp(10)+1;
    end
    if TT(i)>men(11)
        pp(11) = pp(11)+1;
    end
    if TT(i)>men(12)
        pp(12) = pp(12)+1;
    end
    if TT(i)>men(13)
        pp(13) = pp(13)+1;
    end
    if TT(i)>men(14)
        pp(14) = pp(14)+1;
    end
    if TT(i)>men(15)
        pp(15) = pp(15)+1;
    end
    if TT(i)>men(16)
        pp(16) = pp(16)+1;
    end
    if TT(i)>men(17)
        pp(17) = pp(17)+1;
    end
    if TT(i)>men(18)
        pp(18) = pp(18)+1;
    end
    if TT(i)>men(19)
        pp(19) = pp(19)+1;
    end
    if TT(i)>men(20)
        pp(20) = pp(20)+1;
    end
    if TT(i)>0
        pp(21) = pp(21)+1;
    end
end
Pd = pp/times;
end