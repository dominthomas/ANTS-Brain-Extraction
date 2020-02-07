#! /bin/bash
# Extract brains from the 't1w' directory.

module load ANTs

# Set number of threads as environment variable.
export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=128
export ANTSPATH=/mmfs1/shares/hpc/OS/centos/7_5/EasyBuild/software/ANTs/2.3.1-foss-2018b-Python-3.6.6/bin/


for file in /home/k1651915/t1w1/*
do
	filename=$(basename -- "$file")
	filename="${filename%.*.*}"

	start=`date +%s`
	./antsBrainExtraction.sh -d 3 -a "$file" -e templates/T_template0.nii.gz -m templates/T_template0_BrainCerebellumProbabilityMask.nii.gz -f templates/T_template0_BrainCerebellumRegistrationMask.nii.gz -o "output/${filename}"
	rm "$file"
	end=`date +%s`
	echo "$(($end - $start))" >> time.txt
done

#tar czf extractions.tar.gz output
