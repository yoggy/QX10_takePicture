//
// $ /opt/CodeSourcery/Sourcery_CodeBench_Lite_for_MIPS_GNU_Linux/bin/mips-linux-gnu-gcc QX10_takePicture.c -o QX10_takePicture -static
//
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

#define BUF_SIZE	1024
char buf[BUF_SIZE];

const char *cmd = "POST /sony/camera HTTP/1.1\r\nContent-Length: 63\r\n\r\n{\"method\":\"actTakePicture\",\"params\":[],\"id\":10,\"version\":\"1.0\"}";

void usage(int argc, char *argv[])
{
	printf("usage : %s host port\n", argv[0]);
	exit(1);
}

int main(int argc, char *argv[])
{
	int rv;
	int s;
	struct sockaddr_in addr;

	if (argc != 3) usage(argc, argv);
	
	s = socket(AF_INET, SOCK_STREAM, 0);

	memset(&addr, 0, sizeof(addr));
	addr.sin_family      = AF_INET;
	addr.sin_addr.s_addr = inet_addr(argv[1]);
	addr.sin_port        = htons(atoi(argv[2]));

	rv = connect(s, (struct sockaddr*)&addr, sizeof(addr));
	if (rv < 0) {
		perror("connect() failed...");
		return -2;
	}

	rv = send(s, cmd, strlen(cmd), 0);
	if (rv <= 0) {
		perror("send() failed...");
		close(s);
		return -3;
	}

	memset(buf, 0, sizeof(buf));
	rv = recv(s, buf, BUF_SIZE, 0);
	if (rv < 0) {
		perror("recv() failed...");
		close(s);
		return -4;
	}

	shutdown(s, 2);
	close(s);

	return 0;
}


