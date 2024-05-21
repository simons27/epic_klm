#!/bin/bash  
#SBATCH --job-name=KLM_sim
#SBATCH --output=/path/to/eic/work_eic/slurm/output/outputMay20/%x.out
#SBATCH --error=/path/to/eic/work_eic/slurm/error/errorMay20/%x.err
#SBATCH -p vossenlab-gpu
#SBATCH --account=vossenlab
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
echo began job
cd /path/to/eic/epic_klm
cat << EOF | /path/to/eic/eic-shell
source install/setup.sh
echo $DETECTOR_PATH
/usr/local/bin/ddsim --steeringFile simulations/steering/npsim_local3.py --compactFile /path/to/eic/epic_klm/epic_klmws_only.xml -G -N 10 --gun.particle "mu-" --outputFile ../path/to/root_output_directory/mu_5GeV_10events_run_1.edm4hep.root --part.userParticleHandler=""
EOF
