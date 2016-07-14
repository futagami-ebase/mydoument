#!/usr/bin/expect
proc _login { id host pass } {
  expect {
    "Are you sure you want to continue connecting (yes/no)?" {
      send "yes\n"
      expect "${id}@${host}'s password:"
      send \"${pass}\n\"
    } 
    "${id}@${host}'s password:" {
        send "${pass}\n"
    }
  }
}
