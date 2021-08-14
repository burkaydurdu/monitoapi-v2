#!/bin/bash

# Get the command line arguments
for i in "$@"
do
    case $i in
        -e=*|--environment=*)
            ENVIRONMENT="${i#*=}"
            shift
            ;;
        *)
            break
            ;;
    esac
done

# Check the environment is alpha, stage or production.
# Exit if the given environment is none of the above.
if [ ${ENVIRONMENT} != "production" ]; then
    echo "You have entered wrong environment name"
    exit 1
fi

# Create the deployment tag with timestamp
dateString=`date +%Y%m%d%H%M%S`
TAG="${ENVIRONMENT}-${dateString}"

# Create the tag and push it to repository
git tag ${TAG}
git push origin ${TAG}
echo "Pushed the tag ${TAG} to repository"
