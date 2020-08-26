
#!/usr/bin/env bash


options=$(getopt --longoptions region:,size: -o '' -- "$@")



[ $? -eq 0 ] || { 
    echo "Incorrect options provided"
    # this does not make arguments mandatory
    exit 1
}

eval set -- "$options"


submited_args=()

required_args=('--region' '--size')
required_args_string="${required_args[@]}"



while true; do

    case "$1" in
    --region)
        submited_args+=("$1")
        shift; # The arg is next in position args
        REGION=$1
        #echo "REGION = $REGION"
        ;;
    --size)
        submited_args+=("$1")
        shift; # The arg is next in position args
        SIZE=$1
        #echo "SIZE = $SIZE"
        ;;

    --)
#        for s in "${submited_args[@]}"; do
#          for r in "${required_args[@]}"; do
#            echo "$s $r"
#          done  
#        done

        shift;
        break
        ;;
    esac
    shift
done


for s2 in "${submited_args[@]}"; do
  for index in "${!required_args[@]}"; do
   
      #echo
      #echo "submited arg = $s2"
      #echo "required args in index $index is ${required_args[index]}"

      if [[ ${required_args[index]} = $s2 ]];
        then
           #echo
           #echo "${required_args[index]} is equal to $s2"
           #echo "deleting ${required_args[index]} from required_args array"
	   #echo
           #echo "array before removing element = ${required_args[*]}"
	   #echo
	   unset 'required_args[index]'
	   #echo "array after removing element = ${required_args[*]}"
	   #echo
	   #if [ ${#required_args[@]} -eq 0 ]; then
	   #  echo
           #  echo "required_args list is empty"
           #else
           #  echo "required_args list NOT empty"
           #fi
	   #echo
        else
           continue
           #echo "$s is NOT in the list of required arguments ${required_args[*]}"
      fi


done
done

if [ ${#required_args[@]} -eq 0 ]; then
    echo "required args list is empty. all submited. good to go"
    echo
else
    echo "required args list is NOT empty. NOT all req args were submited."
    echo "you did not provide all required arguments"
    echo "the required arguments are $required_args_string"
    echo 'try ./required-script-long-args-getopt.sh --region ny --size one'
    echo "exiting script with status 1"
    exit 1
fi

echo "End of script"
exit 0;
