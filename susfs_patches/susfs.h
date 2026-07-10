#ifndef _LINUX_SUSFS_H
#define _LINUX_SUSFS_H

void __init susfs_init(void);
int susfs_is_sus_path(const char *path);

#endif
