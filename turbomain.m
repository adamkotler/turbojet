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
% T_04=1700;%[K]
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
f=.0283;%fuel-air ratio
gamma_a=1.4;

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
        noz_bool=input("Select Nozzle: 'C' 'C+D' ",'s');
        [P_0a,P_02,T_0a,T_02]=diffuser(P_a,T_a,gamma_a,M,pi_d);
        [P_03,T_03,c_pc,gamma_c]=compressor(P_02,T_02,pi_c,n_c,Rs);
        [P_04,T_04,c_p4,gamma_4]=burner(P_03,T_03,pi_b,n_b,dh,c_pc,gamma_c,f,Rs);
        [P_05,T_05,c_p5,gamma_5]=turbine(P_04,T_04,T_03,T_02,n_t,n_m,c_p4,gamma_4,c_pc,gamma_c,f,Rs);
        [P_06,P_star,T_06,T_star,V_e,c_p6,c_pn,gamma_6,gamma_n,A_ma,F_ma,TSFC,V_in]=nozzle(M,P_05,P_a,T_05,T_a,n_n,gamma_5,c_p5,f,Rs,noz_bool);
        %Output results
        header={'MATLAB/CLASS','T_02[K]','P_02[Pa]','gamma_a[-]','T_03[K]','P_03[Pa]','c_pc[','f[-]','P*[Pa]','V_exit[m/s]'};
        labels={'CLASS','MATLAB'};
        mat_dat={'MATLAB',P_0a,T_0a,f,P_star,V_e};
        class_dat={'CLASS',792,518,.0315,299,1108};
            dat=vertcat(mat_dat,class_dat);
        CONVERGING_DIVERGING_TABLE=cell2table(dat,'VariableNames',header)
end
 