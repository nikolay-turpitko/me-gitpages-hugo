.PHONY: \
	all \
	clean \
	tools \
	generate \
	build \
	serve

all: \
	clean \
	tools \
	generate \
	build
	@echo "All Done."

clean:
	@echo "Clean"
	@find ./about-me/public -mindepth 1 ! -name ".git" -delete
	@rm -rf ./about-me/static/doc
	@find ./about-me/static -maxdepth 1 -name "*.zip" -delete -or -name "*.tar.gz" -delete
	@find ./tools -mindepth 1 ! -name "*.nim" -delete
	@echo "Clean Done."

tools:
	@echo "Build Tools"
	@mkdir -p ./tools/bin
	@cd ./tools && nim c -o:"./bin/decryptemail" decryptemail.nim
	@cd ./tools && nim c -o:"./bin/obfuscateemail" obfuscateemail.nim
	@echo "Build Tools Done."

prefix="Nikolay_Turpitko_Software_Developer_Golang"

generate:
	@echo "Generate static content"
	@mkdir -p ./about-me/static/doc
	@sed -e '/^+++$$/,/^+++$$/d' \
		 -e '/./,$$!d' \
		 -e "s/{{% updated %}}/$$(date -I)/" \
		 ./about-me/content/full\ cv/index.md | \
		./tools/bin/decryptemail | \
		cat -s > ./about-me/static/doc/$(prefix)_CV.md
	@pandoc -s -S \
		-f markdown \
		-V documentclass="paper" \
		-V papersize="a4" \
		-V geometry:margin=1.5cm \
		-V fontsize="10pt" \
		-V colorlinks=true \
		-V title-meta="Full CV" \
		-V author-meta="Nikolay Turpitko" \
		-H ./templ/cv-header.inc \
		-o ./about-me/static/doc/$(prefix)_CV.pdf \
		./about-me/static/doc/$(prefix)_CV.md
	@grep ./about-me/content/recent\ projects/* -PH -e '^weight\s*=\s*\d+$$' | \
		sort -k 4b | \
		cut -d: -f1 | \
		xargs -r -I'{}' sed \
		  -e '/^+++$$/,/^+++$$/d' \
		  -e '/./,$$!d' \
		  -e '$$s/$$/\n/' \
		  -s '{}' | \
		cat -s > ./about-me/static/doc/$(prefix)_Recent_Projects.md
	@pandoc -s -S \
		-f markdown \
		-V documentclass="paper" \
		-V papersize="a4" \
		-V geometry:margin=1.5cm \
		-V fontsize="10pt" \
		-V colorlinks=true \
		-V title-meta="Recent projects" \
		-V author-meta="Nikolay Turpitko" \
		-o ./about-me/static/doc/$(prefix)_Recent_Projects.pdf \
		./about-me/static/doc/$(prefix)_Recent_Projects.md
	@find ./about-me/static ! -path "**/cert/**" -name "*.pdf" -or -name "*.md" | \
		tar --transform 's:^.*/::' \
		-cvzf ./about-me/static/$(prefix).tar.gz \
		--files-from=/dev/stdin
	@find ./about-me/static ! -path "**/cert/**" -name "*.pdf" -or -name "*.md" | \
		zip ./about-me/static/$(prefix) -j@
	@cat ./about-me/static/doc/$(prefix)_CV.md | \
		./tools/bin/obfuscateemail > \
		./about-me/static/doc/$(prefix)_CV.md.tmp && \
		mv ./about-me/static/doc/$(prefix)_CV.md.tmp \
		./about-me/static/doc/$(prefix)_CV.md
	@echo "Generate static content Done."

# During the build, code is generated to ./about-me/public folder, which is
# a submodule, mapped to github pages project. So, after site generation we
# need to push changes back to that repo.
# But due the restrictions of travis, it have to be cloned via https, and
# should be pushed via ssh (to be able to use ssh key, not password).
# So, push detached head into master, providing repo's url.

build:
	@echo "Build"
	@cd ./about-me && hugo
	@cp ./about-me/content/README.md ./about-me/public
	@if [ -n "$$TRAVIS" ]; then \
		git submodule update --rebase && \
		cd ./about-me/public && \
		git add -A && \
		git commit -m "Rebuild site `date --rfc-3339=seconds`" && \
		git push -f git@github.com:nikolay-turpitko/nikolay-turpitko.github.io.git HEAD:master; \
	else \
		echo "WARN: Make executed locally, no subrepo push performed."; \
	fi
	@echo "Build Done."

serve: clean tools generate
	@echo "Run Hugo"
	@cd ./about-me && hugo server
	@echo "Run Hugo Done."
