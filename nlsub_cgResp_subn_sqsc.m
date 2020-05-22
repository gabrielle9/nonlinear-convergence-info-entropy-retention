function [resps] = nlsub_cgResp_subn_sqsc(stimstem,sig_n,sig_m,varargin)
% assumes rdim = 2
% makes a portion of the subunit noise correlated and the rest uncorrelated between outputs
% ro_n is the desired correlation coefficient for the subunit noise between
% outputs - it is between 0 and 1
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

linONsub_resps = (stimstem + subnoise + subnoise_on)./sqrt(sdim); %sdim x Nstim
linOFFsub_resps = -(stimstem + subnoise + subnoise_off)./sqrt(sdim); %sdim x Nstim

ONsub_resps = linONsub_resps;
OFFsub_resps = linOFFsub_resps;
ONsub_resps(ONsub_resps<0) = 0; %reLu subunits
OFFsub_resps(OFFsub_resps<0) = 0; %reLu subunits

% ONsub_resps = log(1+exp(linONsub_resps)); %softplus
% OFFsub_resps = log(1+exp(linOFFsub_resps)); %softplus

outnoiseON = sig_m.*randn(Nstim,1); %independent output noise
outnoiseOFF = sig_m.*randn(Nstim,1);

% should work for any sdim
% cumulative gaussian output nonlinearity
if sdim > 1
    ONsub_resps = sum(ONsub_resps)';
    resprange1 = max(ONsub_resps)-min(ONsub_resps);
    ON_resps1 = resprange1.*normcdf(ONsub_resps,mean(ONsub_resps),std(ONsub_resps)); %cumulative gaussian
    ON_resps1 = ON_resps1 + outnoiseON; % Nstim x 1, i.e. 1D linear output response
    
    OFFsub_resps = sum(OFFsub_resps)';
    resprange2 = max(OFFsub_resps)-min(OFFsub_resps);
    OFF_resps1 = resprange2.*normcdf(OFFsub_resps,mean(OFFsub_resps),std(OFFsub_resps)); %cumulative gaussian
    OFF_resps1 = OFF_resps1 + outnoiseOFF; % Nstim x 1, i.e. 1D linear output response
else
    resprange1 = max(ONsub_resps)-min(ONsub_resps);
    ON_resps1 = resprange1.*normcdf(ONsub_resps,mean(ONsub_resps),std(ONsub_resps)); %cumulative gaussian
    ON_resps1 = ON_resps1' + outnoiseON; % Nstim x 1, i.e. 1D linear output response
    
    resprange2 = max(OFFsub_resps)-min(OFFsub_resps);
    OFF_resps1 = resprange2.*normcdf(OFFsub_resps,mean(OFFsub_resps),std(OFFsub_resps)); %cumulative gaussian
    OFF_resps1 = OFF_resps1' + outnoiseOFF; % Nstim x 1, i.e. 1D linear output response
end

resps = [ON_resps1,OFF_resps1]; % Nstim x rdim, 2D output response

        

