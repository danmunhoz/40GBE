SRC= 	user_guide			\
		team		\
		hardware/hardware	\
		software/script_c	\
		software/web		\

all:
	echo "WARNING: Deprecated documentation version. Please refer to the Github Wiki page for up-to-date documentation";
all: clean
all: html

html: $(addsuffix .t2t, $(SRC))
	txt2tags $^

clean:
	rm -f $(addsuffix .html, $(SRC))
