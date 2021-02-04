# nonlinear-convergence-info-entropy-retention
Code for model and analysis of study of information preservation in a nonlinear convergent neural circuit

subunit_circuit_outnoise_pre_nl_fix.m is a response-generating function that takes a stimulus matrix and other parameters to generate a matrix with output responses. The stimulus matrix must be sdim x Nstim where sdim is the number of input dimensions (i.e. image pixels) which will also be the number of model subunits. Nstim is the number of stimulus samples (i.e. number of trials). The function returns a Nstim x 2 matrix where the columns are the ON and OFF responses, respectively.

binnedH*.m files are functions that compute and return binned entropy. See comments in code for inputs.

H_binned_nDin_circuits.m computes the binned entropies of the output responses from the circuit configurations studied in our paper: "Nonlinear convergence boosts information coding in circuits with parallel outputs".

In the Visualizations-and-Figures folder, the scripts produce the figures in our paper.

Fig. 2: nDin_plots_hist_binH_normed.m

Fig. 3: stim_sub_resp_space_quads_2Din_2Dout.m

Fig. 4: Mean_contrast_visualization.m
