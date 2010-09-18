#!/bin/bash
cd `dirname $0`
pandoc README.md -o build/body.tex

cd build

rm output.*

cat header.tex > output.tex
cat body.tex >> output.tex
cat footer.tex >> output.tex

latex2pdf output.tex > output.pdf

cp output.pdf ../README.pdf
