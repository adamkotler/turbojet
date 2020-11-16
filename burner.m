function[P_04,T_04,c_p4,gamma_4]=burner(P_03,T_03,pi_b,n_b,dh,c_pc,gamma_c,f,Rs)
    P_04=P_03.*pi_b;
    [c_p4,gamma_4]=cp((T_03+1700)./2,Rs);
    T_04=((c_pc.*1000.*T_03+n_b.*dh.*1000)./(1+(1./f)))./(c_p4.*1000);
    T_04=1700;
%     fprintf("%f",f);
end