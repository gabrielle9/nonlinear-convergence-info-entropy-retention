clearvars

% cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/March/29')
% load('H_binned_nDin_sigs10_sqsc_cg_relu_out_29Mar20.mat')
cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/September/4')
load('H_binned_nDin_sigs10_sqsc_cg_relu_out_4Sep20.mat')

syn_lin = Hr_linsubs_linout_nDin_2Dout_sqsc - 2.*Hr_linsubs_linout_nDin_1Dout_sqsc;
syn_nlout = Hr_linsubs_nlout_nDin_2Dout_sqsc - 2.*Hr_linsubs_nlout_nDin_1Dout_sqsc;
syn_nl = Hr_nlsubs_nlout_nDin_2Dout_sqsc - 2.*Hr_nlsubs_nlout_nDin_1Dout_sqsc;


figure
plot(sdims,syn_lin,'o-')
hold on
plot(sdims,syn_nlout,'o-')
plot(sdims,syn_nl,'o-')


% cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/May/5')
