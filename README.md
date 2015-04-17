# UCB Class Registrator

## About

This app is in two parts.

1. Ruby App
2. Chrome Extention

## Ruby App

This app follows the Twitter account for [@UCBClasses](https://twitter.com/UCBClassesNYC).

If @UCBClasses tweets about a particular class, the app opens the link to the class' show page in the browser. 

It then prints out the class title, the class times, and opens up the teacher's page on [UCBComedy.com](http://ucbcomedy.com/).

## Chrome Extention

This script double checks for whether a page in the browser is a show page for a Sketch 301 or Improv 101 class at UCB's New York Training Center.

If it is a Sketch 301/Improv 101 class, it then clicks "Register" on the first page, "Agree" on the policy page, fills in the form on the register page with the user's info, then clicks "Continue Registration".
