<p align="center">
  <a href="https://github.com/joey66666/quizapp">
    <img src="https://raw.githubusercontent.com/joey66666/ImgHost/main/img/20201130180240.png" width="96">
  </a>
  <h1 align="center">QuizAPP</h1>
  <p align="center">
    <a href="https://github.com/joey66666/quizapp/blob/master/README_en.md"><img src="https://img.shields.io/badge/doc-English-blue.svg?style=popout-square"></a>
    <a href="http://hits.dwyl.io/joey66666/quizapp" alt="hit count"><img src="http://hits.dwyl.io/joey66666/quizapp.svg" /></a> 
  </p>
  <p align="center">
    基于Swift5和UIKit的问卷小App，包括数据持久化，图像存储与显示，自定义画板等功能 <br>
  </p>
</p>

![light](https://raw.githubusercontent.com/joey66666/ImgHost/main/img/20201130180241.png)

![dark](https://raw.githubusercontent.com/joey66666/ImgHost/main/img/20201130180239.png)

# 视图
1. 单选
2. 数字填空
3. 编辑数字填空题及答案
4. 得分

## 1. 单选页面
## 2. 数字填空页面
## 3. 编辑页面
- “Edit”按钮可以删除或对问题进行重排序，“+”按钮会创建一个问题；
- 点击问题或“+”按钮会进入该问题详情视图。
  ### 详情视图
  - 输入或修改问题及答案。
  - 显示该问题的创建时间；
  - 输入或修改该问题的图片。
  ### 图片
  - 添加一个图片到当前问题，拍照或上传相册中的图片，非必须；
  - 如果已有图片并再次添加图片，前一张图片会被替换；
  - 删除按钮可以删除当前图片。
  ### 画板
  - 新建空画板，可画直线图；
  - 在直线上点击可以删除该线或改变该线的颜色；
  - 在直线上长按可以移动该线；
  - 空白处双击可以清空画板；
  - 长按空白处会弹出菜单，改变画笔颜色。
## 4. 得分页面
- 显示当前已答题数，错误/正确题目数；
- 根据正确/错误题目数量调整背景颜色。

除画板外其他视图已适配暗色模式。
