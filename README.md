# rustdesk-rpm-repo

> [!IMPORTANT]  
> This is ***unofficial*** [RustDesk](https://github.com/rustdesk/rustdesk/) RPM repo, what I can say is *trust me bro*, it is your decision to trust me or not.

> [!IMPORTANT]  
> Same thing but [APT](https://github.com/xlionjuan/rustdesk-apt-repo-latest) is also available.

The `rustdesk*.sh` script is written by ChatGPT, it will fetch the release data from GitHub API and use [jq](https://github.com/jqlang/jq) to parse JSON data and find the asset URL.

## Architectures
This repo provides two architectures

* `amd64`  (x86_64)
* `arm64`  (aarch64)

## Update frequency

This is all in one repo, so it will update all every 3 AM UTC, because RustDesk's Nightly will build a little over 2 hours.

## Import RPM repo
### latest

```bash
curl -fsSl https://xlionjuan.github.io/rustdesk-rpm-repo/latest.repo | sudo tee /etc/yum.repos.d/xlion-rustdesk-rpm-repo.repo
```

### nightly

```bash
curl -fsSl https://xlionjuan.github.io/rustdesk-rpm-repo/nightly.repo | sudo tee /etc/yum.repos.d/xlion-rustdesk-rpm-repo.repo
```

If you wanna switch channel, edit `/etc/yum.repos.d/xlion-rustdesk-rpm-repo.repo`, edit the `baseurl`.

## Import/Verify GPG Key
The fingerprint is:

```
1521 F219 00DB 3201 95AF A358 2BE8 3361 1FF6 0389
```

Please ignore the name, I shared the same key with APT repo.

## Install/Upgrade RustDesk

```bash
sudo dnf install rustdesk
```
## Update to same version number of nightly

Because RustDesk didn't change its version number or add special identify when releasing nightly, so you could run

```bash
sudo dnf reinstall rustdesk
```

to upgrade manually, still better than download manually.

> [!CAUTION]
> Don't asking me to doing this.