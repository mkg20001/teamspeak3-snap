build:
	cp -rp ./ ../cp
	mv ../cp ./build
	make -C build main
main:
	bash getlatest.sh
	chmod +x daemon tsdns
	snapcraft
try:
	rm -rf build
	make
	sudo snap install ./build/*.snap --devmode
