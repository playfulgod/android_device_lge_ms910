/*
 * Copyright (C) 2011-2012 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <termios.h>
#include <fcntl.h>

extern void nv_cmd_remote(int,int,void*);
extern void oncrpc_init();
extern void oncrpc_deinit();
extern void oncrpc_task_start();
extern void oncrpc_task_stop();


/* Get the BT address from the modem. Stock does this through
 * a RIL request, but I'd rather not pollute that API more than
 * it is already.
 * Get the wlan MAC from nv. This attempts to replicate the
 * wifi_read_wlanmac_address function from the stock software */

int main() {
	FILE *fd;
	struct termios  ios;
	char sync_buf[256];
	char *readbuf = sync_buf;
	char *mMacAddr;
	int old_flags;
	int wlanmac[2] = { 0, };
	int modem=0;
	int retries=5;
	int read_bytes=-1;

	modem=open("/dev/smd0",O_RDWR);
	if (modem<=0) {
		return 1;
	}
	tcgetattr( modem, &ios );
	ios.c_lflag = 0;
	tcsetattr( modem, TCSANOW, &ios );
	old_flags = fcntl(modem, F_GETFL, 0);
	fcntl(modem, F_SETFL, old_flags | O_NONBLOCK);
	while (read_bytes < 0 && retries) {
		read_bytes = write(modem,"AT%BTAD\r",8);
		sleep(1);
		retries--;
	}

	if (read_bytes > 0) {
		retries = 5;
		read_bytes = -1;
	}

	while (read_bytes < 0 && retries) {
		read_bytes = read(modem,sync_buf,sizeof(sync_buf));
		sleep(1);
		retries--;
	}
		
	if (read_bytes > 0) {
		/* Skip first echoed line */
		while (read_bytes && *readbuf != '\n' && *readbuf !='\0') {
			readbuf++;
			read_bytes--;
		}
		/* Nothing left */
		if (!read_bytes) { return 2; }

		/* Skip line break */
		readbuf++;
		read_bytes--;

		/* Nothing left */
		if (!read_bytes) { return 2; }

		mMacAddr = readbuf;

		while (*readbuf != '\r' && *readbuf != '\n' && *readbuf !='\0' && read_bytes) {
			readbuf++;
			read_bytes--;
		}
		*readbuf='\0';
		close(modem);

		/* Do we have something ? */
		if (strlen(mMacAddr)>2) {
			/* Chop off first and last chars */
			*mMacAddr++;
			*--readbuf='\0';
                }


		if (strlen(mMacAddr)==12) {
			fd = fopen("/data/misc/bd_addr","w");
			fprintf(fd,"%c%c:%c%c:%c%c:%c%c:%c%c:%c%c\n",mMacAddr[0], mMacAddr[1], mMacAddr[2], mMacAddr[3], mMacAddr[4], mMacAddr[5], mMacAddr[6], mMacAddr[7], mMacAddr[8], mMacAddr[9], mMacAddr[10], mMacAddr[11]);
			fclose(fd);
		}

	}

	oncrpc_init(); oncrpc_task_start();
	nv_cmd_remote(0,0x1246,&wlanmac);
	oncrpc_task_stop(); oncrpc_deinit();

	if (wlanmac[0] == 0)
		return 0;

	fd = fopen("/data/misc/wifi/config","w");
	fprintf(fd,"cur_etheraddr=%.2x:%.2x:%.2x:%.2x:%.2x:%.2x\n",
			wlanmac[0]&0xFF,
			(wlanmac[0]&0xFF00) >> 8,
			(wlanmac[0]&0xFF0000) >> 16,
			(wlanmac[0]&0xFF000000) >> 24,
			wlanmac[1]&0xFF,
			(wlanmac[1]&0xFF00) >> 8);
	fclose(fd);
	return 0;
}

