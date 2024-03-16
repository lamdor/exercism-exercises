proc abbreviate {phrase} {
  set acronym ""

  set matches [regexp -all -inline {[A-Za-z']+} $phrase ]
  foreach word $matches {
    set firstChar [string toupper [string index $word 0]]
    set acronym "$acronym$firstChar"
  }

  return $acronym
}
