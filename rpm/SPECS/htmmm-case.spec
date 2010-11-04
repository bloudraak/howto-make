Name         : htmmm-case
Version      : %{version}
Release      : %{release}
Group        : Applications/System
Summary      : Case Apps from the How To Make Make Make Demo
Vendor       : Direct Analytical
License      : GPL
ExclusiveArch: x86_64
Exclusiveos  : linux
BuildArch    : %{buildarch}

# Dirs
%define _topdir  %(pwd)
%define _tmppath %{_topdir}/tmp
Buildroot:       %{_topdir}/tmp/%{name}-buildroot 

%description
Case apps from the How To Make Make Make (HTMMM) Demo.
HTMMM is a full-featured Makefile system.

%prep

%build
make -C %{_topdir}/../.. T=4 RELDIR=app/case -j%{jobs}

%install
rm -rf $RPM_BUILD_ROOT
make -C %{_topdir}/../.. -f Install.mk PKG=%{name}

%files
%defattr(-,root,root)
/usr/local/bin/AB
/usr/local/bin/Abh
/usr/local/bin/CD
/usr/local/bin/CDAlt1
/usr/local/bin/CDAlt2
/usr/local/bin/EF
/usr/local/bin/HILoose
/usr/local/bin/HITight
/usr/local/bin/JKLoose
/usr/local/bin/JKTight
/usr/local/lib/libcaseEF.so.0.0

%clean

%pre

%post

%preun

%postun

%changelog
