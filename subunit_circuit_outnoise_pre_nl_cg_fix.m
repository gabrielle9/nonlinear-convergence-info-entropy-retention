function [resps] = subunit_circuit_outnoise_pre_nl_cg_fix(stimstem,sig_n,sig_m,subthreshs,nlout,out_threshs,varargin)
% assumes rdim = 2
% makes a portion of the subunit noise correlated and the rest uncorrelated between outputs
% ro_n is the desired correlation coefficient for the subunit noise between
% outputs - it is between 0 and 1
% sets ReLU threshold

minArgs = 6;
maxArgs = 7;
narginchk(minArgs,maxArgs)

[sdim,Nstim] = size(stimstem);

if nargin == maxArgs
    ro_n = varargin{1};
    if (ro_n>1)||(ro_n<0)
        sprintf('error')
    end
else
    ro_n = 0; % uncorrelated subnoise by default
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
ONsub_resps(ONsub_resps<subthreshs(1)) = subthreshs(1);
OFFsub_resps(OFFsub_resps<subthreshs(2)) = subthreshs(2);

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

% apply any nonlin to outputs
switch nlout
    case 'relu'
        % output noise before output nonlinearity
        ON_resps1 = ON_resps1 + outnoiseON; % Nstim x 1, i.e. 1D linear output response
        OFF_resps1 = OFF_resps1 + outnoiseOFF; % Nstim x 1, i.e. 1D linear output response
        
        ON_resps1(ON_resps1<out_threshs(1)) = out_threshs(1);
        OFF_resps1(OFF_resps1<out_threshs(2)) = out_threshs(2);
        
    case 'linear'
        % output noise before output nonlinearity
        ON_resps1 = ON_resps1 + outnoiseON; % Nstim x 1, i.e. 1D linear output response
        OFF_resps1 = OFF_resps1 + outnoiseOFF; % Nstim x 1, i.e. 1D linear output response
        
    case 'cg'
        % if linear subunits and assuming sig_s = 10
        mmin = -48.65;
        mmax = 48.65;
        resprange = mmax - mmin;
        mean_resp = 0;
        sig_resp = 10;
        
        if subthreshs == [0 0]
            mmin = [1 sdim]*[-0.1157;0.0143];
            mmax = [1 sdim]*[47.5726;0.2698];
            sig_resp = [1 sdim]*[5.8379;0];
            mean_resp = [1 sdim]*[5.6914;0.6134];
            resprange = mmax - mmin;
        end
        
        % output noise before output nonlinearity
        ON_resps1 = ON_resps1 + outnoiseON; % Nstim x 1, i.e. 1D linear output response
        OFF_resps1 = OFF_resps1 + outnoiseOFF; % Nstim x 1, i.e. 1D linear output response
        
        % apply CG nonlin after noise but use pre-noise CG params
%         ON_resps1 = resprange_ON.*normcdf(ON_resps1,mean_ON,std_ON) + min_ON; %cumulative gaussian
%         OFF_resps1 = resprange_OFF.*normcdf(OFF_resps1,mean_OFF,std_OFF) + min_OFF; %cumulative gaussian
        ON_resps1 = resprange.*normcdf(ON_resps1,mean_resp,sig_resp) + mmin; %cumulative gaussian
        OFF_resps1 = resprange.*normcdf(OFF_resps1,mean_resp,sig_resp) + mmin; %cumulative gaussian
end

resps = [ON_resps1,OFF_resps1]; % Nstim x rdim, 2D output response



