#!/bin/bash
#
# Scripts which download checkpoints for provided models.
#

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"



# Download ensemble adversarially trained inception resnet v2 & inception.v3 concat checkpoint
# into ens_adv_inception_resnet_v2_drop_resize subdirectory
cd "${SCRIPT_DIR}/CrossIterative_3/"
wget https://storage.googleapis.com/voilin_test/ens_incept.tar.gz
tar -xvzf ens_incept.tar.gz
rm ens_incept.tar.gz
