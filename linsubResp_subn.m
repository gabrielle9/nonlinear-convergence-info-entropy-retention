function [resps] = linsubResp_subn(stimstem,sig_n,sig_m,varargin);
% Generates ON and OFF linear output response from linear subunits
% stimstem is an sdim x Nstim matrix of stimulus values where sdim is the
% number of subunits (or inputs) and Nstim is the number of samples.

% sig_n is the standard deviation of the gaussian noise that enters the
% subunits. It is effectively noise that is added to the stim. 

% sig_m is the standard deviation of the gaussian noise that is added to
% the output.

% varargin allows for an additional variable, ro_n, which is a correlation
% coefficient for the subunit noise. 0 <= ro_n <= 1 and when ro_n is 1, the
% subunit noise is entirely correlated between the ON and OFF outputs; when 
% ro_n = 0, the noise in the subunits is entirely independent between the ON and OFF outputs.
% If varargin is empty, ro_n = 0.5 by default.
% The subunit noise is always independent among the subunits in this code.

% This function assumes that the output consists of an ON and an OFF cell
% that have overlapping receptive fields and therefore receive the same
% stimulus.

minArgs = 3;
maxArgs = 4;
narginchk(minArgs,maxArgs)

[sdim,Nstim] = size(stimstem);

if nargin == 4
    ro_n = varargin{1};
    if (ro_n>1)||(ro_n<0)
        sprintf('error')
    end
else
    ro_n = 0.5; % half-correlated subnoise by default
end

sig_n1 = sig_n*sqrt(ro_n); % for correlated part
sig_n2 = sig_n*sqrt(1-ro_n); % for uncorrelated part

subnoise = sig_n1.*randn(size(stimstem)); % correlated between outputs
subnoise_on = sig_n2.*randn(size(stimstem)); % subunit noise for ON only so that it is uncorrelated between outputs
subnoise_off = sig_n2.*randn(size(stimstem)); % subunit noise for OFF only so that it is uncorrelated between outputs

ONsub_resps = stimstem + subnoise + subnoise_on; %sdim x Nstim
OFFsub_resps = -(stimstem + subnoise + subnoise_off); %sdim x Nstim

outnoiseON = sig_m.*randn(Nstim,1);
outnoiseOFF = sig_m.*randn(Nstim,1);

% should work for any sdim
if sdim > 1
    ON_resps1 = sum(ONsub_resps)' + outnoiseON; % Nstim x 1, i.e. 1D linear output response
    OFF_resps1 = sum(OFFsub_resps)' + outnoiseOFF; % Nstim x 1, i.e. 1D linear output response
else
    ON_resps1 = ONsub_resps' + outnoiseON; % Nstim x 1, i.e. 1D linear output response
    OFF_resps1 = OFFsub_resps' + outnoiseOFF; % Nstim x 1, i.e. 1D linear output response
end

resps = [ON_resps1,OFF_resps1]; % Nstim x rdim

        

