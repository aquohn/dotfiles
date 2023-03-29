#!/bin/sh

# Copyright 2021 John Khoo <john_khoo@u.nus.edu>

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

if [ $# -ne 1 ] || [ `id -u` -ne 0 ]; then
    printf "Usage: sudo $0 <username>\n"
    exit 1
fi

test -f /etc/sudoers.d/login_hook || touch /etc/sudoers.d/login_hook
printf "$1 ALL=(root) NOPASSWD: /home/$1/.login_hook\n\n" >> /etc/sudoers.d/login_hook
chmod 0440 /etc/sudoers.d/login_hook

test -f ~/.login_hook || (touch ~/.login_hook && cat << END >> ~/.login_hook)
#!/bin/sh
# your instructions here

# register the hook as having run
test -d /var/run/login_hooks || mkdir /var/run/login_hooks
test -f /var/run/login_hooks/$1 || touch /var/run/login_hooks/$1

END

chmod u=rwx,g=r,o=r ~/.login_hook

test -f ~/.profile || (touch ~/.profile && printf "#!/bin/sh\n" >> ~/.profile)
cat << END >> ~/.profile
# run the login hook, if it has not yet been run (script runs as sudo)
test -f /var/run/login_hooks/$USER || (test -f "$HOME/.login_hook" && sudo ~/.login_hook $USER)

END

chown $1: ~/.profile

