.PHONY: all clean build config install_deps copy-iso

all: install_deps clean config build

install_deps:
	sudo apt -y install live-build make

config:
	lb config

build:
	sudo lb build 2>&1 | tee build.log

clean:
	sudo lb clean --all
	rm -f build.log

copy-iso:
	@if [ -f live-image-amd64.hybrid.iso ]; then \
		cp live-image-amd64.hybrid.iso "/mnt/c/Users/$$(cmd.exe /c echo %USERNAME% 2>/dev/null | tr -d '\r')/Desktop/sylon-os.iso"; \
		echo "ISO copiee sur le Bureau Windows : sylon-os.iso"; \
	else \
		echo "ERREUR: ISO introuvable. Lancez 'make build' d'abord."; \
	fi
