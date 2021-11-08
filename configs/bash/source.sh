this_file=$(basename $BASH_SOURCE)

for file in "$BASH_CONFIG_HOME"/*; do
    if [ -f "$file" ]; then 
        if [ ! $(basename $file) == $this_file ]; then
          source $file
        fi
    fi 
done
