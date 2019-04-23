for {set i 11} {$i < 13} {incr i} {
  for {set j 5} {$j < 6} {incr j} {

    echo "*********************************************************"
    echo "*Executing with PL_CYCLE_MAX = $i and IPG_CYCLE_MAX = $j*"
    echo "*********************************************************"

    do run.do $i $j 30 us
    exec cp transcript transcript_pl${i}_ipg${j}

  }
}

exit
