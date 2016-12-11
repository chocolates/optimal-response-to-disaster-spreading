#!/bin/bash
module load matlab

# grid network
for strategy in S0 S1 S2 S3 S4 S5 S6
do
	sed "38s/.*/model.strategy = '$strategy'; % Strategy/" initialise_parameters.m > tmp.m
	rm initialise_parameters.m
	mv tmp.m initialise_parameters.m
	# echo "$strategy"
	matlab -nodisplay -nodesktop -r "run main_forward.m"
done


# scale-free network
sed "6s/.*/model.NetworkType = 'SF'; % /" initialise_parameters.m > tmp.m
rm initialise_parameters.m
mv tmp.m initialise_parameters.m

for strategy in S0 S1 S2 S3 S4 S5 S6
do
	sed "38s/.*/model.strategy = '$strategy'; % Strategy/" initialise_parameters.m > tmp.m
	rm initialise_parameters.m
	mv tmp.m initialise_parameters.m
	# echo "$strategy"
	matlab -nodisplay -nodesktop -r "run main_forward.m"
done