#Count number of tracked particles


read_dom () {
    local IFS=\>
    read -d \< ENTITY CONTENT
    local ret=$?
    TAG_NAME=${ENTITY%% *}
    ATTRIBUTES=${ENTITY#* }
    return $ret
}

counterOrg=0;

count_dom() {
    string="$ENTITY";
    set -- $string

    if [[ $1 = "track" ]]; then
        #echo "org"
        counterOrg=$((counterOrg+1))
        
    fi

}

while read_dom; do
    count_dom
done

num_rows=$counterOrg

echo "$1", "$2"

cat "$1" | ./parseXML.sh "$num_rows" "$2"