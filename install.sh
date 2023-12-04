#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "ERROR! Illegal number of parameters. Usage: bash install.sh conda_install_path environment_name"
    exit 0
fi

conda_install_path=$1
conda_env_name=$2

source $conda_install_path/etc/profile.d/conda.sh
echo "****************** Creating conda environment ${conda_env_name} python=3.7 ******************"
conda create -y --name $conda_env_name python=3.6.13

echo ""
echo ""
echo "****************** Activating conda environment ${conda_env_name} ******************"
conda activate $conda_env_name

echo ""
echo ""
echo "****************** Installing pytorch with cuda10 ******************"
#conda install -y pytorch torchvision cudatoolkit=10.0 -c pytorch
#conda install -y pytorch==1.4.0 torchvision==0.5.0 cudatoolkit=10.0 -c pytorch
#as of december 2023, torchvision==0.5.0 is not found in common channels. Added "-c conda-forge"
pip install torch==1.4.0 torchvision==0.5.0  -f http://www-vpu.eps.uam.es/~jcs/DLVSP/pkgs/torch_stable_dlvsp.html

echo ""
echo ""
echo "****************** Installing matplotlib ******************"
conda install -y matplotlib=3.3.4

echo ""
echo ""
echo "****************** Installing pandas ******************"
conda install -y pandas=1.1.5

echo ""
echo ""
echo "****************** Installing tqdm ******************"
conda install -y tqdm=4.62.3

echo ""
echo ""
echo "****************** Installing opencv ******************"
pip install opencv-python==4.5.4.60

echo ""
echo ""
echo "****************** Installing tensorboard ******************"
#pip install tb-nightly==2.8.0
#as of december 2023, tb-nightly==2.8.0 shows several installing errors
pip install tensorboard==2.10.1


echo ""
echo ""
echo "****************** Installing visdom ******************"
pip install visdom==0.1.8.9

echo ""
echo ""
echo "****************** Installing scikit-image ******************"
pip install scikit-image

echo ""
echo ""
echo "****************** Installing tikzplotlib ******************"
pip install tikzplotlib==0.9.12

echo ""
echo ""
echo "****************** Installing gdown ******************"
pip install gdown==4.2.0

echo ""
echo ""
echo "****************** Installing cython ******************"
conda install -y cython=0.29.24

echo ""
echo ""
echo "****************** Installing coco toolkit ******************"
pip install pycocotools==2.0.3

echo ""
echo ""
echo "****************** Installing LVIS toolkit ******************"
pip install lvis==0.5.3


#echo ""
#echo ""
#echo "******** Installing spatial-correlation-sampler. Note: This is required only for KYS tracker **********"
#pip install spatial-correlation-sampler

echo ""
echo ""
echo "****************** Installing jpeg4py python wrapper ******************"
pip install jpeg4py==0.1.4

echo ""
echo ""
echo "****************** Installing ninja-build to compile PreROIPooling ******************"
echo "************************* Need sudo privilege ******************"
#sudo apt-get install ninja-build

echo ""
echo ""
echo "****************** Downloading networks ******************"
mkdir pytracking/networks

echo ""
echo ""
echo "****************** DiMP50 Network ******************"
# gdown https://drive.google.com/uc\?id\=1qgachgqks2UGjKx-GdO1qylBDdB1f9KN -O pytracking/networks/dimp50.pth
# gdown https://drive.google.com/uc\?id\=1MAjrRJDCbL0DSjUKFyDkUuYS1-cYBNjk -O pytracking/networks/dimp18.pth

# echo ""
# echo ""
# echo "****************** ATOM Network ******************"
# gdown https://drive.google.com/uc\?id\=1VNyr-Ds0khjM0zaq6lU-xfY74-iWxBvU -O pytracking/networks/atom_default.pth

# echo ""
# echo ""
# echo "****************** ECO Network ******************"
# gdown https://drive.google.com/uc\?id\=1aWC4waLv_te-BULoy0k-n_zS-ONms21S -O pytracking/networks/resnet18_vggmconv1.pth

echo ""
echo ""
echo "****************** Setting up environment ******************"
python -c "from pytracking.evaluation.environment import create_default_local_file; create_default_local_file()"
python -c "from ltr.admin.environment import create_default_local_file; create_default_local_file()"


#echo ""
#echo ""
#echo "****************** Installing jpeg4py ******************"
#while true; do
#    read -p "Install jpeg4py for reading images? This step required sudo privilege. Installing jpeg4py is optional, however recommended. [y,n]  " install_flag
#    case $install_flag in
#        [Yy]* ) sudo apt-get install libturbojpeg; break;;
#        [Nn]* ) echo "Skipping jpeg4py installation!"; break;;
#        * ) echo "Please answer y or n  ";;
#    esac
#done

echo ""
echo ""
echo "****************** Installation complete! ******************"

echo ""
echo ""
echo "****************** More networks can be downloaded from the google drive folder https://drive.google.com/drive/folders/1WVhJqvdu-_JG1U-V0IqfxTUa1SBPnL0O ******************"
echo "****************** Or, visit the model zoo at https://github.com/visionml/pytracking/blob/master/MODEL_ZOO.md ******************"
