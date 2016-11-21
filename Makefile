.PHONY: \
	all \
	clean \
	build

all: \
	clean \
	build
	@echo "All Done."

clean:
	@echo "Clean"
	@find ./about-me/public -mindepth 1 ! -name .git -delete
	@echo "Clean Done."

build:
	@echo "Build"
	@cd ./about-me && hugo
	@cp ./about-me/content/README.md ./about-me/public
	@cd ./about-me/public && \
		git add -A && \
		git commit -m "Rebuild site `date --rfc-3339=seconds`" && \
		git remote add push2 git@github.com:nikolay-turpitko/nikolay-turpitko.github.io.git || : && \
		git push push2 master
	@echo "Build Done."
