<p align="center">
  <a href="https://github.com/joey66666/quizapp">
    <img src="https://raw.githubusercontent.com/joey66666/ImgHost/main/img/20201130180240.png" width="96">
  </a>
  <h1 align="center">QuizAPP</h1>
  <p align="center">
    <a href="https://github.com/joey66666/quizapp/blob/master/README.md"><img src="https://img.shields.io/badge/文档-中文版-blue.svg?style=popout-square"></a>
    <a href="https://github.com/joey66666/quizapp"><img src="https://img.shields.io/badge/language-swift-orange?style=flat-square"></a>
    <a href="https://github.com/joey66666/quizapp"><img src="https://img.shields.io/badge/platform-iOS%20%7C%20iPad%20OS-red?style=flat-square"></a>
    <a href="http://hits.dwyl.io/joey66666/quizapp" alt="hit count"><img src="http://hits.dwyl.io/joey66666/quizapp.svg" /></a> 
    <a href="https://github.com/joey66666/QuizAPP/blob/main/LICENSE"><img src="https://img.shields.io/github/license/joey66666/quizapp?style=flat-square&color=ff69b4"></a>
    <a href="https://github.com/joey66666/quizapp"><img src="https://img.shields.io/github/repo-size/joey66666/quizapp?style=flat-square&color=blueviolet"></a>
  </p>
  <p align="center">
    Quiz Application base on Swift5 &amp; UIKit, providing implements including data persistence, image storage, and drawer canvas. <br>
  </p>
</p>

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


Adapt to dark mode except the draw view.