
set i_begin $::env(i_begin)
set i_end $::env(i_end)
set j_begin $::env(j_begin)
set j_end $::env(j_end)
set time_sim $::env(time_sim)
set time_unit $::env(time_unit)


for {set i $i_begin} {$i <= $i_end} {incr i} {
  for {set j $j_begin} {$j <= $j_end} {incr j} {

    echo "*********************************************************"
    echo "*Executing with PL_CYCLE_MAX = $i and IPG_CYCLE_MAX = $j*"
    echo "*********************************************************"

    do run.do $i $j $time_sim $time_unit
    exec cp transcript transcript_pl${i}_ipg${j}

  }
}

exit
