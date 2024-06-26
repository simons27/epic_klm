Simple slurm script for running ddsim simulations with epic_klmws.xml geometry.

To run many simulations:
1. Adjust eic path to fit your setup
2. adjust command line parameters like number of particles and particle species
3. run ./makeJobs.sh (should create any required directories)
4. run ./runJobs.sh
Note: you may have to adjust sbatch commands to fit your setup like the account name or partition

To run one simulation:
1. Edit the job.sh script to have correct paths instead of /path/to/...
2. Create output and error directories (e.g. /work_eic/slurm/output/ and /work_eic/slurm/error/) so they match the slurm directive
3. Adjust the ddsim command (# of particles, output directory)
4. Run `sbatch jobs.sh` from the slurm directory to submit the job
5. Debugging the slurm functionality may be easier by running srun so that you can see output and errors in the terminal.
