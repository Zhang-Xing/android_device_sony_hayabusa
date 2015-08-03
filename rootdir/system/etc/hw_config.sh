# Audio jack configuration
dev=/sys/devices/platform/msm_ssbi.0/pm8921-core/simple_remote_pf/simple_remote
echo 0,301 > $dev/accessory_min_vals
echo 300,1900 > $dev/accessory_max_vals
echo 0,100,280,500 > $dev/button_min_vals
echo 99,199,399,699 > $dev/button_max_vals
echo 512 > $dev/btn_trig_period_freq  # Button Period Freq(Hz)
echo 16 > $dev/btn_trig_period_time   # Button Period Time(Cycle)
echo 512 > $dev/btn_trig_hyst_freq    # Button Hysteresis Freq(Hz)
echo 16 > $dev/btn_trig_hyst_time     # Button Hysteresis Time(Cycle)
echo 400 > $dev/btn_trig_level

# Proximity sensor configuration
dev=/sys/bus/i2c/devices/i2c-12/12-0054/
val_cycle=1
val_nburst=8
val_freq=2
val_threshold=6
val_filter=2

ta_param_loader 60240 prox_cal
val_calibrated=$?
case $val_calibrated in
 1)
  ta_param_loader 60240 threshold
  val_threshold=$?
  ta_param_loader 60240 rfilter
  val_filter=$?
  ;;
esac

echo $val_cycle > $dev/cycle    # Duration Cycle. Valid range is 0 - 3.
echo $val_nburst > $dev/nburst  # Number of pulses in burst. Valid range is 0 - 15.
echo $val_freq > $dev/freq      # Burst frequency. Valid range is 0 - 3.
echo $val_threshold > $dev/threshold # sensor threshold. Valid range is 0 - 15 (0.12V - 0.87V)
echo $val_filter > $dev/filter  # RFilter. Valid range is 0 - 3.
