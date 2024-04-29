#! /bin/bash
##pulling git latest from master branch
#go to the root directory
cd /var/www/vhosts/test.project.com/httpdocs/

#
echo "Checking current branch.."
CURRENT_BRANCH=$(git branch | grep \* | cut -d ' ' -f2)

if [ $CURRENT_BRANCH != "master" ]; then
    echo "Current branch is not 'master'. Exiting!!.."
    exit 1
fi

echo "Checking whether local branch is upto date"
REMOTE_REVISION=$(git ls-remote git@gitlab.com:test-projects/project.git -h refs/heads/master|cut -f1)
LOCAL_REVISION=$(git rev-parse HEAD)
echo "Local Revision: $LOCAL_REVISION"
echo "Remote Revision: $REMOTE_REVISION"

if [ $REMOTE_REVISION == $LOCAL_REVISION ]; then
    echo "Local Branch upto date.. Exiting!.."
    exit 1
fi

echo "Pulling latest changes.. "|tee ${LOG_FILE}
git pull git@gitlab.com:test-projects/project.git master |tee -a ${LOG_FILE}
