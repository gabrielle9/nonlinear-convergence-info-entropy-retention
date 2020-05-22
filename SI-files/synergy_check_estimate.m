clearvars

cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/March/29')
load('H_binned_nDin_sigs10_sqsc_cg_relu_out_29Mar20.mat')


syn_lin = Hr_lin_nDin_2Dout_sqsc - 2.*Hr_lin_nDin_1Dout_sqsc;
syn_nlout = Hr_nlout_nDin_2Dout_sqsc - 2.*Hr_nlout_nDin_1Dout_sqsc;
syn_nl = Hr_nl_nDin_2Dout_sqsc - 2.*Hr_nl_nDin_1Dout_sqsc;


figure
plot(sdims,syn_lin,'o-')
hold on
plot(sdims,syn_nlout,'o-')
plot(sdims,syn_nl,'o-')


cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/May/5')
