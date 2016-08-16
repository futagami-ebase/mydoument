changequote(/*,*/)
define(/*reverse*/,/*ifelse($#,1,$1,/*reverse(shift($@)) $1*/)*/)
reverse(first, two, three, end)
