# vim: sw=4:ts=4:et


%define relabel_files() \
restorecon -R /usr/lib/rustdesk/rustdesk; \

%define selinux_policyver 40.29-2

Name:   rustdesk_selinux
Version:	1.0
Release:	1%{?dist}
Summary:	SELinux policy module for RustDesk: https://rustdesk.com/docs/en/client/linux/selinux/

Group:	System Environment/Base
License:	MIT
# This is an example. You will need to change it.
# For a complete guide on packaging your policy
# see https://fedoraproject.org/wiki/SELinux/IndependentPolicy
URL:		https://github.com/xlionjuan/rustdesk-rpm-repo
Source0:	rustdesk.pp
Source1:	rustdesk.if
Source2:	rustdesk_selinux.8


Requires: policycoreutils-python-utils, libselinux-utils, rustdesk
Requires(post): selinux-policy-base >= %{selinux_policyver}, policycoreutils-python-utils
Requires(postun): policycoreutils-python-utils
BuildArch: noarch

%description
This package installs and sets up the SELinux policy security module for RustDesk.

%install
install -d %{buildroot}%{_datadir}/selinux/packages
install -m 644 %{SOURCE0} %{buildroot}%{_datadir}/selinux/packages
install -d %{buildroot}%{_datadir}/selinux/devel/include/contrib
install -m 644 %{SOURCE1} %{buildroot}%{_datadir}/selinux/devel/include/contrib/
install -d %{buildroot}%{_mandir}/man8/
install -m 644 %{SOURCE2} %{buildroot}%{_mandir}/man8/rustdesk_selinux.8
install -d %{buildroot}/etc/selinux/targeted/contexts/users/


%post
semodule -n -i %{_datadir}/selinux/packages/rustdesk.pp

if /usr/sbin/selinuxenabled ; then
    /usr/sbin/load_policy
    %relabel_files
fi;
exit 0

%postun
if [ $1 -eq 0 ]; then

    semodule -n -r rustdesk
    if /usr/sbin/selinuxenabled ; then
       /usr/sbin/load_policy
       %relabel_files
    fi;
fi;
exit 0

%files
%attr(0600,root,root) %{_datadir}/selinux/packages/rustdesk.pp
%{_datadir}/selinux/devel/include/contrib/rustdesk.if
%{_mandir}/man8/rustdesk_selinux.8.*


%changelog
* Wed Nov 13 2024 XLion <xlion@xlion.tw> - 1.0
- Inital release

