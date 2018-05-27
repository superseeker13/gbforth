require ./utils/bytes.fs
require ./utils/strings.fs

: to-symbol-file ( c-addr u -- c-addr' u' )
  sans-extname s" .sym" append-string ;

output-file to-symbol-file w/o create-file throw Value sym-out

: sym-cr
  #10 sym-out emit-file throw ;

: sym-write ( c-addr u -- )
  sym-out write-file throw
  sym-out flush-file throw  ;

: addr-to-str ( nn -- c-addr u )
  base @ >r
  hex
  0
  <<#
  # # # #
  #>
  #>>
  r> BASE ! ;

: sym-emit ( c-addr u nn -- )
  s" 00:"       sym-write
  addr-to-str   sym-write
  s"  "         sym-write
  ( c-addr u )  sym-write
  sym-cr ;