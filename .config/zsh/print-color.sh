function print-ansi-colors {
  for i in {0..255}; do
    print -P "%F{$i}Color $i%f"
  done
}
function print-ansi-colors-bg {
  for i in {0..255}; do
    print -P "%K{$i}  $i  %k"
  done
}
function print-test-true-colors {
  for r in 0 128 255; do
    for g in 0 128 255; do
      for b in 0 128 255; do
        print -P "%{\e[38;2;${r};${g};${b}m%}RGB ${r},${g},${b}%{\e[0m%}"
      done
    done
  done
}
