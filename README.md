# nonlinear-convergence-info-entropy-retention
Code for model and analysis of study of information preservation in a nonlinear convergent neural circuit

linsubResp_subn.m, linsub_reluResp_subn.m, and nlsubsResp_reLu_subn.m are functions that take a stimulus matrix and generate output responses. The stimulus matrix must be sdim x Nstim where sdim is the number of input dimensions (i.e. image pixels) which will also be the number of model subunits. Nstim is the number of stimulus samples (i.e. number of trials).

binnedHr.m is a function that computes the binned entropy of an output response distribution specified by the input parameters.

H_binned_circuits.m computes the binned entropies of the output responses from the circuit configurations studied in our paper: "Nonlinear convergence preserves information".
