global num_servers
set num_servers to 12


on open_window_tabs()
	tell application "Terminal"
		activate
		-- Open a new window
		--   http://superuser.com/questions/195633/applescript-to-open-a-new-terminal-window-in-current-space
		do script "clear"
		-- set currentWindow to front window
		
		-- Open new tabs
		repeat (num_servers * 2 - 1) times
			tell application "System Events" to tell process "Terminal" to keystroke "t" using command down
		end repeat
	end tell
end open_window_tabs


on ssh()
	tell application "Terminal"
		set currentWindow to front window
		
		-- Without the delay, some connections are not made.
		set delay_after_ssh to 0.5
		
		set tab_id to 0
		set s_id to 0
		repeat until tab_id is (num_servers * 2)
			set tab_id to tab_id + 1
			set cmd to "sshs" & s_id
			do script (cmd) in tab tab_id of currentWindow
			delay delay_after_ssh
			
			set tab_id to tab_id + 1
			set cmd to "sshc" & s_id
			do script (cmd) in tab tab_id of currentWindow
			delay delay_after_ssh
			
			set s_id to s_id + 1
		end repeat
	end tell
end ssh


on screen()
	tell application "Terminal"
		set currentWindow to front window
		
		set tab_id to 0
		repeat until tab_id is (num_servers * 2)
			set tab_id to tab_id + 1
			set cmd to "screen"
			do script (cmd) in tab tab_id of currentWindow
			set cmd to " "
			do script (cmd) in tab tab_id of currentWindow
		end repeat
	end tell
end screen


on install_pkgs_0()
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 0
		repeat until tab_id is (num_servers * 2)
			set tab_id to tab_id + 1
			set cmd to "sudo add-apt-repository -y ppa:webupd8team/java"
			set cmd to cmd & " && sudo apt-get update"
			set cmd to cmd & " && sudo apt-get install oracle-java8-installer git ctags ant htop tree maven gnuplot-nox ntp ioping realpath make gcc cmake g++ libboost-dev libboost-system-dev libboost-timer-dev collectl -y"
			set cmd to cmd & " && sudo apt-get autoremove -y vim-tiny"
			set cmd to cmd & " && mkdir -p ~/work"
			set cmd to cmd & " && cd ~/work"
			set cmd to cmd & " && git clone https://github.com/hoytech/vmtouch.git"
			set cmd to cmd & " && cd vmtouch"
			set cmd to cmd & " && make -j"
			set cmd to cmd & " && sudo make install"
			set cmd to cmd & " && sudo service ntp stop"
			set cmd to cmd & " && sudo ntpdate -bv 0.ubuntu.pool.ntp.org"
			set cmd to cmd & " && sudo service ntp start"
			set cmd to cmd & " && cd ~/work"
			set cmd to cmd & " && git clone git@github.com:hobinyoon/linux-home.git"
			set cmd to cmd & " && cd linux-home"
			set cmd to cmd & " && ./setup-linux.sh"
			do script (cmd) in tab tab_id of currentWindow
		end repeat
	end tell
end install_pkgs_0


on install_pkgs_1()
	tell application "Terminal" to activate
	set tab_id to 0
	repeat until tab_id is (num_servers * 2)
		set tab_id to tab_id + 1
		tell application "System Events" to key code 36 -- enter
		delay 0.2
		tell application "System Events" to key code 123 -- left
		tell application "System Events" to key code 36 -- enter
		tell application "System Events" to key code 124 using {shift down, command down} -- move to the next tab
		delay 0.1
	end repeat
end install_pkgs_1


-- Sometimes the previous step takes forever. Need to make sure.
on install_pkgs_2()
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 0
		repeat until tab_id is (num_servers * 2)
			set tab_id to tab_id + 1
			set cmd to "yes"
			do script (cmd) in tab tab_id of currentWindow
			delay 0.1
		end repeat
	end tell
end install_pkgs_2


on killall_screen()
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 0
		repeat until tab_id is (num_servers * 2)
			set tab_id to tab_id + 1
			set cmd to "killall screen"
			do script (cmd) in tab tab_id of currentWindow
		end repeat
	end tell
end killall_screen


on exit_screen()
	tell application "Terminal" to activate
	set tab_id to 0
	repeat until tab_id is num_servers
		set tab_id to tab_id + 1
		tell application "System Events" to keystroke "d" using {control down}
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke "X"
		
		tell application "System Events" to keystroke "d" using {control down}
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke "X"
		
		tell application "System Events" to keystroke "d" using {control down}
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke "X"
		
		tell application "System Events" to keystroke "d" using {control down}
		tell application "System Events" to keystroke "d" using {control down}
		delay 0.1
		
		-- Move to the right
		tell application "System Events" to key code 124 using {shift down, command down}
		
		tell application "System Events" to keystroke "d" using {control down}
		tell application "System Events" to keystroke "d" using {control down}
		delay 0.1
		
		-- Move to the right
		tell application "System Events" to key code 124 using {shift down, command down}
	end repeat
end exit_screen


on server_screen_split_htop()
	tell application "Terminal" to activate
	set tab_id to 0
	repeat until tab_id is num_servers
		set tab_id to tab_id + 1
		
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke "S"
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke "c"
		tell application "System Events" to keystroke "htop"
		tell application "System Events" to key code 36
		
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke "S"
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke "c"
		tell application "System Events" to keystroke "watch -n 0.5 \"free -mt\""
		tell application "System Events" to key code 36
		
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke "S"
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke "c"
		
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		
		-- Move 2 to the right, since S and C take turns.
		--   124: right arrow
		tell application "System Events" to key code 124 using {shift down, command down}
		tell application "System Events" to key code 124 using {shift down, command down}
		delay 0.1
	end repeat
end server_screen_split_htop


on client_screen_split_htop()
	tell application "Terminal" to activate
	set tab_id to 0
	-- Start from the 2nd tab, which is the first client tab
	tell application "System Events" to key code 124 using {shift down, command down}
	repeat until tab_id is num_servers
		set tab_id to tab_id + 1
		
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke "S"
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke "c"
		tell application "System Events" to keystroke "htop"
		tell application "System Events" to key code 36
		
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		
		-- Move 2 to the right, since S and C take turns.
		--   124: right arrow
		tell application "System Events" to key code 124 using {shift down, command down}
		tell application "System Events" to key code 124 using {shift down, command down}
		delay 0.1
	end repeat
	
	-- Set the current tab to the 1st one
	tell application "System Events" to key code 123 using {shift down, command down}
	
end client_screen_split_htop


on build_cass_pressuremem_loadgen()
	tell application "Terminal"
		set currentWindow to front window
		
		-- Without the delay, some connections are not made.
		set delay_after_ssh to 0.2
		
		set tab_id to 0
		set s_id to 0
		repeat until tab_id is (num_servers * 2)
			set tab_id to tab_id + 1
			set cmd to "cd ~/work && git clone git@github.com:hobinyoon/apache-cassandra-2.2.3-src.git && ln -s ~/work/apache-cassandra-2.2.3-src ~/work/cassandra && cd ~/work/cassandra/mtdb/tools/pressure-memory && mkdir -p .build && cd .build && cmake .. && make -j && cdcass && time ant"
			do script (cmd) in tab tab_id of currentWindow
			delay delay_after_ssh
			
			set tab_id to tab_id + 1
			set cmd to "cd ~/work && git clone git@github.com:hobinyoon/apache-cassandra-2.2.3-src.git && ln -s ~/work/apache-cassandra-2.2.3-src ~/work/cassandra && cd ~/work/cassandra/mtdb/loadgen && ./loadgen"
			do script (cmd) in tab tab_id of currentWindow
			delay delay_after_ssh
			
			set s_id to s_id + 1
		end repeat
	end tell
end build_cass_pressuremem_loadgen


on git_pull()
	tell application "Terminal" to activate
	set tab_id to 0
	repeat until tab_id is (num_servers * 2)
		set tab_id to tab_id + 1
		tell application "System Events" to keystroke "c" using {control down}
		
		-- Move to the next tab
		tell application "System Events" to key code 124 using {shift down, command down}
		delay 0.1
	end repeat
	
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 0
		repeat until tab_id is (num_servers * 2)
			set tab_id to tab_id + 1
			set cmd to "cdcass && git pull"
			do script (cmd) in tab tab_id of currentWindow
		end repeat
	end tell
end git_pull


on server_format_ebs_mag_mount_dev_prepare_dirs()
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 1
		repeat until tab_id > (num_servers * 2)
			set cmd to "sudo mkfs.ext4 -m 0 /dev/xvdd"
			set cmd to cmd & " && sudo cp ~/work/cassandra/mtdb/ec2-tools/etc-fstab /etc/fstab"
			set cmd to cmd & " && sudo umount /mnt"
			set cmd to cmd & " && sudo mkdir -p /mnt/local-ssd"
			set cmd to cmd & " && sudo mount /mnt/local-ssd"
			set cmd to cmd & " && sudo chown -R ubuntu /mnt/local-ssd"
			set cmd to cmd & " && mkdir /mnt/local-ssd/cass-data"
			set cmd to cmd & " && mkdir ~/cass-data-vol"
			set cmd to cmd & " && sudo ln -s ~/cass-data-vol /mnt/ebs-ssd-gp2"
			set cmd to cmd & " && mkdir /mnt/ebs-ssd-gp2/cass-data"
			set cmd to cmd & " && sudo mkdir -p /mnt/ebs-mag"
			set cmd to cmd & " && sudo mount /mnt/ebs-mag"
			set cmd to cmd & " && sudo mkdir /mnt/ebs-mag/cass-data"
			set cmd to cmd & " && sudo chown -R ubuntu /mnt/ebs-mag"
			set cmd to cmd & " && sudo chown -R ubuntu /mnt/ebs-mag/cass-data"
			set cmd to cmd & " && sudo mkdir -p /mnt/ebs-ssd-gp2/mtdb-cold"
			set cmd to cmd & " && (sudo mkdir -p /mnt/ebs-mag/mtdb-cold || true)"
			set cmd to cmd & " && sudo ln -s /mnt/ebs-mag /mnt/cold-storage"
			set cmd to cmd & " && sudo chown -R ubuntu /mnt/ebs-ssd-gp2"
			set cmd to cmd & " && sudo chown -R ubuntu /mnt/cold-storage"
			set cmd to cmd & " && sudo chown -R ubuntu /mnt/cold-storage/mtdb-cold"
			set cmd to cmd & " && mkdir -p ~/work/cassandra/mtdb/logs/collectl"
			set cmd to cmd & " && ln -s /mnt/local-ssd/cass-data ~/work/cassandra/data"
			do script (cmd) in tab tab_id of currentWindow
			
			-- Go to the next server tab
			set tab_id to tab_id + 2
		end repeat
	end tell
end server_format_ebs_mag_mount_dev_prepare_dirs


on server_mount_dev_prepare_dirs_cass_data_to_ebs_ssd()
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 1
		repeat until tab_id > (num_servers * 2)
			set cmd to "sudo cp ~/work/cassandra/mtdb/ec2-tools/etc-fstab /etc/fstab"
			set cmd to cmd & " && sudo umount /mnt"
			set cmd to cmd & " && sudo mkdir -p /mnt/local-ssd"
			set cmd to cmd & " && sudo mount /mnt/local-ssd"
			set cmd to cmd & " && sudo chown -R ubuntu /mnt/local-ssd"
			set cmd to cmd & " && mkdir /mnt/local-ssd/cass-data"
			set cmd to cmd & " && mkdir ~/cass-data-vol"
			set cmd to cmd & " && sudo ln -s ~/cass-data-vol /mnt/ebs-ssd-gp2"
			set cmd to cmd & " && mkdir /mnt/ebs-ssd-gp2/cass-data"
			set cmd to cmd & " && sudo mkdir -p /mnt/ebs-ssd-gp2/mtdb-cold"
			set cmd to cmd & " && sudo ln -s /mnt/ebs-ssd-gp2 /mnt/cold-storage"
			set cmd to cmd & " && sudo chown -R ubuntu /mnt/ebs-ssd-gp2"
			set cmd to cmd & " && sudo chown -R ubuntu /mnt/cold-storage"
			set cmd to cmd & " && sudo chown -R ubuntu /mnt/cold-storage/mtdb-cold"
			set cmd to cmd & " && mkdir -p ~/work/cassandra/mtdb/logs/collectl"
			set cmd to cmd & " && ln -s /mnt/ebs-ssd-gp2/cass-data ~/work/cassandra/data"
			do script (cmd) in tab tab_id of currentWindow
			
			-- Go to the next server tab
			set tab_id to tab_id + 2
		end repeat
	end tell
end server_mount_dev_prepare_dirs_cass_data_to_ebs_ssd


on server_mount_dev_prepare_dirs_cass_data_to_local_ssd_cold_data_to_ebs_ssd()
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 1
		repeat until tab_id > (num_servers * 2)
			set cmd to "sudo cp ~/work/cassandra/mtdb/ec2-tools/etc-fstab /etc/fstab"
			set cmd to cmd & " && sudo umount /mnt"
			set cmd to cmd & " && sudo mkdir -p /mnt/local-ssd"
			set cmd to cmd & " && sudo mount /mnt/local-ssd"
			set cmd to cmd & " && sudo chown -R ubuntu /mnt/local-ssd"
			set cmd to cmd & " && mkdir /mnt/local-ssd/cass-data"
			set cmd to cmd & " && mkdir ~/cass-data-vol"
			set cmd to cmd & " && sudo ln -s ~/cass-data-vol /mnt/ebs-ssd-gp2"
			set cmd to cmd & " && mkdir /mnt/ebs-ssd-gp2/cass-data"
			set cmd to cmd & " && sudo mkdir -p /mnt/ebs-ssd-gp2/mtdb-cold"
			set cmd to cmd & " && sudo ln -s /mnt/ebs-ssd-gp2 /mnt/cold-storage"
			set cmd to cmd & " && sudo chown -R ubuntu /mnt/ebs-ssd-gp2"
			set cmd to cmd & " && sudo chown -R ubuntu /mnt/cold-storage"
			set cmd to cmd & " && sudo chown -R ubuntu /mnt/cold-storage/mtdb-cold"
			set cmd to cmd & " && mkdir -p ~/work/cassandra/mtdb/logs/collectl"
			set cmd to cmd & " && ln -s /mnt/local-ssd/cass-data ~/work/cassandra/data"
			do script (cmd) in tab tab_id of currentWindow
			
			-- Go to the next server tab
			set tab_id to tab_id + 2
		end repeat
	end tell
end server_mount_dev_prepare_dirs_cass_data_to_local_ssd_cold_data_to_ebs_ssd


on server_edit_cassandra_yaml()
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 1
		repeat until tab_id > (num_servers * 2)
			set cmd to "sed -i -r 's/^    migrate_to_cold_storage:.+/    migrate_to_cold_storage: true/' ~/work/cassandra/conf/cassandra.yaml"
			do script (cmd) in tab tab_id of currentWindow
			set cmd to "sed -i -r 's/^    tablet_coldness_threshold:.+/    tablet_coldness_threshold: 75/' ~/work/cassandra/conf/cassandra.yaml"
			do script (cmd) in tab tab_id of currentWindow
			set cmd to "grep migrate_to_cold_storage: ~/work/cassandra/conf/cassandra.yaml"
			do script (cmd) in tab tab_id of currentWindow
			set cmd to "grep tablet_coldness_threshold: ~/work/cassandra/conf/cassandra.yaml"
			do script (cmd) in tab tab_id of currentWindow
			
			-- Go to the next server tab
			set tab_id to tab_id + 2
		end repeat
	end tell
end server_edit_cassandra_yaml


on client_edit_cassandra_yaml()
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 2
		repeat until tab_id > (num_servers * 2)
			set cmd to "sed -i -r 's/^        num_writes_per_simulation_time_mins:.+/        num_writes_per_simulation_time_mins: " & (tab_id * 5000) & "/' ~/work/cassandra/conf/cassandra.yaml"
			do script (cmd) in tab tab_id of currentWindow
			set cmd to "grep num_writes_per_simulation_time_mins: ~/work/cassandra/conf/cassandra.yaml"
			do script (cmd) in tab tab_id of currentWindow
			
			-- Go to the next client tab
			set tab_id to tab_id + 2
		end repeat
	end tell
end client_edit_cassandra_yaml


on save_screen_layout()
	tell application "Terminal" to activate
	set tab_id to 0
	repeat until tab_id is (num_servers * 2)
		set tab_id to tab_id + 1
		
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke ":layout save default"
		tell application "System Events" to key code 36
		
		-- Move to the next tab
		tell application "System Events" to key code 124 using {shift down, command down}
		delay 0.1
	end repeat
end save_screen_layout


-- One-time fix. Won't need again
on mkdir_collectl()
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 1
		repeat until tab_id > (num_servers * 2)
			set cmd to "mkdir ~/work/cassandra/mtdb/logs/collectl"
			do script (cmd) in tab tab_id of currentWindow
			-- Go to the next server tab
			set tab_id to tab_id + 2
		end repeat
	end tell
end mkdir_collectl


on run_server()
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 1
		repeat until tab_id > (num_servers * 2)
			set cmd to "sudo -- sh -c 'echo 1 > /proc/sys/vm/drop_caches' && cdcass && time ant && rm -rf ~/work/cassandra/data/* && rm -rf /mnt/cold-storage/mtdb-cold/* && (killall mon-num-cass-threads.sh >/dev/null 2>&1 || true) && (~/work/cassandra/mtdb/tools/mon-num-cass-threads.sh &) && (killall collectl >/dev/null 2>&1 || true) && ((collectl -i 1 -sCDN -oTm > ~/work/cassandra/mtdb/logs/collectl/collectl-`date +'%y%m%d-%H%M%S'` 2>/dev/null) &) && bin/cassandra -f | grep --color -E '^|MTDB:'"
			do script (cmd) in tab tab_id of currentWindow
			-- Give enough delay to make sure the logs have different datetimes.
			delay 3
			
			-- Go to the next server tab
			set tab_id to tab_id + 2
		end repeat
	end tell
end run_server


on server_pressure_memory()
	tell application "Terminal" to activate
	
	set tab_id to 0
	repeat until tab_id is num_servers
		set tab_id to tab_id + 1
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		-- Move to the next server tab
		tell application "System Events" to key code 124 using {shift down, command down}
		tell application "System Events" to key code 124 using {shift down, command down}
		delay 0.1
	end repeat
	
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 1
		repeat until tab_id > (num_servers * 2)
			set cmd to "cd ~/work/cassandra/mtdb/tools/pressure-memory/.build"
			set cmd to cmd & " && (./pressure-memory &)"
			set cmd to cmd & " && watchsstables"
			do script (cmd) in tab tab_id of currentWindow
			
			-- Go to the next server tab
			set tab_id to tab_id + 2
		end repeat
	end tell
	
	set tab_id to 0
	repeat until tab_id is num_servers
		set tab_id to tab_id + 1
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		-- Move to the next server tab
		tell application "System Events" to key code 124 using {shift down, command down}
		tell application "System Events" to key code 124 using {shift down, command down}
		delay 0.1
	end repeat
end server_pressure_memory


on client_run_loadgen()
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 2
		repeat until tab_id > (num_servers * 2)
			set cmd to "cd ~/work/cassandra/mtdb/loadgen && ./create-db.sh && ./loadgen"
			do script (cmd) in tab tab_id of currentWindow
			-- Make sure we get different exp datetime
			delay 2
			-- Go to the next client tab
			set tab_id to tab_id + 2
		end repeat
	end tell
end client_run_loadgen


on screen_detach()
	tell application "Terminal" to activate
	set tab_id to 0
	repeat until tab_id is (num_servers * 2)
		set tab_id to tab_id + 1
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke "d"
		delay 0.1
		-- Move to the next tab
		tell application "System Events" to key code 124 using {shift down, command down}
	end repeat
end screen_detach


on screen_reattach()
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 1
		repeat until tab_id > (num_servers * 2)
			set cmd to "screen -r"
			do script (cmd) in tab tab_id of currentWindow
			-- Go to the next tab
			set tab_id to tab_id + 1
		end repeat
	end tell
end screen_reattach


on server_get_client_logs_and_process()
	tell application "Terminal" to activate
	
	set tab_id to 0
	repeat until tab_id is num_servers
		set tab_id to tab_id + 1
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		tell application "System Events" to keystroke "c" using {control down}
		
		-- Move to the next server tab
		tell application "System Events" to key code 124 using {shift down, command down}
		tell application "System Events" to key code 124 using {shift down, command down}
		delay 0.1
	end repeat
	
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 1
		repeat until tab_id > (num_servers * 2)
			set cmd to "(killall pressure-memory > /dev/null 2>&1 || true) && (sudo killall collectl > /dev/null 2>&1 || true) && (sudo killall mon-num-cass-threads.sh > /dev/null 2>&1 || true) && rsync -ave \"ssh -o StrictHostKeyChecking=no\" $CASSANDRA_CLIENT_ADDR:work/cassandra/mtdb/logs/loadgen ~/work/cassandra/mtdb/logs && cd ~/work/cassandra/mtdb/process-log/calc-cost-latency-plot-tablet-timeline && (\\rm *.pdf || true) && ./plot-cost-latency-tablet-timelines.py && du -hs ~/work/cassandra/data/"
			do script (cmd) in tab tab_id of currentWindow
			-- Go to the next server tab
			set tab_id to tab_id + 2
		end repeat
	end tell
	
	set tab_id to 0
	repeat until tab_id is num_servers
		set tab_id to tab_id + 1
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		-- Move to the next server tab
		tell application "System Events" to key code 124 using {shift down, command down}
		tell application "System Events" to key code 124 using {shift down, command down}
		delay 0.1
	end repeat
end server_get_client_logs_and_process


-- One-time fix. Won't need again
on server_rename_client_log()
	tell application "Terminal" to activate
	
	set tab_id to 0
	repeat until tab_id is num_servers
		set tab_id to tab_id + 1
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		-- Move to the next server tab
		tell application "System Events" to key code 124 using {shift down, command down}
		tell application "System Events" to key code 124 using {shift down, command down}
		delay 0.1
	end repeat
	
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 1
		repeat until tab_id > (num_servers * 2)
			-- I don't like the float division. oh well.
			set cmd to "mv ~/work/cassandra/mtdb/logs/loadgen/160302-023811 ~/work/cassandra/mtdb/logs/loadgen/160302-023811-" & ((tab_id - 1) / 2) & " && mv ~/work/cassandra/mtdb/logs/cassandra/160302-023811 ~/work/cassandra/mtdb/logs/cassandra/160302-023811-" & ((tab_id - 1) / 2)
			do script (cmd) in tab tab_id of currentWindow
			-- Go to the next server tab
			set tab_id to tab_id + 2
		end repeat
	end tell
	
	set tab_id to 0
	repeat until tab_id is num_servers
		set tab_id to tab_id + 1
		tell application "System Events" to keystroke "a" using {control down}
		tell application "System Events" to keystroke tab
		-- Move to the next server tab
		tell application "System Events" to key code 124 using {shift down, command down}
		tell application "System Events" to key code 124 using {shift down, command down}
		delay 0.1
	end repeat
end server_rename_client_log


-- One-time use.
on server_kill_monitor_processes()
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 1
		repeat until tab_id > (num_servers * 2)
			set cmd to "(killall pressure-memory > /dev/null 2>&1 || true) && (sudo killall collectl > /dev/null 2>&1 || true) && (sudo killall mon-num-cass-threads.sh > /dev/null 2>&1 || true)"
			do script (cmd) in tab tab_id of currentWindow
			-- Go to the next server tab
			set tab_id to tab_id + 2
		end repeat
	end tell
end server_kill_monitor_processes


on server_switch_data_dir_to_ebs_mag()
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 1
		repeat until tab_id > (num_servers * 2)
			set cmd to "cdcass"
			set cmd to cmd & " && \\rm data"
			set cmd to cmd & " && ln -s /mnt/ebs-mag/cass-data data"
			do script (cmd) in tab tab_id of currentWindow
			-- Go to the next server tab
			set tab_id to tab_id + 2
		end repeat
	end tell
end server_switch_data_dir_to_ebs_mag


on server_switch_data_dir_to_local_ssd()
	tell application "Terminal"
		set currentWindow to front window
		set tab_id to 1
		repeat until tab_id > (num_servers * 2)
			set cmd to "cdcass"
			set cmd to cmd & " && \\rm data"
			set cmd to cmd & " && ln -s /mnt/local-ssd/cass-data data"
			do script (cmd) in tab tab_id of currentWindow
			-- Go to the next server tab
			set tab_id to tab_id + 2
		end repeat
	end tell
end server_switch_data_dir_to_local_ssd


on open_window_tabs_ssh_screen()
	my open_window_tabs()
	my ssh()
	my screen()
end open_window_tabs_ssh_screen


on run_all()
	my open_window_tabs_ssh_screen()
	
	my install_pkgs_0()
	my install_pkgs_1()
	my install_pkgs_2()
	
	-- Not a normal process. In case something goes wrong.
	-- my exit_screen()
	
	-- Need to logout and login again to make the new .bashrc in effect
	-- Hit ^D until all tabs are closed
	my open_window_tabs_ssh_screen()
	
	-- These can be grouped
	my server_screen_split_htop()
	my client_screen_split_htop()
	my build_cass_pressuremem_loadgen()
	
	my save_screen_layout()
	my screen_detach()
	my screen_reattach()
	
	-- Run either of these, depending on what dev you have
	-- my server_format_ebs_mag_mount_dev_prepare_dirs()
	-- my server_mount_dev_prepare_dirs_cass_data_to_ebs_ssd()
	my server_mount_dev_prepare_dirs_cass_data_to_local_ssd_cold_data_to_ebs_ssd()
	
	-- Switch data directory to ebs mag
	-- my server_switch_data_dir_to_ebs_mag()
	
	-- Make sure which experiment you want, by editing migrate_to_cold_storage
	my server_edit_cassandra_yaml()
	my client_edit_cassandra_yaml()
	
	-- This takes some time to make sure each server has different exp datetime
	my run_server()
	
	-- Wait till all servers are ready before pressuring memory
	my server_pressure_memory()
	
	-- This takes some time too.
	my client_run_loadgen()
	
	-- Detach screen to save network traffic while running experiments
	my save_screen_layout()
	my screen_detach()
	
	-- May want to check the last tabs to see if the system saturates or cold sstables are created
	
	-- When done, reattach the screen and process the logs
	my screen_reattach()
	my server_get_client_logs_and_process()
	
	-- Switch data directory to ebs mag
	-- my server_switch_data_dir_to_ebs_mag()
end run_all

