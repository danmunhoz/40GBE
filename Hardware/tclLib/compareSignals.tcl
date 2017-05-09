#------------------------------------------------------------------------
# compareSignals
#------------------------------------------------------------------------
# Used to organize debug nets after the synthesis phase through the
# lsort function.
#------------------------------------------------------------------------

proc compareSignals {arg1 arg2} {
  set hierarchy1 [split $arg1 {/}]
  set hierarchy2 [split $arg2 {/}]
  if {[expr {[llength $hierarchy1] ne [llength $hierarchy1]}]} {
    return [expr {[llength $hierarchy1] - [llength $hierarchy1]}]
  }

  for {set i 0} {$i < [llength $hierarchy1]} {incr i} {
    if {[lindex $hierarchy1 $i] == [lindex $hierarchy2 $i]} {
      continue
    }
    if {[regexp {(.*)\[\d+\]} [lindex $hierarchy1 $i] -> n1] && [regexp {(.*)\[\d+\]} [lindex $hierarchy2 $i] -> n2]} {
      if {![string equal $n1 $n2]} {
        return [string compare $arg1 $arg2]
      }
    }
    if {[regexp {.*\[(\d+)\]} [lindex $hierarchy1 $i] -> n1] && [regexp {.*\[(\d+)\]} [lindex $hierarchy2 $i] -> n2]} {
      return [expr {$n1 - $n2}]
    }
    if {[regexp {.*(\d+)} [lindex $hierarchy1 $i] -> n1] && [regexp {.*(\d+)} [lindex $hierarchy2 $i] -> n2]} {
      return [expr {$n1 - $n2}]
    }
    if {[expr {[llength [lindex $hierarchy1 $i]] ne [llength [lindex $hierarchy2 $i]]}]} {
      return [expr {[llength [lindex $hierarchy1 $i]] - [llength [lindex $hierarchy2 $i]]}]
    }
    return [string compare $arg1 $arg2]
  }
}
