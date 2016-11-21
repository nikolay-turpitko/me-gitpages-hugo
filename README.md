[![Build Status](https://travis-ci.org/nikolay-turpitko/me-gitpages-hugo.svg?branch=master)](https://travis-ci.org/nikolay-turpitko/me-gitpages-hugo)

# me-gitpages-hugo
Sources for Hugo to generate website about me https://nikolay-turpitko.github.io.

## Links:
- https://gohugo.io/tutorials/github-pages-blog/
- https://gohugo.io/overview/quickstart/
- http://themes.gohugo.io/after-dark/
- http://rcoedo.com/post/hugo-static-site-generator/
- http://www.curtismlarson.com/blog/2015/04/12/github-pages-google-domains/

## Create key:
```
ssh-keygen -t rsa -b 4096 -C "<github-username>"
# save to id_rsa_travis, without passphrase
travis encrypt-file ~/id_rsa_travis --add
```
