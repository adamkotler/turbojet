function[P_06,P_star,T_06,V_e,c_p6,gamma_6] = nozzle(P_04,P_a,T_04,n_n,Rs,type)
    switch(type)
        case 'C'
            P_06=P_04;
            T_06=T_04;
            [c_p6,gamma_6]=cp(T_06,Rs);
            P_star=P_06.*(1+((1-gamma_6)./(n_n.*(1+gamma_6)))).^(gamma_6./(gamma_6-1));
            V_e=sqrt(2.*c_p6.*1000.*n_n.*T_06.*(1-(P_star./P_06)).^((gamma_6+1)./(gamma_6)));
        case 'C+D'
            %Difference is perfect expansion, thus P_a in velocity term
            %instead of P*
            P_06=P_04;
            T_06=T_04;
            [c_p6,gamma_6]=cp(T_06,Rs);
            P_star=P_06.*(1+((1-gamma_6)./(n_n.*(1+gamma_6)))).^(gamma_6./(gamma_6-1));
            V_e=sqrt(2.*c_p6.*1000.*n_n.*T_06.*(1-(P_a./P_06)).^((gamma_6+1)./(gamma_6)));
    end
end