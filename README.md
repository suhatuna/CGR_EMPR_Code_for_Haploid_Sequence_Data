# CGR_EMPR_Code_for_Haploid_Sequence_Data
The present repository is created for performing computational tasks for the method for evaluating variants in Gene-Networks using high dimensional modelling. Please see the README file for further information. All results are to be published in the following link: https://assets.researchsquare.com/files/rs-1343509/v1_covered.pdf?c=1647356533

The details of the work whose link is provided above are as follows:

Title: 
    Gene Teams are on the Field: Evaluation of Variants in Gene-Networks Using High Dimensional Modelling
  
Abstract:
    Variation is a key concept in every biological aspect, particularly in medical genetics. In this field, each genetic variant is evaluated mostly as an independent entity in respect to its clinical importance. This approach may be sufficient to detect the pathogenic variants in single-gene disorders. However, in most of the complex diseases, the combination of the variants in specific gene networks, rather than the presence of a certain single variant predominates. Therefore, while considering
a complex disease, the disease status can be evaluated as the success of a team composed of certain variants. To apply this approach, we tested the efficiency of high-dimensional modelling of gene-network restricted variants in distinguishing a disease status. To evaluate the proposed method, we select two gene networks, mTOR and TGF-β. For each pathway, we generate 400 control and 400 patient group samples. The considered mTOR and TGF-β pathways contain 31 and 93 genes of varying sizes, respectively. We performed Chaos Game Representation to each gene sequence to obtain 2-D binary patterns. Produced patterns are ordered successively, and a 3-D tensor structure is achieved for each gene network. Features for each data sample are acquired by exploiting Enhanced Multivariance Products Representation to 3-D data. The features are split as training and testing vectors. The training vectors are employed to train a Support Vector Machines classification model. We manage to achieve more than 96% and 99% classification accuracies for mTOR and TGF-β networks, respectively, using a limited amount of training samples.

Data:
    The datasets generated and/or analysed during the current study are available on figshare platform with the following link: https://figshare.com/articles/dataset/Gene_Network_Variant_Dataset_mTOR_TGF_Beta_zip/19312214
    
Platform:
    MATLAB 2022a and LIBSVM
    
Content:
    MATLAB scripts and mex files

