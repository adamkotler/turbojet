function[P_06,P_star,T_06,T_star,V_e,c_p6,c_pn,gamma_6,gamma_n,A_ma,F_ma,TSFC,V_in]=nozzle(M,P_05,P_a,T_05,T_a,n_n,gamma_5,c_p5,f,Rs,type)
    switch(type)
        case 'C'
            V_in=M.*sqrt(1.4.*Rs.*T_a.*1000);
            P_06=P_05;
            T_06=T_05;
            [c_p6,gamma_6]=cp(T_06,Rs);
            P_star=P_06.*(1+((1-gamma_6)./(n_n.*(1+gamma_6)))).^(gamma_6./(gamma_6-1));
            T_star=T_06.*(2./(gamma_6+1));
            [c_pn,gamma_n]=cp((T_star+T_06)./2,Rs);
            V_e=sqrt(2.*c_pn.*1000.*n_n.*T_star.*(1-(P_star./P_06).^((gamma_n-1)./(gamma_n))));
            A_ma=(1+f)./(((P_star)./(Rs.*1000.*T_star)).*(V_e));
            F_ma=((1+f).*V_e)-(V_in)+((P_star-P_a).*A_ma);
            TSFC=f./F_ma;
        case 'C+D'
            %Difference is perfect expansion, thus P_a in velocity term
            %instead of P*
            V_in=M.*sqrt(1.4.*Rs.*T_a);
            P_06=P_05;
            T_06=T_05;
            [c_p6,gamma_6]=cp(T_06,Rs);
            P_star=P_06.*(1+((1-gamma_6)./(n_n.*(1+gamma_6)))).^(gamma_6./(gamma_6-1));
            T_star=T_06.*(2./(gamma_6+1));
            [c_pn,gamma_n]=cp(T_star,Rs);
            V_e=sqrt(2.*c_p6.*1000.*n_n.*T_star.*(1-(P_a./P_06).^((gamma_6+1)./(gamma_6))));
            A_ma=(1+f)./(((P_06)./(Rs.*T_star)).*(V_e));
            F_ma=((1+f).*V_e)-(V_in);
            TSFC=f./F_ma;
    end
end