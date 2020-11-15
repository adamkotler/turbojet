function[c_p,gamma]=cp(T,Rs)
c_p=.9584.*exp((1.68E-4).*T);
gamma=c_p./(c_p-Rs);
end