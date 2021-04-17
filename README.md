<p align="center">
  <a href="https://github.com/joey66666/quizapp">
    <img src="https://raw.githubusercontent.com/joey66666/ImgHost/main/img/20201130180240.png" width="96">
  </a>
  <h1 align="center">QuizAPP</h1>
  <p align="center">
    <a href="https://github.com/joey66666/quizapp"><img src="https://img.shields.io/badge/language-swift-orange?style=flat-square"></a>
    <a href="https://github.com/joey66666/quizapp"><img src="https://img.shields.io/badge/platform-iOS%20%7C%20iPad%20OS-red?style=flat-square"></a>
    <a title="Hits" target="_blank" href="https://github.com/joey66666/quizapp"><img src="https://hits.b3log.org/joey66666/quizapp.svg"></a>
    <a href="https://github.com/joey66666/QuizAPP/blob/main/LICENSE"><img src="https://img.shields.io/github/license/joey66666/quizapp?style=flat-square&color=ff69b4"></a>
    <a href="https://github.com/joey66666/quizapp"><img src="https://img.shields.io/github/languages/code-size/joey66666/quizapp?style=flat-square&color=blueviolet"></a>
    
  </p>
  <p align="center">
    Swift5问卷App，包含数据持久化，图像存储与显示，自定义画板与绘图等功能，适配暗色模式 <br>
  </p>
</p>

**中文版 | [English](#QuizApp)**

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

**除画板外其他视图已适配暗色模式。**

---

# QuizApp

**[中文版](#视图) | English**

Quiz Application base on Swift5 & UIKit, providing implements including data persistence, image storage, and drawer canvas.

![light](https://raw.githubusercontent.com/joey66666/ImgHost/main/img/20201130180241.png)

![dark](https://raw.githubusercontent.com/joey66666/ImgHost/main/img/20201130180239.png)


# View
1. Multiple-choice Questions
2. Numerical fill-in-blank Questions
3. Edit
4. Score

## 1. Multiple-choice Questions
## 2. Numerical fill-in-blank Questions
## 3. Edit
- Having an "Edit" button on the left (which allows deleting and reordering of questions) and a "+" button on the right.
- Tapping on one of the questions or the "+" button would get to the detail view.
  ### Detail View
  - Enter the question text for a new question or edit the text of an existing question.
  - Enter the answer text for a new question or edit the text of an existing answer.
  - Display the date and time the question was created (can't edit).
  - Enter/edit an optional image associated with each question.
  ### Image
  - Optionally add images to questions. 
  - (For example, imagine a captcha-type question in which a picture of a street scene is displayed and the user is asked how many traffic lights are in the picture).
  - Camera button allows to take a picture if there is a camera available, otherwise pick from the photo library. - Take/ Choose a picture again would replace the former one. 
  - Tap on the trash button would delete the associate image.
  ### Draw
  - Draw line pictures (straight lines only).
  - Tap on a line to delete it or change the color of the line to one of 4 colors.
  - Move existing lines around using long press (on a line) and pan.
  - Double tapping anywhere on the canvas deletes all lines but asks to confirm this operation first.
  - A long press on a blank part of the canvas (not on an existing line) brings up a menu to change the "pen color" so any future lines are drawn in that color.
  - Black: Finished lines, Red: Drawing line, Green: Selected line.
## 4. Score
- Shows a message how many questions have gotten correct/incorrect. 
- Updated every time it is viewed.
- Whenever have more correct answers than incorrect answers, the background of this view is green. 
- Whenever have more incorrect than correct answers, the background is red. 
- When the number of incorrect and correct answers are the same, the background is clear. 


**Adapt to dark mode except the draw view.**
