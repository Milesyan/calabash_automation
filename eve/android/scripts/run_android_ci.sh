cd ..

PARAMS="-p android"

while getopts ":rd:" OPTION; do
    case $OPTION in

        r)
            PARAMS=$PARAMS" --format json -o cucumber.json"
            ;;
        d)
            PARAMS=$PARAMS" ADB_DEVICE_ARG=$OPTARG"

            ;;
        [?])    echo "Usage: $0 [-r] [-d DEVICE_ID].\n     -r: should create reports.\n     DEVICE_ID: where to run tests."
                exit 1;;
    esac
done

# clear old files
rm -rf screenshot*
rm -rf test_servers/*
# resign apk
calabash-android resign "../*.apk"
# run tests
calabash-android run "../*.apk" $PARAMS