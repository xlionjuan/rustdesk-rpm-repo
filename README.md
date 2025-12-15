# rustdesk-rpm-repo

[![Create Repo for RustDesk latest and nightly](https://github.com/xlionjuan/rustdesk-rpm-repo/actions/workflows/create-repo.yml/badge.svg)](https://github.com/xlionjuan/rustdesk-rpm-repo/actions/workflows/create-repo.yml)

[Click me if you're using SUSE](#rustdesk-rpm-suse-repo)

> [!IMPORTANT]  
> This is ***unofficial*** [RustDesk](https://github.com/rustdesk/rustdesk/) RPM repo, what I can say is *trust me bro*, it is your decision to trust me or not.

> [!NOTE]  
> Same thing but [APT](https://github.com/xlionjuan/rustdesk-apt-repo-latest) is also available.

> [!NOTE]  
> Cloudflare R2 source is deprecated, but it will still available for some time.

This repo will use  [xlionjuan/fedora-createrepo-image](https://github.com/xlionjuan/fedora-createrepo-image) and some [simple scripts](https://github.com/xlionjuan/rustdesk-rpm-repo/tree/main/createrepo) to create repo, and deploy to GitHub Pages and Cloudflare R2.

The `rustdesk*.sh` script is written by ChatGPT, it will fetch the release data from GitHub API and use [jq](https://github.com/jqlang/jq) to parse JSON data and find the asset URL.

## Architectures

This repo provides two architectures

* `amd64`  (x86_64)
* `arm64`  (aarch64)

## Update frequency

This is all in one repo, so it will update all every 3 AM UTC, because RustDesk's Nightly will build a little over 2 hours.

## Import RPM repo

> [!NOTE]  
> You could use those command for your `rpm-ostree`, RPM based `bootc` ([Fedora Atomic](https://fedoraproject.org/atomic-desktops/)) based systems. Or use the commend to add the repo to your custom system images like [ublue-os/image-template](https://github.com/ublue-os/image-template). Please remember to remove `sudo` if you are using [ublue-os/image-template](https://github.com/ublue-os/image-template), and use `dnf` to install package.

### latest

```bash
curl -fsSL https://xlionjuan.github.io/rustdesk-rpm-repo/latest.repo | sudo tee /etc/yum.repos.d/xlion-rustdesk-rpm-repo.repo
```

### nightly

```bash
curl -fsSL https://xlionjuan.github.io/rustdesk-rpm-repo/nightly.repo | sudo tee /etc/yum.repos.d/xlion-rustdesk-rpm-repo.repo
```

If you wanna switch channel, edit `/etc/yum.repos.d/xlion-rustdesk-rpm-repo.repo`, edit the `baseurl`.

<details>
<summary>GitLab Pages...</summary>
<br>

Because of terrible Fastly CDN, you may want another choices, import the GitHub Pages' repo first, than run this command.

```bash
sed -i 's/github/gitlab/g' /etc/yum.repos.d/xlion-rustdesk-rpm-repo.repo
```
</details>

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
Or `rpm-ostree install rustdesk` if you're using [Fedora Atomic](https://fedoraproject.org/atomic-desktops/) based systems.

### Versioning

I use [fpm](https://github.com/jordansissel/fpm) to modify the nightly version with current date, so you'll never need to run `reinstall` in order to upgrade nightly.

# rustdesk-rpm-suse-repo

## Architectures
This repo provides two architectures

* `amd64`  (x86_64)
* `arm64`  (aarch64)

## Import RPM repo

### latest

```bash
curl -fsSL https://xlionjuan.github.io/rustdesk-rpm-repo/latest-suse.repo | sudo tee /etc/zypp/repos.d/xlion-rustdesk-rpm-suse-repo.repo
```

### nightly

```bash
curl -fsSL https://xlionjuan.github.io/rustdesk-rpm-repo/nightly-suse.repo | sudo tee /etc/zypp/repos.d/xlion-rustdesk-rpm-suse-repo.repo
```

<details>
<summary>GitLab Pages...</summary>
<br>
Because of terrible Fastly CDN, you may want another choices, import the GitHub Pages' repo first, than run this command.

```bash
sed -i 's/github/gitlab/g' /etc/zypp/repos.d/xlion-rustdesk-rpm-suse-repo.repo
```
</details>

## Install/Upgrade RustDesk

```bash
sudo zypper in rustdesk
```

### Versioning

I use [fpm](https://github.com/jordansissel/fpm) to modify the nightly version with current date, so you'll never need to run `reinstall` in order to upgrade nightly.

## Mirror

This repo and Pages are mirrored to [GitLab](https://gitlab.com/xlionjuan/rustdesk-rpm-repo).

## License

This repository is intended for distributing software. Unless otherwise specified, all scripts and configurations are licensed under the [GNU AGPLv3](LICENSE). **THIS DOES NOT INCLUDE THE DISTRIBUTED SOFTWARE ITSELF**. For the licenses of the distributed software, please refer to the software developers' websites, Git repositories, the packages' metadata, or contact the developers directly if you have any questions.
