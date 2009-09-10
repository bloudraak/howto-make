Name         : htmmm-gSrc
Version      : %{version}
Release      : %{release}
Group        : Applications/System
Summary      : Generated Source Apps from the How To Make Make Make Demo
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
Generated-source apps from the How To Make Make Make (HTMMM) Demo.
HTMMM is a full-featured Makefile system.

%prep

%build
make -C %{_topdir}/../.. T=4 RELDIR=app/gSrc -j%{jobs}

%install
rm -rf $RPM_BUILD_ROOT
make -C %{_topdir}/../.. -f Install.mk PKG=%{name}

%files
%defattr(-,root,root)
%doc /usr/local/share/README_L
%doc /usr/local/share/README_LY
/usr/local/bin/calcLY
/usr/local/bin/count_words

%clean

%pre

%post

%preun

%postun

%changelog
