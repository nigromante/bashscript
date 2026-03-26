# Bash Script Framework

## Usage:

### Setting LIBPATH first


&emsp;&emsp; cd apps/tests

&emsp;&emsp; source ../env.sh

&emsp;&emsp; ./string.sh



### Setting LIBPATH on fly

&emsp;&emsp; cd apps/tests

&emsp;&emsp; ../../launch/run.sh ./string.sh



### Setting alias 
#### (alias launch=../../launch/run.sh) 

&emsp;&emsp; cd apps/tests

&emsp;&emsp; source ../../launch/alias.sh

&emsp;&emsp; launch ./string.sh



### Runnig as Root

&emsp;&emsp; cd apps/tests

&emsp;&emsp; sudo ../../launch/run.sh ./root.sh



### Runnig as Root using Alias 
#### (alias sulaunch=sudo ../../launch/run.sh)

&emsp;&emsp; cd apps/tests

&emsp;&emsp; source ../../launch/alias.sh

&emsp;&emsp; sulaunch ./root.sh

