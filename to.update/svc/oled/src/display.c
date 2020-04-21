/*************************************************************************
**************************************************************************/

#include <string.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "ssd1306_i2c.h"

static volatile int loop = 1;

// interrupt signal handler
void intHandler(int sig) {
    loop = 0;
}

void remove_a_char(char* str, char c) {
  char *pr = str, *pw = str;
  while (*pr) {
    *pw = *pr++;
    pw += (*pw != c);
  }
  *pw = '\0';
}

void fetch(char *cmd, char *output, int length) {
  FILE *fp;
  
  fp = popen(cmd, "r");
  if( fp == NULL) {
  } else {
    if (fgets(output, length, fp) != NULL) {
      // remove newline if any
      int len = strlen(output);
      if (len > 0 && output[len-1] == '\n') {
	output[--len] = '\0';
      }
    }
    pclose(fp);
  }
}

int main(int argc, char* argv[]) {
  int refresh_interval = 5;

  char line[64];
  unsigned char str[64];
  int fd;  

  int page = 0;

  signal(SIGINT, intHandler);

  fd = ssd1306I2CSetup(0x3C);  // init SSD1306 and I2C interface
  displayOn(fd);  

  while(loop) {
    if(argc == 2) // when run in via cmd line or /etc/rc.lcoal
      fetch("ip addr show br0 | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/'", line, sizeof(line)-1);
    else
      fetch("hostname -I | cut -d' ' -f1", line, sizeof(line)-1);
    sprintf(str, "%s", line);
    draw_line(1, 1, str);

    // printf(">>%s<<\n", str);

    fetch("cat /sys/class/net/eth0/address", line, sizeof(line)-1);
    remove_a_char(line, ':');
    sprintf(str, "MAC %s", line);
    draw_line(2, 1, str);

    //    printf(">>%s<<\n", str);
    
    fetch("top -bn1 | grep load | awk '{printf \"DC %.2f%%\", $(NF-2)}'", line, sizeof(line)-1);
    draw_line(3, 1, line);

    //    printf(">>%s<<\n", line);

    if(page == 0) {
      //      fetch("free -m | awk 'NR==2{printf \"MM %s/%sMB %.0f%%\", $3,$2,$3*100/$2 }'", line, sizeof(line)-1);
      fetch("free -m | awk 'NR==2{printf \"MM %s/%sMB\", $3, $2}'", line, sizeof(line)-1);
      draw_line(4, 1, line);
      page = 1;
    } else {
      fetch("df -h | awk '$NF==\"/\"{printf \"SD  %d/%dGB %s\", $3,$2,$5}'", line, sizeof(line)-1);
      draw_line(4, 1, line);
      page = 0;
    }

    //    printf(">>%s<<\n", line);
    
    updateDisplay(fd);
    sleep(refresh_interval);
    clearDisplay(fd);
  }

  return 0;
}
