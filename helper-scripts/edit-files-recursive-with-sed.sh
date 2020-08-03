
# run from a different directory 
# or it may edit itself

folders=0
files=0

recursiverm() {
  for d in *; do
    if [ -d "$d" ]; then
      echo "------ opening folder : $d ---------"
      (cd -- "$d" && recursiverm)
    else
      
      # if [[ "$d" == *.js ]]; then
        # echo "file : $d"
        path="$(pwd)"
        file="$path/$d"
        echo "editing : $file"
        echo
        sed -i "s/qa/question/g" "$d"
        sed -i "s/Qa/Question/g" "$d"
        sed -i "s/qas/questions/g" "$d"
        sed -i "s/Qas/Questions/g" "$d"
        sed -i "s/QA/QUESTION/g" "$d"
        sed -i "s/QAS/QUESTIONS/g" "$d"
      # fi 
    fi
    #rm -f *.pdf
    #rm -f *.doc
  done
}

(recursiverm)

#  echo "total folders = $folders"
#  echo "total files = $files"
