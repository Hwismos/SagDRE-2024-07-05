#! /bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=cpu1
##
#SBATCH --job-name=csh
#SBATCH -o slurm/sout/2024-07-05/SLURM.%j.csh.out
#SBATCH -e slurm/serr/2024-07-05/SLURM.%j.csh.err
##
#SBATCH --nodelist=n020

hostname
date

export CUDA_VISIBLE_DEVICES=0

model_name=SAGDRE_BERT_base
lr=0.001
batch_size=16
test_batch_size=16
epoch=40
test_epoch=5
save_model_freq=1
negativa_alpha=4

/home2/csh102/anaconda3/envs/240504-gnn-survey/bin/python3.10 src_docred/train.py \
  --train_set data/DocRED/train_annotated.json \
  --dev_set data/DocRED/dev.json \
  --test_set data/DocRED/test.json \
  --use_model bert \
  --model_name ${model_name} \
  --lr ${lr} \
  --batch_size ${batch_size} \
  --test_batch_size ${test_batch_size} \
  --epoch ${epoch} \
  --test_epoch ${test_epoch} \
  --save_model_freq ${save_model_freq} \
  --negativa_alpha ${negativa_alpha} \
  --gcn_layers 2 \
  --bert_hid_size 768 \
  --gcn_dim 128 \
  --dropout 0.4 \
  --activation relu \
  --use_entity_type \
  --use_entity_id \
  --coslr
