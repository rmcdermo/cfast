% McGrattan
% March 21, 2011
% CFAST_verification_script.m
%
% This script creates the plots that are included in the CFAST V&V
% Guide. It consists of calls to other scripts contained within the
% subfolder called "scripts". 
%
% The most important script is called dataplot. It reads the file called
% validation_data_config_matlab.csv and generates 1000+ plots. If you
% want to process only some of these plots, comment out the other 
% scripts and change the data plot line as follows:
%
% [saved_data,drange] = dataplot(cfil,vdir,plotdir,[a:b]);
%
% where a and b are the lines in the .csv file you want to process.
% Alternatively, you can specify the "Dataname" you want:
%
% [saved_data,drange] = dataplot(cfil,vdir,plotdir,'WTC');
%
% In this case, all the WTC results will be plotted. 

close all
clear all

addpath 'scripts'

% Scripts that run prior to dataplot

data_dir = '../../Verification/Mass_Balance/';
speciesmass(data_dir);

data_dir = '../../Verification/Fires/';
fire_ignition(data_dir);

data_dir = '../../Verification/Sprinkler/';
sprinkler_1(data_dir);

data_dir = '../../Verification/Radiation/';
radiativefluxes(data_dir);

data_dir = '../../Verification/Target/';
target_2(data_dir);

% dataplot creates most of the plots for the Validation Guide. It must be run before scatplot, which makes the scatter plots.

Dataplot_Inputs_File = [pwd, '/CFAST_verification_dataplot_inputs.csv'];
Working_Dir = '../../Verification/';
Manuals_Dir = '../../Manuals/CFAST_Validation_Guide/';
Scatterplot_Inputs_File = [pwd, '/CFAST_verification_scatterplot_inputs.csv'];

% Statistics output options

Stats_Output = 'Verification';
Output_File = [pwd, '/CFAST_verification_scatterplot_output.csv'];
Statistics_Tex_Output = [pwd, '/../../Manuals/CFAST_Validation_Guide/SCRIPT_FIGURES/Verification/verification_statistics.tex'];

% Run dataplot and scatplot scripts

[saved_data,drange] = dataplot(Dataplot_Inputs_File, Working_Dir, Working_Dir, Manuals_Dir);
scatplot(saved_data, drange, ...
         'Scatterplot_Inputs_File', Scatterplot_Inputs_File, ...
         'Manuals_Dir', Manuals_Dir, ...
         'Output_File', Output_File, ...
         'Stats_Output', Stats_Output, ...
         'Statistics_Tex_Output', Statistics_Tex_Output)

% Special Cases

display('Verification scripts completed successfully!')
