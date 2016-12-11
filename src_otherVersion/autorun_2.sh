#!/bin/bash
module load matlab

bsub -W 1:00 matlab -nodesktop -nosplash -r "run main_forward_2.m; quit"