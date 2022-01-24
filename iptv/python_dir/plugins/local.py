#!/usr/bin/env python
# -*- coding: utf-8 -*-

import tools
import time
import re

class Source (object) :

    def __init__ (self):
        self.T = tools.Tools()
        self.now = int(time.time() * 1000)

    def getSource (self) :
        urlList = []

        sourcePath = './m3u8_txt/tv.txt'
        with open(sourcePath, 'r') as f:
            lines = f.readlines()
            total = len(lines)
            for i in range(0, total):
                line = lines[i].strip('\n')
                item = line.split(',', 1)

                info = self.T.fmtTitle(item[0])

                netstat = self.T.chkPlayable(item[1])

                print('Checking[ %s / %s ]: %s,netstat:%s' % (i, total, str(info['id']) + str(info['title']),netstat))

                if netstat > 0 :
                    cros = 1 if self.T.chkCros(item[1]) else 0
                    data = {
                        'title'  : str(info['id']) if info['id'] != '' else str(info['title']),
                        'url'    : str(item[1]),
                        'quality': str(info['quality']),
                        'delay'  : netstat,
                        'level'  : info['level'],
                        'cros'   : cros,
                        'online' : 1,
                        'udTime' : self.now,
                    }
                    urlList.append(data)
                else :
                    pass # MAYBE later :P


        return urlList
