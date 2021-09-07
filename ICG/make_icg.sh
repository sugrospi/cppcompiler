# yacc -d icg.y
# flex icg.l
# gcc y.tab.c lex.yy.c 
# ./a.out < Tests/t3.cpp
# clear
# cat Tests/t3.cpp
# echo quad file
# cat Outputs/quad.txt
# echo 3 Address code 
# cat Outputs/icg.txt
python3 Outputs/codeopt.py
