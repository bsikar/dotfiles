#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdarg.h>
#include <time.h>
#include <X11/Xlib.h>

static Display *dpy;

char *smprintf(char *, ...);
void setstatus(char *);
float getram(void);
float getswap(void);
float getcpu(void);
char *dateandtime(void);

int main(void) {
    char *status;

    if (!(dpy = XOpenDisplay(NULL))) {
        fprintf(stderr, "dwmstatus: cannot open display.\n");
        return 1;
    }

    for (;;sleep(1)) {
        status = smprintf("ram: %.2f%% swap: %.2f%% cpu: %.2f%% %s", getram(), getswap(), getcpu(), dateandtime());
        setstatus(status);
        free(status);
    }

    XCloseDisplay(dpy);

    return 0;
}

char *smprintf(char *fmt, ...) {
    va_list fmtargs;
    char *ret;
    int len;

    va_start(fmtargs, fmt);
    len = vsnprintf(NULL, 0, fmt, fmtargs);
    va_end(fmtargs);

    ret = malloc(++len);
    if (ret == NULL) {
        perror("malloc");
        exit(1);
    }

    va_start(fmtargs, fmt);
    vsnprintf(ret, len, fmt, fmtargs);
    va_end(fmtargs);

    return ret;
}

void setstatus(char *str) {
    XStoreName(dpy, DefaultRootWindow(dpy), str);
    XSync(dpy, False);
}

float getram(void) {
    int total, free, buffer, cache;
    FILE *fd = fopen("/proc/meminfo", "r");

    if (fd == NULL) {
        perror("fopen");
        exit(1);
    }

    fscanf(fd, "%*s %d %*s %*s %d %*s %*s %*d %*s %*s %d %*s %*s %d", &total, &free, &buffer, &cache);
    fclose(fd);

    return (float)(total - free - buffer - cache) / total * 100.;
}

float getswap(void) {
    int total = -1, free = -1;
    char line[513];
    FILE *fd = fopen("/proc/meminfo", "r");

    if (fd == NULL) {
        perror("fopen");
        exit(1);
    }

    while (!feof(fd) && fgets(line, sizeof(line)-1, fd) != NULL && (total == -1 || free == -1)) {
        if (strstr(line, "SwapTotal")) {
            sscanf(line, "%*s %d", &total);
        }

        if (strstr(line, "SwapFree")) {
            sscanf(line, "%*s %d", &free);
        }
    }

    fclose(fd);

    return (float)(total-free) / total * 100.;
}

float getcpu(void) {
    long int user, nice, system, idle, iowait, irq, softirq, used, total;
    FILE *fd = fopen("/proc/stat", "r");

    if (fd == NULL) {
        perror("fopen");
        exit(1);
    }

    fscanf(fd, "%*s %ld %ld %ld %ld %ld %ld %ld", &user, &nice, &system, &idle, &iowait, &irq, &softirq);

    used = user + nice + system + irq + softirq;
    total = user + nice + system + idle + iowait + irq + softirq;

    fclose(fd);

    return 100. - ((float)(total-used) / total * 100.);
}

char *dateandtime(void) {
    const char weekdays[7][10] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
    const char months[12][10] = {"January", "February", "March", "April", "May", "June", "July", "Augest", "September", "October", "November", "December"};
    time_t t = time(NULL);
    struct tm tm = *localtime(&t);

    char *time;
    if (tm.tm_hour > 12) {
        if (tm.tm_min > 9) {
            time = smprintf("%d:%d PM", tm.tm_hour - 12, tm.tm_min);
        } else {
            time = smprintf("%d:0%d PM", tm.tm_hour - 12, tm.tm_min);
        }
    } else {
        if (tm.tm_min > 9) {
            time = smprintf("%d:%d AM", (tm.tm_hour == 0) ? 12 : tm.tm_hour,  tm.tm_min);
        } else {
            time = smprintf("%d:0%d AM", (tm.tm_hour == 0) ? 12 : tm.tm_hour,  tm.tm_min);
        }
    }

    free(time);

    return smprintf("%s, %s %d - %s ", weekdays[tm.tm_wday], months[tm.tm_mon], tm.tm_mday, time);
}
