# Syntax
# tc.emit.version.sh <git-sha> <build-counter> <branch> <date> <time>

# TODO: Read these values from some external "God"-version file (in the source repo).
# It's the overall version number of the entire Dro system (backend+frontend)
MAJOR=0
MINOR=0
PATCH=2

GIT_SHA=""
BUILD_COUNTER="0"
BRANCH=""
DATE=$(date +%Y%m%d)
TIME=$(date +%H%M%S)

usage()
{
    echo "usage: tc.emit.version [-c build-counter] [-s git-sha] [-b branch-name] [-d build-start-date] [-d build-start-time] [-h]]"
}

while [ "$1" != "" ]; do
    case $1 in
        -c | --counter )        shift
                                BUILD_COUNTER=$1
                                ;;
        -s | --sha )            shift
                                GIT_SHA=$1
                                ;;
        -b | --branch )         shift
                                BRANCH=$1
                                ;;
        -d | --date )           shift
                                DATE=$1
                                ;;
        -t | --time )           shift
                                TIME=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

# git sha value
if [ "$GIT_SHA" = "" ]; then
    GIT_SHA=$(git rev-parse HEAD)
fi
# # build counter (from TeamCity)
# if [ "$2" != "" ]; then
    # BUILD_COUNTER=$2
# else
    # BUILD_COUNTER="0"
# fi
# branch name
if [ "$BRANCH" = "" ]; then
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
fi
# # date of build-start
# if [ "$4" != "" ]; then
    # DATE=$4
# else
    # DATE=$(date +%Y%m%d)
# fi
# # time of build-start
# if [ "$5" != "" ]; then
    # TIME=$5
# else
    # TIME=$(date +%H%M%S)
# fi

SEMVER_ROOT=$MAJOR.$MINOR.$PATCH
SEMVER_SHORT=$SEMVER_ROOT-build.$BUILD_COUNTER
# SEMVER_FULL=$SEMVER_SHORT+id.$BRANCH.${GIT_SHA:0:6}.time.$DATE$TIME
SEMVER_FULL=$SEMVER_SHORT+id.${GIT_SHA:0:6}

#echo "##teamcity[setParameter name='version.major.minor.patch' value='$MAJOR.$MINOR.$PATCH']"
#echo "##teamcity[setParameter name='version.id' value='${GIT_SHA:0:6}']"

echo "##teamcity[setParameter name='version.semver.short' value='${SEMVER_SHORT}']"
echo "##teamcity[setParameter name='version.semver.full' value='${SEMVER_FULL}']"
echo "##teamcity[buildNumber '${SEMVER_FULL}']"
