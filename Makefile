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
	@rm -rf ./about-me/static/gen
	@echo "Clean Done."

generate:
	@echo "Generate static content"
	@mkdir -p ./about-me/static/gen
	@sed '/^+++$$/,/^+++$$/d' ./about-me/content/full\ cv/index.md | \
		sed '/./,$$!d' | \
		cat -s > ./about-me/static/gen/Nikolay_Turpitko_Software_Developer_Golang.md
	@ pandoc -s -S \
		-f markdown_github \
		-V papersize="a4" \
		-V margin-left="2cm" \
		-V margin-right="2cm" \
		-V margin-top="2cm" \
		-V margin-bottom="2cm" \
		-V fontsize="10pt" \
		-o ./about-me/static/gen/Nikolay_Turpitko_Software_Developer_Golang.pdf \
		./about-me/static/gen/Nikolay_Turpitko_Software_Developer_Golang.md
	@echo "Generate static content Done."


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
