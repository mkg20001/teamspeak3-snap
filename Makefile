build:
	make -C teamspeak3
	make -C teamspeak3-server
try:
	make -C teamspeak3 try
	make -C teamspeak3-server try
