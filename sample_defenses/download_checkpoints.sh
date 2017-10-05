#!/bin/bash
#
# Scripts which download checkpoints for provided models.
#

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


# Download ensemble adversarially trained inception resnet v2 checkpoint
# into ens_adv_inception_resnet_v2_DropOutFocus_200 subdirectory
cd "${SCRIPT_DIR}/ens_adv_inception_resnet_v2_DropOutFocus_200/"
wget http://download.tensorflow.org/models/ens_adv_inception_resnet_v2_2017_08_18.tar.gz
tar -xvzf ens_adv_inception_resnet_v2_2017_08_18.tar.gz
rm ens_adv_inception_resnet_v2_2017_08_18.tar.gz
