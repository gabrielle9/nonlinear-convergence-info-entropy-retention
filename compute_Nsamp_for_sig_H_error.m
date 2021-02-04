function [Ns] = compute_Nsamp_for_sig_H_error(sig_x,varargin)
% do the entropy error test to find out how many samples are needed for a
% hypothetical 2D gaussian (no corrs) distribution with std = sig_x

maxArgs = 2;
if nargin == maxArgs
    tol = varargin{1};
else
    tol = 0.005; % 0.5 percent error
end

% cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/August/31')
% load('H_err_sig_fit.mat','sb','yb','bw') %these fits were done with bw=0.25
sb = [-0.9599;0.0060];
yb = [3.8607;0.0220];
bw = 0.25;

%%
% sig_x = 10; %whatever our sigma of interest is
Nsamps = [1e5,5e5,1e6,5e6,1e7,5e7,1e8];
% Nsamps = [(1:2:9).*1e5,(1:2:9).*1e6,(1:2:9).*1e7,(1:2:9).*1e8];
rdim = 2; %must be hardcoded since fits are only for rdim=2

theo_diff_h = (rdim./2).*log2(2.*pi.*exp(1).*sig_x.*sig_x);
analyt_H = theo_diff_h - rdim*log2(bw);

H_err_slope = [1 sig_x]*sb;
H_err_yint = [1 sig_x]*yb;

Ns = 10^((log10(tol*analyt_H) - H_err_yint)/H_err_slope);
% Ns = 10^(ceil((log10(tol*analyt_H) - H_err_yint)/H_err_slope));

if Ns < 1e6
    Ns = 1e6;
end

Ns = round(Ns);
%if specific intervals of Nsamps mattered to me, I could do this instead
% H_err_extrap = 10.^(H_err_slope.*log10(Nsamps) + H_err_yint);
% H_err_percent = H_err_extrap./analyt_H;
% 
% ind_N = find(H_err_percent<tol,1);
% 
% Ns = Nsamps(ind_N);
