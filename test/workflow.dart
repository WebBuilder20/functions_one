/*
name: Gh-Pages

on:
  push:
    branches: main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v1
      - run: flutter config --enable-web
      - uses: erickzanardo/flutter-gh-pages@v3
        with:
          workingDir: ./
 */