lex proj.l
yacc -d proj.y
gcc y.tab.c lex.yy.c 
cat Tests/t6.cpp
./a.out<Tests/t6.cpp

