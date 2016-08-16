define(`last',`ifelse($#,1,$1,`last(shift($@))')')
last(first, two, three, end)

define(`reverse',`ifelse($#,1,$1,`reverse(shift($@)) $1')')
reverse(first, two, three, end)

define(`forloop',
     `pushdef(`$1', `$2')_forloop(`$1', `$2', `$3', `$4')popdef(`$1')')
define(`_forloop',
     `$4`'ifelse($1, `$3', ,
     `define(`$1', incr($1))_forloop(`$1', `$2', `$3', `$4')')')

forloop(`i', 1, 8, `i ')

forloop(`i', 1, 4, `forloop(`j', 1, 8, `(i, j) ')
')
