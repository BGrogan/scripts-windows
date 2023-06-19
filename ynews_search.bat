@echo off
set INPUT_STRING=%*
echo Searching hacker news for "%INPUT_STRING%"

start chrome "https://www.google.com/search?q=site:news.ycombinator.com+"""%INPUT_STRING%""""