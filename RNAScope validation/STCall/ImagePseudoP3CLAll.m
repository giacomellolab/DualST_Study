clear
load ./ImagePseudo/Data/P3CLS.mat

load ./ImagePseudo/DataTemp/P3CLAllA1.mat
temp1=ImageST;

load ./ImagePseudo/DataTemp/P3CLAllB1.mat
temp2=ImageST;

ImageST=temp1+temp2;

save ./ImagePseudo/Data/P3CLAll.mat ImageST ImageRNA ImageTissue
