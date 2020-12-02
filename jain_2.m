function jain_value = jain_2(v)
[~,m]= size(v);
a1 = sum(v)^2;
a2 = v*v.'*m;
jain_value = a1/a2;
end
