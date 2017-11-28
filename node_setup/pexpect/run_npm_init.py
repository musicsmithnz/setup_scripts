#!/bin/python

import pexpect

app_name='lucentmonkey.com'
version=''
description='Small Business Software and Architecture'
git_repository=''
keywords='Open Source, Softare, Architecture, Linux'
author='raymond'
license='GPL'

child = pexpect.spawn('npm init')
child.expect('name:.*')
child.sendline(app_name)
child.expect('version:.*')
child.sendline(version)
child.expect('description:.*')
child.sendline(description)
child.expect('git repository:.*')
child.send(git_repository)
child.expect('keywords:.*')
child.send(keywords)
child.expect('author:.*')
child.send(author)
child.expect('license:.*')
child.send(license)
child.expect('Is this ok?.*')
child.send('yes')
print child.before
child.interact()  
