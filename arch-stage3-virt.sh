#!/usr/bin/env bash

# static hugepages
## /etc/default/grub
## hugepages=16 default_hugepagesz=1G hugepagesz=1G hugepages=X transparent_hugepage=never
#should be 16GB...

# nvidia 
# VM definition, try the "modern" way,
## ...
## <features>
## 	<hyperv>
## 		...
## 		<vendor_id state='on' value='whatever'/>
## 		...
## 	</hyperv>
## 	...
## 	<kvm>
## 	<hidden state='on'/>
## 	</kvm>
## </features>
## ...
# didn't seem to work, so changed to the:
## ...
## <clock offset='localtime'>
## 	<timer name='hypervclock' present='no'/>
## </clock>
## ...
## <features>
## 	<kvm>
## 	<hidden state='on'/>
## 	</kvm>
## 	...
## 	<hyperv>
## 		<relaxed state='off'/>
## 		<vapic state='off'/>
## 		<spinlocks state='off'/>
## 	</hyperv>
## 	...
## </features>
## ...
#since that also didn't work, I'm adding:
# kernel parameter video=efifb:off

#xcontinued down arch vfio guide for nvidia code 43 issues - found newest bios rom on https://www.techpowerup.com/vgabios/187068/asus-gtx1070-8192-161020-1
## Build Date            : 10/07/16
## Modification Date     : 10/20/16

# to use in place of the ROM version on teh card: 86.04.26.00.61 from 
## Build Date            : 06/20/16
## Modification Date     : 07/11/16
# inside vm xml only

