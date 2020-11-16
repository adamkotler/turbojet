function[P_05,T_05,c_p5,gamma_5]=turbine(P_04,T_04,T_03,T_02,n_t,n_m,c_p4,gamma_4,c_pc,gamma_c,f,Rs)
    c_ptemp=c_p4;
    gamma_temp=gamma_4;
    gamma_diff=1;
    
    while(gamma_diff>.01)
        T_05=T_04-(c_pc.*(T_03-T_02))./(n_m.*(1+f).*c_ptemp);
        T_av=(T_05+T_04)./2;
        [c_pnew,gamma_new]=cp(T_av,Rs);
        gamma_diff=(abs(gamma_new-gamma_temp))./gamma_temp;
%         fprintf("%f %f %f\n",T_05,gamma_new,gamma_diff);
        gamma_temp=gamma_new;
        c_ptemp=c_pnew;
    end
    gamma_5=gamma_temp;
    c_p5=c_ptemp;
    tau_t=T_05./T_04;
    pi_t=(1-((1-tau_t)./(n_t))).^(gamma_5./(gamma_5-1));
    P_05=pi_t.*P_04;
end