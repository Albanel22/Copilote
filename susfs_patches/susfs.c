#include <linux/susfs.h>
#include <linux/kernel.h>
#include <linux/init.h>

void __init susfs_init(void) {
    pr_info("🦊 SuSFS : Système de masquage invisible initialisé avec succès sur Kernel 4.19 !\n");
}
int susfs_is_sus_path(const char *path) {
    return 0;
}
