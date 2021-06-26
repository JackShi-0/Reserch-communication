%%%废弃了没用到%%%
Npacket = 1;%the number of subcarriers without pilot
Nchirp = 512; %information bits of each subcarriers
N = 256; %length of ZC

%这边没理解
%P_len 就是多径条数L
P_len  = 20;%相当于所有的pilot都使用上了，不只取前面一部分伪造比较好的效果
L= P_len ;

Ngd = 128;%代码中新增加了保护间隔