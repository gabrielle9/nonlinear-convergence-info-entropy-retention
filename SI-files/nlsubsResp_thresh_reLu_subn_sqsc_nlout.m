function [resps] = nlsubsResp_thresh_reLu_subn_sqsc_nlout(stimstem,sig_n,sig_m,threshes,nlout,varargin)
% assumes rdim = 2
% makes a portion of the subunit noise correlated and the rest uncorrelated between outputs
% ro_n is the desired correlation coefficient for the subunit noise between
% outputs - it is between 0 and 1
% sets ReLU threshold

minArgs = 5;
maxArgs = 6;
narginchk(minArgs,maxArgs)

[sdim,Nstim] = size(stimstem);

if nargin == 6
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

linONsub_resps = (stimstem + subnoise + subnoise_on); %sdim x Nstim
linOFFsub_resps = -(stimstem + subnoise + subnoise_off); %sdim x Nstim

ONsub_resps = linONsub_resps;
OFFsub_resps = linOFFsub_resps;
% ONsub_resps(ONsub_resps<0) = 0; %reLu
% OFFsub_resps(OFFsub_resps<0) = 0; %reLu
ONsub_resps(ONsub_resps<threshes(1)) = threshes(1);
OFFsub_resps(OFFsub_resps<threshes(2)) = threshes(2);

% ONsub_resps = log(1+exp(linONsub_resps)); %softplus
% OFFsub_resps = log(1+exp(linOFFsub_resps)); %softplus

ONsub_resps = ONsub_resps./sqrt(sdim); %sdim x Nstim
OFFsub_resps = OFFsub_resps./sqrt(sdim); %sdim x Nstim

outnoiseON = sig_m.*randn(Nstim,1); %independent output noise
outnoiseOFF = sig_m.*randn(Nstim,1);

% should work for any sdim
if sdim > 1
    ON_resps1 = sum(ONsub_resps)'; % Nstim x 1, i.e. 1D linear output response
    OFF_resps1 = sum(OFFsub_resps)'; % Nstim x 1, i.e. 1D linear output response
else
    ON_resps1 = ONsub_resps'; % Nstim x 1, i.e. 1D linear output response
    OFF_resps1 = OFFsub_resps'; % Nstim x 1, i.e. 1D linear output response
end

switch nlout
    case 'relu'
    ON_resps1(ON_resps1<0) = 0;
    OFF_resps1(OFF_resps1<0) = 0;
    
    case 'cg'
    resprange1 = max(ON_resps1)-min(ON_resps1);
    ON_resps1 = resprange1.*normcdf(ON_resps1,mean(ON_resps1),std(ON_resps1)) + min(ON_resps1); %cumulative gaussian
    
    resprange2 = max(OFF_resps1)-min(OFF_resps1);
    OFF_resps1 = resprange2.*normcdf(OFF_resps1,mean(OFF_resps1),std(OFF_resps1)) + min(OFF_resps1); %cumulative gaussian
end
    
    
ON_resps1 = ON_resps1 + outnoiseON; % Nstim x 1, i.e. 1D linear output response
OFF_resps1 = OFF_resps1 + outnoiseOFF; % Nstim x 1, i.e. 1D linear output response

resps = [ON_resps1,OFF_resps1]; % Nstim x rdim, 2D output response

        

