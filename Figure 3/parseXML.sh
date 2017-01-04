
declare -A matrix_x
declare -A matrix_y
num_rows=$1;
num_columns=300

echo "$num_rows"

for ((i=1;i<=num_rows;i++)) do
    for ((j=1;j<=num_columns;j++)) do
        matrix_x[$i,$j]=-1;
        matrix_y[$i,$j]=-1;
    done
done

counterOrg=0;
#counterTime=0;


read_dom () {
    local IFS=\>
    read -d \< ENTITY CONTENT
    local ret=$?
    TAG_NAME=${ENTITY%% *}
    ATTRIBUTES=${ENTITY#* }
    return $ret
}


parse_dom () {

    string="$ENTITY";
    set -- $string

    if [[ $1 = "track" ]]; then
        #echo "org"
        counterOrg=$((counterOrg+1))
        #counterTime=1;
    fi

    if [[ $TAG_NAME = "detection" ]] ; then
        eval local $ATTRIBUTES
        #echo $((t+1))
        matrix_x[$counterOrg,$((t+1))]=$x;
        #echo ${matrix_x[$counterOrg,$counterTime]}
        matrix_y[$counterOrg,$((t+1))]=$y;
        #echo $counterOrg, $counterTime
        #counterTime=$((counterTime+1))
    fi
    
}


while read_dom; do
    parse_dom
done

for ((i=1;i<=num_rows;i++)) do
    for ((j=1;j<=num_columns;j++)) do
        printf "%s" "${matrix_x[$i,$j]}," 
   done
   printf "%s\n" 
   echo
done > trajectory_x_"$2".txt

for ((i=1;i<=num_rows;i++)) do
    for ((j=1;j<=num_columns;j++)) do
        printf "%s" "${matrix_y[$i,$j]}," 
   done
   printf "%s\n " 
   echo
done > trajectory_y_"$2".txt



