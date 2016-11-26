[![Build Status](https://travis-ci.org/nikolay-turpitko/me-gitpages-hugo.svg?branch=master)](https://travis-ci.org/nikolay-turpitko/me-gitpages-hugo)

# me-gitpages-hugo

Sources for Hugo to generate website about me https://nikolay-turpitko.github.io.

## Links

- https://gohugo.io/tutorials/github-pages-blog/
- https://gohugo.io/overview/quickstart/
- http://themes.gohugo.io/after-dark/
- http://rcoedo.com/post/hugo-static-site-generator/
- http://www.curtismlarson.com/blog/2015/04/12/github-pages-google-domains/

## Create key

```
ssh-keygen -t rsa -b 4096 -C "<github-username>"
# save to id_rsa_travis, without passphrase
travis encrypt-file ~/id_rsa_travis --add
```

## E-mail links

Email links obfuscated with rot13 algorithm. See http://www.rot13.com/.
Links are de-obfuscated with javascript when web page loads.
For downloadable files links de-obfuscated with ./tools/decryptemail.nim
before PDF creation. When PDF generated and markdown file archived, links
obfuscated again with ./tools/obfuscateemail.nim - to provide more readable
alternative in downloadable file.

I hope it is safe enough. I suppose, that spam bots would not extract archives
or PDF documents and less probably parse markdown files, than html. Though, it
is still probable, they may attempt to try parse all links as text files. Links
in the markdown file obfuscated less strong, than in html, but still somewhat
better than not at all. I suppose, it not going to work, if I ask HR to decrypt
my email from rot13...

## Note

Never commit/push subomdule in ./about-me/public from local repo.
Otherwise you'll have to commit/push superproject as well. Let TravisCI do this
job. Better make a branch in the submodule for local experiments and discard it
before push main project.
