close all;

%%
%Initialize constants
Rs=.287;%[kJ/kgK]
str=input("Select Program: 'Ramjet' 'Turbojet' ",'s');
%%
%Initialize Parameters
M=.86;%Mach Number
P_a=18750;%[Pa]
T_a=216.7;%[K]
T_04=1700;%[K]
    [cp_a,gamma_a]=cp(T_a,Rs);
pi_d=0.97;%diffuser pressure ratio
pi_b=0.95;%burner pressure ratio
n_b=0.96;%burner efficiency
n_n=0.98;%nozzle efficiency
dh=45000;%delta-enthalpy across burner
pi_c=30;%compressor pressure ratio
n_c=.85;%compressor efficiency
n_t=.9;%turbine efficiency
n_m=0.99;%mechanical losses

if(strcmp(str,"Ramjet"))
    noz_bool=input("Select Nozzle: 'C' 'C+D' ",'s');
    if(strcmp(noz_bool,"C"))
        %Perform Calculations for Strictly converging, choked nozzle
        [P_0a,P_02,T_0a,T_02]=diffuser(P_a,T_a,gamma_a,M,pi_d);
        [f,P_03,P_04,c_p3,c_p4,c_pav,gamma_3,gamma_4]=burner(P_02,T_02,T_04,pi_b,n_b,dh,Rs);
        [P_06,P_star,T_06,V_e,c_p6,gamma_6]=nozzle(P_04,P_a,T_04,n_n,Rs,noz_bool);
        %Output results for strictly converging nozzle
        header={'MATLAB/CLASS','P_0a[Pa]','T_0a[K]','f[-]','P*[Pa]','V_exit[m/s]'};
        mat_dat={'MATLAB',P_0a,T_0a,f,P_star,V_e};
        class_dat={'CLASS',792,518,.0315,299,1108};
            dat=vertcat(mat_dat,class_dat);
        CHOKED_TABLE=cell2table(dat,'VariableNames',header)
    else
        %Perform Calculations for Strictly converging, choked nozzle
        [P_0a,P_02,T_0a,T_02]=diffuser(P_a,T_a,gamma_a,M,pi_d);
        [f,P_03,P_04,c_p3,c_p4,c_pav,gamma_3,gamma_4]=burner(P_02,T_02,T_04,pi_b,n_b,dh,Rs);
        [P_06,P_star,T_06,V_e,c_p6,gamma_6]=nozzle(P_04,P_a,T_04,n_n,Rs,noz_bool);
        %Output results for strictly converging nozzle
        header={'MATLAB/CLASS','P_0a[Pa]','T_0a[K]','f[-]','P*[Pa]','V_exit[m/s]'};
        mat_dat={'MATLAB',P_0a,T_0a,f,P_star,V_e};
        class_dat={'CLASS',792,518,.0315,299,1108};
            dat=vertcat(mat_dat,class_dat);
        CONVERGING_DIVERGING_TABLE=cell2table(dat,'VariableNames',header)
    end
else
        [P_0a,P_02,T_0a,T_02]=diffuser(P_a,T_a,gamma_a,M,pi_d);
        [P_03,T_03,c_pc,gamma_c]=compressor(P_02,T_02,pi_c,n_c,Rs);
%         %Output results for strictly converging nozzle
%         header={'MATLAB/CLASS','P_0a[Pa]','T_0a[K]','f[-]','P*[Pa]','V_exit[m/s]'};
%         mat_dat={'MATLAB',P_0a,T_0a,f,P_star,V_e};
%         class_dat={'CLASS',792,518,.0315,299,1108};
%             dat=vertcat(mat_dat,class_dat);
%         CONVERGING_DIVERGING_TABLE=cell2table(dat,'VariableNames',header)
end
 