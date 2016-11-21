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
	@find ./about-me/public -delete
	@echo "Clean Done."

build:
	@echo "Build"
	@cd ./about-me && hugo
	@cp ./about-me/content/README.md ./about-me/public
	@cd ./about-me/public && \
		git add -A && \
		git commit -m "Rebuild site `date --rfc-3339=seconds`" && \
		git push origin master
	@echo "Build Done."
