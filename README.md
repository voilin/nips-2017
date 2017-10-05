# nips-2017

This repository contains submission of three Competitions on Kaggle.

[Non-targeted Adversarial Attack](https://www.kaggle.com/c/nips-2017-non-targeted-adversarial-attack)

[Defense Against Adversarial Attack](https://www.kaggle.com/c/nips-2017-defense-against-adversarial-attack)

[Targeted Adversarial Attack](https://www.kaggle.com/c/nips-2017-targeted-adversarial-attack)


You can check reference the original toolkit. 
[Development toolkit for participants of adversarial competition](https://github.com/tensorflow/cleverhans/tree/master/examples/nips17_adversarial_competition)


## Dependencies
* Python 2.7
* Numpy
* Pillow
* Docker
* nvidia-docker  # if gpu enable



## Quick Start
To download the dataset and all checkpoints run following:
```bash
./download_data.sh
```

To run all attacks and defenses:
```bash
./run_attacks_and_denfenses.sh  # remember to delete --gpu if you want to run it on CPU
```


## Ideas
The competition's goal is to find attack / defense on the majority of all the submissions.

### Non-targeted Adversarial Attack

### CrossIterative_3
If condidering the majority of defense model are from "base_inception_model" and "ens_adv_inception_resnet_v2", but FGSM or BasicIterativeMethod of FGSM both have weak transferability. 
Therefore, let's try to count gradient iteratively on both defense models. The following is one of sample scores:

```
AttackName,Score
bim_both_2,            4638
bim_both_3,            4506
bim_both_4,            4232
bim_inception_v3_10,   4203
bim_both_1,            4154
bim_both_5,            3937
fgsm_inception_v3,     3348
bim_ens_insRes_v2_10,  2527
fgsm_ens_insRes_v3,    2298
random_noise,           995
noop,                   875
```

* number after name is the iteration number
* both is CrossIterative method


For BasicIterativeMethod on FGSM, attack success rate rise when iter-number is higher on "the model attacked". When looking back to CrossIterative, maximum appears when iter-number = 2. Besides, I notice that each FGSM target in CrossIterative shouldn't be affected by another (model's top predict), because of its weak transferability.

I suppose before iter-number = 2 or 3, the attack target is correct just like the orignal label, but after that, the target is not correct, and it start to randomly attack the gradient signal that the other attack make, that will make the true lable appear. 

Possibilities: Maybe it can reach better performance if selecting the true label as target. The label leaking might be disappear when another model attack.

### Targeted Adversarial Attack

### CrossIterative_target_20
As mentioned, condidering the majority of defense model are from "base_inception_model" and "ens_adv_inception_resnet_v2". The following is one of sample scores:

```
AttackName,Score
iter_target_class_both_20,2241
iter_target_class_both_10,1482
iter_target_class_20,1439
iter_target_class_ens_20,836
```

* number after name is the iteration number
* both is CrossIterative method

For CrossIterative, it's much simpler when target is always the same, so higher iter-number can generate feature for both attack model. So I pick iter-number = 20 to ensure it can generate 100 images in 500 sec.

### Defense Against Adversarial Attack

### ens_adv_inception_resnet_v2_DropOutFocus_200
There are common way to defense, adversarial training and distillation. Adversarial training need time and equipment. Distillation is not fit the competition's rule. 
So, let's try to find a way to remove attack signal first before feed-forward.

The following are two of sample scores:

```
DefenseName,Score
ens_adv_inception_resnet_v2_drop_resize_200,16519
ens_adv_inception_resnet_v2_drop_resize_100,15495
ens_adv_inception_resnet_v2,11526
base_inception_model_drop_resize_100,11204
base_inception_model,10648
base_inception_model_drop_resize_200,10536
```

```
DefenseName,Score
ens_adv_inception_resnet_v2_drop_resize_200,12357
ens_adv_inception_resnet_v2_drop_resize_250,12283
ens_adv_inception_resnet_v2_drop_resize_250_200,12265
ens_adv_inception_resnet_v2,8383
base_inception_model_drop_resize_200,7061
base_inception_model_drop_resize_250_200,6971
base_inception_model_drop_resize_250,6619
base_inception_model,5491
```

* number after name is the resize size
* drop means enable dropout in network

It includes two concepts:

(1) dropout
Enable Dropout in network, which can slightly increase its score.

(2) resize
Resize to smaller and resize back before feed-forward. Then, you can tell that there are trade-off between the images features and attack signals on the resize size. Pick 200 base on experiments.


I suppose the resize works because it can directly average the max pooling, which can remove the attack signals.

Possibilities: The method to remove attack signal before network can be replace by another neural network like auto-encoder. And it should be trained on large scale attack images.


## License Acknowledgement
This code is derived from the sample code in CleverHans examples.

### CleverHans

https://github.com/tensorflow/cleverhans
Copyright (c) 2017 Google Inc., OpenAI and Pennsylvania State University. Licensed under the MIT License.