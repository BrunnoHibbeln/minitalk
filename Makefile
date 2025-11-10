# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bhibbeln <bhibbeln@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/10 11:49:40 by bhibbeln          #+#    #+#              #
#    Updated: 2025/11/10 12:40:12 by bhibbeln         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = client server
CC = cc
CFLAGS = -Wall -Wextra -Werror

SRC = client.c server.c
OBJS = $(SRC:.c=.o)

all: $(NAME)

MAKEFLAGS += -s

client: client.o
	@$(CC) $(CFLAGS) client.o -o client
	@echo "✅ Client compiled"

server: server.o
	@$(CC) $(CFLAGS) server.o -o server
	@echo "✅ Server compiled"
clean:
	@rm -rf $(OBJS)
	@echo "✅ .o files deleted"
	
fclean: clean
	@rm -rf $(NAME)
	@echo "✅ client and server deleted"

re: fclean all

.PHONY: all clean fclean re