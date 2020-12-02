function jain_value = jain(x)
[m,~]= size(x);
v = zeros(1,m);
for i = 1:m
    v(i) = length(nonzeros(x(i,:)));
end
a1 = sum(v)^2;
a2 = v*v.'*m;
jain_value = a1/a2;
end

