datapath=/home/hirotonakata/Desktop/VSCode_Project/dataset/mvtec_anomaly_detection/
loadpath=/home/hirotonakata/Desktop/VSCode_Project/PatchCore/patchcore-inspection/results/MVTecAD_Results/

modelfolder=test
# modelfolder=IM224_Ensemble_L2-3_P001_D1024-384_PS-3_AN-1
savefolder=evaluated_results'/'$modelfolder

#datasets=('bottle'  'cable'  'capsule'  'carpet'  'grid'  'hazelnut' 'leather'  'metal_nut'  'pill' 'screw' 'tile' 'toothbrush' 'transistor' 'wood' 'zipper')
datasets=('bottle')
model_flags=($(for dataset in "${datasets[@]}"; do echo '-p '$loadpath'/'$modelfolder'/models/mvtec_'$dataset; done))
dataset_flags=($(for dataset in "${datasets[@]}"; do echo '-d '$dataset; done))

python bin/load_and_evaluate_patchcore.py --gpu 0 --seed 0 $savefolder \
patch_core_loader "${model_flags[@]}" \
dataset --resize 256 --imagesize 224 "${dataset_flags[@]}" mvtec $datapath
