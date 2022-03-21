# -*- coding: utf-8 -*-
import os


def get_file_name(file_dir,from_txt,to_txt):
    for root, dirs, files in os.walk(file_dir):  # 获取当前文件夹的信息
        for file in files:                       # 扫描所有文件
            if os.path.splitext(file)[1] == "."+from_txt:# 提取出所有后缀名为md的文件
                os.chdir(root)
                print("转换开始：" + "pandoc -s -V theme:Newsprint " + file + " -o " + os.path.splitext(file)[0] + "."+to_txt)
                # 使用os.system调用pandoc进行格式转化
                os.system("pandoc -s -V theme:Newsprint " + file + " -o " + os.path.splitext(file)[0] + "."+to_txt)
                print("转换完成...")


if __name__ == "__main__":

    filepath = "."
    from_txt="md"
    to_txt = "html"
    get_file_name(filepath,from_txt,to_txt)

