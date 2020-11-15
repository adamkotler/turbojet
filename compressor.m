function[P_03,T_03,c_pc,gamma_c]=compressor(P_02,T_02,pi_c,n_c,Rs)
    P_03=P_02.*pi_c;
    [c_p0,gamma_0]=cp(T_02,Rs);
    c_ptemp=c_p0;
    gamma_temp=gamma_0;
    gamma_diff=1;
    
    while(gamma_diff>.01)
        tau_temp=1+((pi_c.^((gamma_temp-1)./(gamma_temp))-1)./(n_c));
        T_03=tau_temp.*T_02;
        T_av=(T_02+T_03)./2;
        [c_pnew,gamma_new]=cp(T_av,Rs);
        gamma_diff=(abs(gamma_new-gamma_temp))./gamma_temp;
        fprintf("%f %f %f\n",T_03,gamma_new,gamma_diff);
        gamma_temp=gamma_new;
        c_ptemp=c_pnew;
    end
    
    gamma_c=gamma_temp;
    c_pc=c_ptemp.*1000;;
    
end