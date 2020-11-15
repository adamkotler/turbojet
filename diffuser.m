function[P_0a,P_02,T_0a,T_02]=diffuser(P_a,T_a,gamma_a,M,pi_d)
    %%
    %Evaluate total pressure
    P_0a=P_a.*(1+(0.5.*(gamma_a-1).*(M.^2))).^(gamma_a./(gamma_a-1));
    P_02=P_0a.*pi_d;
    %%
    %Evaluate total temperature
    T_0a=T_a.*(1+0.5.*(gamma_a-1).*M.^2);
    T_02=T_0a;
end