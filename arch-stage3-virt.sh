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
