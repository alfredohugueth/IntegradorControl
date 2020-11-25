clc;
clear all;
a = [1 1];
b = [1 0];
TF = tf(a,b);
[num,den]=tfdata(TF);
syms s;
ec = poly2sym(a,s)/poly2sym(b,s)