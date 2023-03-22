## Reminder
# Terminal commands:
# list file in the current directory
ls

# move forward in the directories:
cd folderX

# to move backward
cd ..

# to move to root directory:
cd

# to run .sh file in terminal: 
# myfile needs to be in the current location
bash myfile.sh 


# CONDA
# https://docs.conda.io/projects/conda/en/latest/user-guide/install/macos.html 
# Download installer for MacOS
# Then run:
bash Miniconda3-latest-MacOSX-x86_64.sh

# Follow the prompts installer screens
## accept default if unsure settings

# To make the changes take effects, close and then re-open your terminal window
# Test your installation by running: 

conda list

# a list of installed packages appears if it has been installed correctly

#### Usefull command: 
# https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html
# conda works with environment
# upon opening the terminal, the current environment is showed in bracket: (base)

# create an environment: myenv
conda create --name myenv
# press y when conda ask to proceed

# activate an environment
conda activate myenv
# the current environment will change to: (myenv)

# deactivate environment (back to base)
conda deactivate

# view list of your environment 
conda info --envs

# removing environment:
conda remove --name myenv --all