WIP!!!!!!!!

Building the container on synology 101

Make sure port forwarding range 2456->2458 is set.

SSH into host and run these commands:
	mkdir /volume1/docker/valheim
	sudo chown 1000:1000 /volume1/docker/valheim

Synology Docker:
Launch image
	-Hit Advanced
		-Select Volume Tab
			-Add Folder
				-Select valheim folder in the docker directory
			-Set volume mount path to /data
		-Select Network Tab
			-Checkbox "Use the same network as Docker Host"
		-Select Environment Tab
			-Set SERVER_* variables ESP the password.

All done. Select the container and hit details->Log on the image to watch the magic.



Command cheat sheet:
sudo systemctl start docker.service
sudo docker build -t valheim .
sudo docker save valheim > valheim.tar



//Nuke all images must be run as SU
su
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
exit
