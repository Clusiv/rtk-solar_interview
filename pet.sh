petsnames=("Jack_20210321" "Cat_20210321" "Pet_20210321" "Tom_20210321" )
pets=()

for pet in ${petsnames[@]}
do  
    # echo "\n" $pet 
    js=( $(curl -d '{"name":"'$pet'"}' -H "Content-Type: application/json" -X POST https://petstore.swagger.io/v2/pet | awk -F'[:",]' '{print $4}') )
    # echo "${js: -1}"
    case "${js: -1}" in
    7|8|9) 
        pets+=$pet:NULL
        response=$(curl -X DELETE "https://petstore.swagger.io/v2/pet/${js}")
        # echo $response
        ;;
    *)     pets+=$pet:$js;;
    esac
done
echo $pets