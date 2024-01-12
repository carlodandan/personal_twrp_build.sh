source ./vars.sh

PROJECT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

# Cleanup
if [ -d slimhub_actions ]; then
  sudo bash slimhub_actions/cleanup.sh
else
  git clone https://github.com/carlodandan/slimhub_actions -b main
  sudo bash slimhub_actions/cleanup.sh
fi