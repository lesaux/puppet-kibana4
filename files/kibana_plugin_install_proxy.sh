#!/bin/sh
# By Fat Dragon, 09/06/2016
# Downloads Kibana plugin through outgoing http proxy and installs it
# (Workaround for https://github.com/elastic/kibana/issues/5902) 
# Arguments:
# kibana_plugin_install_proxy.sh <plugin_name> <url> <kibana4_plugin_dir> <http_proxy>

# Gathers input
if [ $# -ne 4 ]
then
    echo "kibana_plugin_install_proxy.sh <plugin_name> <url> <kibana4_plugin_dir> <http_proxy>"
    exit 1
fi

plugin_name=$1
url=$2
kibana4_plugin_dir=$3
http_proxy=$4

file_name="/tmp/$(basename $url)"

# Ensures that the file does not exist
if [ -f $file_name ]; then
	rm $file_name
fi

# Downloads the file
wget -e use_proxy=yes -e http_proxy=$http_proxy $url -O $file_name
status=$?

if [ $status -ne 0 ]; then

	# Ensures that the file does not exist
	if [ -f $file_name ]; then
		rm $file_name
	fi

	echo "Download failed."
	exit $status

fi

# Rechecks for file
if [ ! -f $file_name ]; then

	echo "Strange, but the file is missing."
	exit 1

fi

# Installing
/opt/kibana/bin/kibana plugin --install $plugin_name -u "file://${file_name}" -d $kibana4_plugin_dir
status=$?

# Cleanup
rm $file_name


if [ $status -eq 0 ]; then
	echo "Finished."
else
	echo "Install failed."
fi

exit $status
