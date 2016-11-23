.PHONY: \
	all \
	clean \
	build

all: \
	clean \
	generate \
	build
	@echo "All Done."

clean:
	@echo "Clean"
	@find ./about-me/public -mindepth 1 ! -name .git -delete
	@rm -rf ./about-me/static/doc
	@echo "Clean Done."

generate:
	@echo "docerate static content"
	@mkdir -p ./about-me/static/doc
	@sed '/^+++$$/,/^+++$$/d' ./about-me/content/full\ cv/index.md | \
		sed '/./,$$!d' | \
		cat -s > ./about-me/static/doc/Nikolay_Turpitko_Software_Developer_Golang_CV.md
	@pandoc -s -S \
		-f markdown_github \
		-V papersize="a4" \
		-V margin-left="2cm" \
		-V margin-right="2cm" \
		-V margin-top="2cm" \
		-V margin-bottom="2cm" \
		-V fontsize="10pt" \
		-o ./about-me/static/doc/Nikolay_Turpitko_Software_Developer_Golang_CV.pdf \
		./about-me/static/doc/Nikolay_Turpitko_Software_Developer_Golang_CV.md
	@grep ./about-me/content/recent\ projects/* -EH -e "^weight.*=.*[1..0]+$$" | \
		sort -k 4b | \
		cut -d: -f1 | \
		xargs -r -I'{}' cat '{}' | \
		sed '/^+++$$/,/^+++$$/d' \
		> ./about-me/static/doc/Nikolay_Turpitko_Software_Developer_Recent_Projects.md
	@pandoc -s -S \
		-f markdown_github \
		-V papersize="a4" \
		-V margin-left="2cm" \
		-V margin-right="2cm" \
		-V margin-top="2cm" \
		-V margin-bottom="2cm" \
		-V fontsize="10pt" \
		-o ./about-me/static/doc/Nikolay_Turpitko_Software_Developer_Recent_Projects.pdf \
		./about-me/static/doc/Nikolay_Turpitko_Software_Developer_Recent_Projects.md
	@echo "docerate static content Done."

# During the build, code is generated to ./about-me/public folder, which is
# a submodule, mapped to github pages project. So, after site generation we
# need to push changes back to that repo.
# But due the restrictions of travis, it have to be cloned via https, and
# should be pushed via ssh (to be able to use ssh key, not password).
# So, trying to push detached head into master, providing repo's url.

build:
	@echo "Build"
	@cd ./about-me && hugo
	@cp ./about-me/content/README.md ./about-me/public
	@git submodule update --rebase && \
		cd ./about-me/public && \
		git add -A && \
		git commit -m "Rebuild site `date --rfc-3339=seconds`" && \
		git push git@github.com:nikolay-turpitko/nikolay-turpitko.github.io.git HEAD:master
	@echo "Build Done."
