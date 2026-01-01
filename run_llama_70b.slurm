#!/bin/bash
#SBATCH --job-name=llama_70b_privacy_qa
#SBATCH --output=/scratch/asing725/CSE336/privacy_qa/batch_results/llama_70b_%j.log
#SBATCH --error=/scratch/asing725/CSE336/privacy_qa/batch_results/llama_70b_%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:4
#SBATCH --mem=110GB
#SBATCH --time=4:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=asing725@asu.edu

# Print job information
echo "Job ID: $SLURM_JOB_ID"
echo "Job Name: $SLURM_JOB_NAME"
echo "Node: $SLURM_NODELIST"
echo "Starting time: $(date)"
echo "Working directory: $SLURM_SUBMIT_DIR"
echo ""

# Load required modules (adjust based on ASU Sol's module system)
module purge
module load mamba/latest

# Activate your conda environment (adjust the environment name as needed)
# If you don't have an environment, you'll need to create one with papermill installed
source activate ranker

# Create output directory if it doesn't exist
mkdir -p /scratch/asing725/CSE336/privacy_qa/batch_results

# Set model name
MODEL_NAME="meta-llama/Llama-3.3-70B-Instruct"

# Run papermill
echo "Running papermill with MODEL_NAME: $MODEL_NAME"
papermill /scratch/asing725/CSE336/privacy_qa/final_all_batch.ipynb \
    /scratch/asing725/CSE336/privacy_qa/batch_results/final_all_batch_llama3.3_70b.ipynb \
    -p MODEL_NAME "$MODEL_NAME" -p NUM_GPUS 4

# Print completion information
echo ""
echo "Job completed at: $(date)"
echo "Exit status: $?"
