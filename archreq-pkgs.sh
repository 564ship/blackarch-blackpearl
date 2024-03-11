#!/bin/bash
cat ./archiso-mktemplate/profile/base/packages-esd.x86_64 > ./bootstrap-package.x86_64.temp ;
cat ./archiso-mktemplate/profile/dev-lang/packages-python.x86_64 >> ./bootstrap-package.x86_64.temp ;
cat ./archiso-mktemplate/profile/releng/packages-archiso-mk.x86_64 >> ./bootstrap-package.x86_64.temp ;
cat ./archiso-mktemplate/profile/net/packages-nl.x86_64 >> ./bootstrap-package.x86_64 >> ./bootstrap-package.x86_64.temp ;
cat ./archiso-mktemplate/profile/gnu/packages-pgp.x86_64 >> ./bootstrap-package.x86_64.temp ;

# Sort
cat ./bootstrap-package.x86_64.temp |sort |uniq |sed '/^#/d' |sed '/^$/d' > ./bootstrap-package.x86_64 ;
rm -f ./bootstrap-package.x86_64.temp ;

# Install
pacman -Syyu --noconfirm --overwrite="*" $(cat ./bootstrap-package.x86_64) ;
rm -f ./bootstrap-package.x86_64 ;
