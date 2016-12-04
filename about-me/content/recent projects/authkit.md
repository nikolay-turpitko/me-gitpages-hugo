+++
title = "authkit"
weight = 1

+++

<https://github.com/letsrock-today/authkit>

This project is half-finished, but the only one (of my projects) yet with a
publicly available source code (all others are in private repositories, or an
intellectual property of my clients or former employers).

[We](https://github.com/letsrock-today) started it to extract boilerplate auth
code from the other [our project](../lr) - ["Let's Rock!"](https://letsrock.today) (LR).

As LR project itself, we are developing authkit with a [fellow
developer](https://ru.linkedin.com/in/ustinovandrey).

Currently, for the authentication in the LR we use Nginx module, which we
created using Go, `"golang.org/x/oauth2"` and `"github.com/dgrijalva/jwt-go"`.
But, retrospecting it, we found, that we created more custom code than it deem
to be necessary and it is a bit entangled.

However, it seems that we have a couple of useful pieces of code, which we would
be glad to reuse in our future projects,  and something might be even useful
for other developers.  Of course, we'd benefit if someone starts to use our code
and contribute to it. So, we decided to publish it on Github under MIT license.

We have not finished to re-implement all the parts, we already had in LR, yet.
It's not going so fast, as we hope initially, because we are trying to re-think
our code, make it more simple and use as much ready libraries as possible.
Also, we decided to do slightly more, than we already had in LR. For example,
we blended [Hydra](https://github.com/ory-am/hydra) and
[Echo](https://github.com/labstack/echo) into it.

So, we hope that when we reintegrate authkit back into LR, we'll have more
secure, complete and, at the same time, more simple solution than we already
have.

There is nothing much to say about this project. We made it open, everyone can
check it out, skim through the
[README](https://github.com/letsrock-today/authkit/blob/master/README.md), see
the code, execute demo using Docker Composer, follow it, give us a star, fork
and experiment with it, create an issue or send us a PR.

