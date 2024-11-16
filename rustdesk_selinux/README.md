# rustdesk_selinux

<h2 align="center">Do not use this if you're using laptop, because it will cause <code>setroubleshootd</code> continuously runs.</h2>

<h3 align="center">But I have no ability to fix this. Though it works well.</h3>

SELinux config package for RustDesk, refer from: <https://rustdesk.com/docs/en/client/linux/selinux/#enable-through-rpm-installation>

* Package name: `rustdesk_selinux`
* Provided in: ALL

You could just install `rustdesk_selinux` if you haven't installed RustDesk, because RustDesk has added to `Requires:`.

## Uninstall

1. Remove `rustdesk_selinux`
2. Run `sudo semodule -r rustdesk` to ensure it completely removed
