cd "$(dirname "$0")"
this_file=$(basename $0)
for file in *; do 
    if [ -f "$file" ]; then 
        if [ ! $file == $this_file ]; then
          #echo "sourcing file: $file"
          source $file
        fi
    fi 
done
