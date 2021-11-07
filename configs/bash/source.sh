echo ">> bash source: $BASH_SOURCE"
echo ">> bash config home: $BASH_CONFIG_HOME"
this_file=$(basename $BASH_SOURCE)

for file in $BASH_CONFIG_HOME; do 
    if [ -f "$file" ]; then 
        echo ">> comparing $file to $this_file"
        if [ ! $file == $this_file ]; then
          #echo "sourcing file: $file"
          source $file
        fi
    fi 
done
