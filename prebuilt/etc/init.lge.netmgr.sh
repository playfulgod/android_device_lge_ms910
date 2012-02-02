#!/system/bin/sh
#to enable additional logging please uncomment the line below, all the logs will be saved to DBGFILE
DBGFILE="/data/netmgr.log" 
debug() {
	case "$DBGFILE" in
	"")
		;;
	*)
		echo "`date`: $*" >> $DBGFILE
		;;
	esac
}
MMRIL_CONF_PATH="/data/mmril"
op=`cat $MMRIL_CONF_PATH/lge.netmgr.op`
case "$op" in
# Configure bondX interface 
	"configure")
		debug "---->script started<----"
		echo 1 > $MMRIL_CONF_PATH/lge.netmgr.complete
		interfaces=`cat $MMRIL_CONF_PATH/lge.netmgr.configure`
		rm $MMRIL_CONF_PATH/lge.netmgr.op
		rm $MMRIL_CONF_PATH/lge.netmgr.configure
		debug "Configure " $interfaces
		for interface in $interfaces
		do
			iface_currstate=`cat /sys/class/net/$interface/operstate`
			case "$iface_currstate" in
				"up") 
					debug "Interface in UP state: perform down then up"
					ifconfig $interface down
					slaves=`cat /sys/class/net/$interface/bonding/slaves`
					for slave in $slaves
					do
						case $slave in
							l2k_eth*)
							echo -$slave >/sys/class/net/$interface/bonding/slaves
							ifconfig $slave down &
						;;
						esac
					done
					echo "" >/sys/class/net/$interface/bonding/active_slave
					echo "" >/sys/class/net/$interface/bonding/primary
					echo 0 > /proc/sys/net/ipv6/conf/$interface/disable_ipv6
					ip addr flush dev $interface &
					ip neigh flush dev $interface &
					ip route flush dev $interface &
					;;
			esac
			active_slave_new=`cat $MMRIL_CONF_PATH/lge.netmgr.$interface.active_slave`
			debug "Active: " $active_slave_new
			case $active_slave_new in
			l2k_eth*)
				cid=`cat $MMRIL_CONF_PATH/lge.netmgr.$interface.cid`
                        	debug "PDN = " $cid 
				echo $cid >/sys/class/net/$active_slave_new/pdn
			;;
			esac

			if ls /sys/class/net/$interface/bonding/slaves
			then
				slave1=`cat $MMRIL_CONF_PATH/lge.netmgr.$interface.slave1`
				case "$slave1" in
					"")
						;;
					*)
						echo +$slave1 >/sys/class/net/$interface/bonding/slaves
						;;
				esac
				slave2=`cat $MMRIL_CONF_PATH/lge.netmgr.$interface.slave2`
				case "$slave2" in
					"")
						;;
					*)
						echo +$slave2 >/sys/class/net/$interface/bonding/slaves
						;;
				esac
				slaves=`cat /sys/class/net/$interface/bonding/slaves`
				debug "Slaves: " $slaves
			else
				debug "Interface" $interface "seems does not started"
			fi

			echo $active_slave_new >/sys/class/net/$interface/bonding/active_slave
			echo $active_slave_new >/sys/class/net/$interface/bonding/primary

			mtu=`cat $MMRIL_CONF_PATH/net.$active_slave_new.mtu`
			case $mtu in
			"")
				mtu=`getprop net.mtu.default`
				debug "mtu size = "$mtu
			;;
			esac

			dns1=`getprop net.$active_slave_new.dns1`
			setprop net.$interface.dns1 $dns1
			dns2=`getprop net.$active_slave_new.dns2`
			setprop net.$interface.dns2 $dns2
			debug "$interface dns1 =" $dns1
			debug "$interface dns2 =" $dns2
			ipv4_type=`cat $MMRIL_CONF_PATH/lge.netmgr.$interface.ipv4_type`

			case "$ipv4_type" in
			"auto")
				echo 1 > /proc/sys/net/ipv6/conf/$interface/disable_ipv6
				debug "Run DHCP on "$interface
				netcfg $interface dhcp &
				;;
			"manual")
				echo 1 > /proc/sys/net/ipv6/conf/$interface/disable_ipv6
				addr=`cat $MMRIL_CONF_PATH/lge.netmgr.$interface.ipv4_addr`
				mask=`cat $MMRIL_CONF_PATH/lge.netmgr.$interface.ipv4_mask`
				gw=`cat $MMRIL_CONF_PATH/lge.netmgr.$interface.ipv4_gw`
				dns=`cat $MMRIL_CONF_PATH/lge.netmgr.$interface.ipv4_dns`
				echo "Manual cfg of $interface: addr=$addr, mask=$mask, gw=$gw, dns=$dns"
				ifconfig $interface $addr $mask
				route add default gw $gw dev $interface &
				;;
			"")
				debug "Bringing " $interface "up"
				echo 0 > /proc/sys/net/ipv6/conf/$interface/disable_ipv6

				iid=`cat $MMRIL_CONF_PATH/lge.netmgr.$interface.iid`
				eval echo $iid >/sys/class/net/$interface/iid

				ifconfig $interface up
				if ls $MMRIL_CONF_PATH/lge.netmgr.$interface.ipv6_gw
				then
					def_gw_flag=`cat $MMRIL_CONF_PATH/lge.netmgr.$interface.ipv6_gw`
					case "$def_gw_flag" in
						"1")
							debug $interface " assigned ipv6 default gateway"
							# set default gw as in MobileDataStateTracker.java android\frameworks\base\core\java\android\net
							busybox route -A inet6 add default gw fe80::1234:1234:1234 dev $interface &
							;;
					esac
					rm $MMRIL_CONF_PATH/lge.netmgr.$interface.ipv6_gw
				fi  
				;;
			esac
			ifconfig $interface mtu $mtu
		done
		setprop lge.netmgr.run 0
		run=`getprop lge.netmgr.run`
		debug "PROP run = "$run
		debug "script ended for "$interface 
		echo 2 > $MMRIL_CONF_PATH/lge.netmgr.complete
	;;
# Configure down bondX interface 
	"down")
		debug "---->script started<----"
		echo 1 > $MMRIL_CONF_PATH/lge.netmgr.complete 
		interfaces=`cat $MMRIL_CONF_PATH/lge.netmgr.configure`
		rm $MMRIL_CONF_PATH/lge.netmgr.op 
		rm $MMRIL_CONF_PATH/lge.netmgr.configure
		debug "Configure down " $interfaces
		for interface in $interfaces
		do
			iface_currstate=`cat /sys/class/net/$interface/operstate`
			case "$iface_currstate" in
				"up") 
					ifconfig $interface down
					slaves=`cat /sys/class/net/$interface/bonding/slaves`
					for slave in $slaves
					do
						debug "RM slave:" $slave						
						case $slave in
							l2k_eth*)
							echo -$slave >/sys/class/net/$interface/bonding/slaves
							ifconfig $slave down &
						;;
						esac						
					done
					echo "" >/sys/class/net/$interface/bonding/active_slave 
					echo "" >/sys/class/net/$interface/bonding/primary 
					echo 0 > /proc/sys/net/ipv6/conf/$interface/disable_ipv6 
					ip addr flush dev $interface &
					ip neigh flush dev $interface &
					ip route flush dev $interface &
					rm $MMRIL_CONF_PATH/lge.netmgr.$interface.* &
					case "$interface" in
						"bond0")
							rm $MMRIL_CONF_PATH/lge.dhcp.bond0.*
							;;
					esac
					;;
			  *)
				debug "Interface" $interface "already in down state"
				;;
			 esac   
		done
		setprop lge.netmgr.run 0
		run=`getprop lge.netmgr.run`
		debug "PROP run = "$run
		debug "script ended for "$interface 
		echo 2 > $MMRIL_CONF_PATH/lge.netmgr.complete
	;;
# Switch active_slave for bondX interface 
	"switch")
		debug "---->script started<----"
		echo 1 > $MMRIL_CONF_PATH/lge.netmgr.complete 
		interfaces=`cat $MMRIL_CONF_PATH/lge.netmgr.configure`
		rm $MMRIL_CONF_PATH/lge.netmgr.op 
		rm $MMRIL_CONF_PATH/lge.netmgr.configure
		for interface in $interfaces
		do
			iface_currstate=`cat /sys/class/net/$interface/operstate`
			case "$iface_currstate" in
				"up") 
					active_slave_new=`cat $MMRIL_CONF_PATH/lge.netmgr.$interface.active_slave`
					active_slave_old=`cat /sys/class/net/$interface/bonding/active_slave`
					debug "Switching from "$active_slave_old" to "$active_slave_new" for " $interfaces
					if ls /sys/class/net/$interface/bonding/slaves
					then
						cid=`cat $MMRIL_CONF_PATH/lge.netmgr.$interface.cid`
						case $active_slave_new in
						l2k_eth*)
							echo $cid >/sys/class/net/$active_slave_new/pdn
						;;
						esac

						echo $active_slave_new >/sys/class/net/$interface/bonding/active_slave 
						echo $active_slave_new >/sys/class/net/$interface/bonding/primary

						ipv4_type=`cat $MMRIL_CONF_PATH/lge.netmgr.$interface.ipv4_type`
						case "$ipv4_type" in
							"")
							debug "Switching for IPv6"
							case $active_slave_new in
								rmnet*)
									busybox ifconfig $interface add fe80::5 

									if ls $MMRIL_CONF_PATH/lge.netmgr.$interface.ipv6_gw
									then
										def_gw_flag=`cat $MMRIL_CONF_PATH/lge.netmgr.$interface.ipv6_gw`
										case "$def_gw_flag" in
												"1")
													debug $interface " assigned default gateway"
													# set default gw as in MobileDataStateTracker.java android\frameworks\base\core\java\android\net
													busybox route -A inet6 add default gw fe80::1234:1234:1234 dev $interface &
													;;
										esac	 
										rm $MMRIL_CONF_PATH/lge.netmgr.$interface.ipv6_gw
									fi  
									;;
								 l2k_eth*)
									busybox ifconfig  $interface del fe80::5 
								 ;;
							esac
							;;
						esac
					fi
					;;
				*)
				debug "Interface" $interface "seems does not started"
				;;
			esac
		done
		setprop lge.netmgr.run 0
		run=`getprop lge.netmgr.run`
		debug "PROP run = "$run
		debug "script ended for "$interface 
		echo 2 > $MMRIL_CONF_PATH/lge.netmgr.complete
	;;
# Init bond interfaces 
	"init")
		if ls /sys/class/net/bond7/bonding/mode
		then
			log_format_time=`date "+%Y.%m.%d:%H:%M:%S"`
			debug "RIL crash occurs - please look /data/ril_crash."$log_format_time
			echo "------------------> Java_log <---------------" > /data/ril_crash.$log_format_time
			logcat -v time -d >> /data/ril_crash.$log_format_time
			echo "------------------> Radio_log <--------------" >> /data/ril_crash.$log_format_time
			logcat -v time -d -b radio >> /data/ril_crash.$log_format_time
			echo "------------------> Kernel_log <-------------" >> /data/ril_crash.$log_format_time
			dmesg >> /data/ril_crash.$log_format_time
			echo "------------------> Netmgr_log <-------------" >> /data/ril_crash.$log_format_time
			cat /data/netmgr.log >> /data/ril_crash.$log_format_time
		else
			echo "script init" > $DBGFILE
			echo +bond1 >/sys/class/net/bonding_masters 
			echo +bond2 >/sys/class/net/bonding_masters 
			echo +bond3 >/sys/class/net/bonding_masters 
			echo +bond4 >/sys/class/net/bonding_masters 
			echo +bond5 >/sys/class/net/bonding_masters 
			echo +bond6 >/sys/class/net/bonding_masters 
			echo +bond7 >/sys/class/net/bonding_masters 
			echo "active-backup" >/sys/class/net/bond0/bonding/mode 
			echo "active-backup" >/sys/class/net/bond1/bonding/mode 
			echo "active-backup" >/sys/class/net/bond2/bonding/mode 
			echo "active-backup" >/sys/class/net/bond3/bonding/mode 
			echo "active-backup" >/sys/class/net/bond4/bonding/mode 
			echo "active-backup" >/sys/class/net/bond5/bonding/mode 
			echo "active-backup" >/sys/class/net/bond6/bonding/mode 
			echo "active-backup" >/sys/class/net/bond7/bonding/mode 
			rm $MMRIL_CONF_PATH/lge.netmgr.*
			rm $MMRIL_CONF_PATH/lge.dhcp.bond0.*
		fi
		setprop lge.netmgr.run 0
		run=`getprop lge.netmgr.run`
		debug "PROP run = "$run
		debug "script ended for init" 
	;;
esac
