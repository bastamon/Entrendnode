# -*- coding: UTF-8 -*-
import os
from PIL import Image


def file_name(file_dir):
    L = []
    for root, _, files in os.walk(file_dir):
        for file in files:
            if os.path.splitext(file)[1] == '.png':
                L.append(os.path.join(root, file))
    return L


def IsValidImage(img_path):
    """
    判断文件是否为有效（完整）的图片
    :param img_path:图片路径
    :return:True：有效 False：无效
    """
    bValid = True
    try:
        Image.open(img_path).verify()
    except:
        bValid = False
    return bValid


def transimg(img_path):
    """
    转换图片格式
    :param img_path:图片路径
    :return: True：成功 False：失败
    """
    if IsValidImage(img_path):
        try:
            str = img_path.rsplit(".", 1)
            output_img_path = str[0] + ".jpg"
            print(output_img_path)
            im = Image.open(img_path)
            im.save(output_img_path)
            return True
        except:
            return False
    else:
        return False


def main():
    # srcfile = file_name(os.getcwd())
    srcfile = file_name(os.path.dirname(os.path.abspath(__file__)))
    print(u'tochange')
    # dstfile = os.path.dirname(os.path.abspath(__file__)).split('\\')[-1] + u'.jpg'
    # assert not os.path.exists(dstfile), "file already existed"
    for _, img_path in enumerate(srcfile):
        # if os.path.exists(srcfile.split('\\')[-1] + u'.jpg') == True:
        #     break
        # else:
        transimg(img_path)  # 尾插
    print(u'all done')


if __name__ == '__main__':
    # img_path = 'wjk.png'
    main()
