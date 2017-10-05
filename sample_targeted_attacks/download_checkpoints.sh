#!/bin/bash
#
# Scripts which download checkpoints for provided models.
#

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"



# Download ensemble adversarially trained inception resnet v2 & inception.v3 concat checkpoint
# into CrossIterative_target_20 subdirectory
cd "${SCRIPT_DIR}/CrossIterative_target_20/"
wget https://storage.googleapis.com/voilin_test/ens_incept.tar.gz
tar -xvzf ens_incept.tar.gz
rm ens_incept.tar.gz
