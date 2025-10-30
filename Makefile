SRC = client.c server.c
NAME = client server

OBJ = $(SRC:.c=.o)

all: $(NAME)

client: client.o
	cc -Wall -Werror -Wextra $< -o $@

server: server.o
	cc -Wall -Werror -Wextra $< -o $@

%.o: %.c
	cc -Wall -Werror -Wextra -c $< -o $@

clean:
	rm -rf $(OBJ)

fclean: clean
	rm -rf $(NAME)

re: fclean all

.PHONY: all clean fclean re