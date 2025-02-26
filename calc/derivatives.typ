#set align(center)

= Leibniz's Notation

#let dx = $d x$


#let gn(x) = text(fill: red, $#x$)
#let bl(x) = text(fill: blue, $#x$)

#table(align: horizon,
[
  Solve for $d/dx (x^2)$
$
d(x^2)
&=lim_(h->0) [(x+h)^2-x^2]
\
&=(x+dx)^2-x^2
\
&=cancel(x^2-x^2)+2x dx+cancel(dx^2)
\
&=2x d x
\
d/(d x) [x^2]&=2x
$
],
[
Prove the product rule
$
d[f(x) * g(x)]
&=lim_(h->0)[gn(f(x+h))*bl(g(x+h))-f(x)g(x)]\
&=(gn(f(x) + d f))(bl(g(x)+d g))-f(x)g(x)\
&=cancel(f(x)g(x)-f(x)g(x))+f(x)d g+g(x)d f + cancel(d f d g)\
&=f(x)d g + g(x)d f\
d/(dx)[f(x) * g(x)]&=f(x)(d g)/dx+g(x)(d f)/dx
$

]
)
= A Mope Explicit Notation

#let dd = $delta$

$ dd_(alpha...)(beta...) = dd{alpha...}(beta...) = "Leibniz" d(alpha...) $

$ D{alpha...}(beta...)=(dd{alpha...}(beta...))/dd_(beta...) = "Leibniz" d/(d beta...) (alpha...) $

#table(align: horizon,
[
Solve for $D{x^2}(x)$
$
f
&=x^2\

dd_f (x)
&=lim_(h->0) (f(x+h)-f(x))\
&=lim_(dd_x->0) ((x+dd_x)^2-x^2)\
&=(x+dd_x)^2-x^2\
&=cancel(x^2-x^2)+2x dd_x+cancel(dd_x^2)\
&=2x dd_x\
(dd{x^2}(x)) / (delta_x) &= 2x\
D{x^2}(x) &= 2x
$
])
#pagebreak()
#table([
Prove the product rule

$
dd{f(x)g(x)}(x)
&=lim_(dd_x->0)[gn(f(x+dd_x))*bl(g(x+dd_x))-f(x)g(x)]\

gn(f(x+dd_x))
&=f(x)+dd_f (x)\

bl(g(x+dd_x))
&=g(x)+dd_g (x)\

dd{f(x)g(x)}(x)
&=(gn(f(x)+dd_f (x)))(bl(g(x)+dd_g (x)))-f(x)g(x)\
&=cancel(f(x)g(x)-f(x)g(x))+f(x)dd_g (x)+g(x)dd_f (x) + cancel(dd_f (x)dd_g (x))\
&=f(x)dd_g (x)+g(x)dd_f (x)\

D{f(x)g(x)}(x)
&=f(x)(dd_g (x))/dd_x +g(x)(dd_f (x))/dd_x
$
]
)
