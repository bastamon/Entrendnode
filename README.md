# Entrendnode
energy trend tested on node

## 环境：
1. 如果熟悉python的话,可在自己的python环境下安装openpyxl即可.
2. 不熟悉python的话先确保已安装Anaconda,然后在Anaconda Navigator界面操作导入py36.yml，环境命名为py36.
3. Matlab 2007+

## 文件说明
1. tomerge.py扫描工作目录生成合并后的工作表，工作表名当前目录名
2. data2plot.m转换*.xlsx数据到*.mat，最后生成fig.
3. py36.yml环境备份

## 运行
1. in bash

> source activate py36
> python tomerge.py

2. run 'data2plot.m'