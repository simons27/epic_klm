#!/bin/bash
current_date=$(date +"%B_%d")
# EDIT THIS PATH
eicdir="/path/to/eic"
#EDIT ABOVE PATH (rest of the paths are based on this)
epic_klm_dir="${eicdir}/epic_klm"
slurmdir="${epic_klm_dir}/simulations/slurm"

output_dir="${eicdir}/simulations/root_files"
slurm_output_dir="${output_dir}/slurm"
daydir="${slurm_output_dir}/${current_date}"
#USER SET VALUES
outputdir="${daydir}/Run_0/"
standard_output_dir="${slurmdir}/output"
standard_error_dir="${slurmdir}/error"
out_folder="${slurmdir}/output/output${current_date}"
error_folder="${slurmdir}/error/error${current_date}"

rootname="file_"
runJobs="${slurmdir}/runJobs.sh"
touch $runJobs
chmod +x $runJobs
echo " " > $runJobs
echo $daydir
i=0

if [ ! -d "$daydir" ]; then
  mkdir "$daydir"
fi

if [ ! -d "$outputdir" ]; then
  mkdir "$outputdir"
fi

if [ ! -d "$out_folder" ]; then
  mkdir "$out_folder"
fi

if [ ! -d "$error_folder" ]; then
  mkdir "$error_folder"
fi

if [ ! -d "$standard_output_dir" ]; then
  mkdir "$standard_output_dir"
fi

if [ ! -d "$standard_error_dir" ]; then
  mkdir "$standard_error_dir"
fi

for num in $(seq 1 40)
do
    file="${slurm_output_dir}/shells/${rootname}${i}.sh"
    touch $file
    content="#!/bin/bash\n"
    content+="#SBATCH --account=vossenlab\n"
    content+="#SBATCH -p common\n"
    content+="#SBATCH --mem=8G\n"
    content+="#SBATCH --job-name=${rootname}${i}\n"
    content+="#SBATCH --cpus-per-task=1\n"
    content+="#SBATCH --time=24:00:00\n"
    content+="#SBATCH --chdir=${epic_klm_dir}\n"
    content+="#SBATCH --output=${out_folder}/%x.out\n"
    content+="#SBATCH --error=${error_folder}/%x.err\n"
    content+="cat << EOF | ${eicdir}/eic-shell\n"
    content+="source install/setup.sh\n"
    content+="/usr/local/bin/ddsim --steeringFile simulations/steering/npsim_local3.py --compactFile ${epic_klm_dir}/epic_klmws_only.xml -G -N 30 --gun.particle \"pi-\" --outputFile ${outputdir}pi_5GeV_30events_run_0_file_${i}.edm4hep.root --part.userParticleHandler=\"\"\n"
    content+="EOF\n"
    echo -e "$content" > $file 
    echo "sbatch shells/${rootname}${i}.sh" >> $runJobs
    i=$((i+1))
done
