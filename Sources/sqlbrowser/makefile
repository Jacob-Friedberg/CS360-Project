EXE=		parser
OBJS=		parser.o grammar.o
TEMP_SRC= 	lexical.c grammar.c
INCS=		parser.h

install : clean $(EXE) 

clean	:
	rm -f $(OBJS) $(EXE) $(TEMP_SRC)

grammar.o:	lexical.c

$(OBJS): $(INCS)

$(EXE): $(OBJS)
	gcc $(OBJS) -o $(EXE) 
