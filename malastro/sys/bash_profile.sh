export LAV_DIR=/home/sabeiro/lav/motion/
export LC_ALL="en_US.UTF-8"
export SPARK_HOME="/usr/local/lib/python3.5/dist-packages/pyspark/"
export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-VERSION-src.zip:$PYTHONPATH
export PYSPARK_PYTHON=/usr/bin/python
export PYSPARK_DRIVER_PYTHON=ipython
export PYSPARK_DRIVER_PYTHON_OPTS="--pylab -c 'from pyspark import SparkContext; sc=SparkContext()' -i"
export PYSPARK_SUBMIT_ARGS="--master local[2] pyspark-shell"
export PYSPARK_PYTHON=/usr/bin/python3
export PYSPARK_DRIVER_PYTHON=ipython3
#export PYSPARK_DRIVER_PYTHON_OPTS="notebook"
export HOSTALIASES=$LAV_DIR/conf/.hosts
export PATH=$PATH:~/bin/:$LAV_DIR/bin/
export SAMBA_PATH="smb://192.168.2.254/motionlogic/Data_Science/Customer_Projects_DE/"
export SAMBA_PATH=$HOME"/lav/motion/log/samba/"
PS1="\[\033[1;34m\][\$(date +%H%M)][\u@\h:\w]$\[\033[0m\] "
PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;34m\]\W\[\033[1;31m\]\$\[\033[0m\] '
force_color_prompt=yes
alias ls='ls --color=auto -h'
alias ll='ls -lh'

