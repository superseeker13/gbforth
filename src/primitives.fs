require ./asm.fs
require ./cross.fs

also gb-assembler

( TEMPORARY HACK: Don't break the game! )
$4400 ==>

: code xcreate ;

( x -- x x )
code dup
ps-dup,
ret,

( a b -- b a )
code swap
ps-over-de-nip,
ps-push-de,
ret,

( a b -- b )
code nip
C inc,
C inc,
ret,

( x -- )
code drop
ps-drop,
ret,

( a b -- c )
code +
ps-over-de-nip,
DE HL add,
ret,

( c-addr -- x )
code c@
[HL] L ld,
$0 # H ld,
ret,

( x c-addr -- )
code c!
ps-over-de-nip,
E [HL] ld,
ps-drop,
ret,

previous
