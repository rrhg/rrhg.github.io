recursivewr() {
  for d in *; do
    if [ -d "$d" ]; then
      #echo "------ opening folder : $d ---------"
      (cd -- "$d" && recursivewr)
    else
      
      if [[ "$d" == *.js ]]; then
        folder="$(pwd)"
        echo "console.log(\"$folder $d\")" >> "$d"
      fi 
    fi
    #rm -f *.pdf
    #rm -f *.doc
  done
}

(recursivewr)
