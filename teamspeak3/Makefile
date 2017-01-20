build:
	snapcraft
clean:
	snapcraft clean
try: build
	make
	sudo snap install ./build/*.snap --devmode
