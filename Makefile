# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bhibbeln <bhibbeln@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/10 11:49:40 by bhibbeln          #+#    #+#              #
#    Updated: 2025/11/22 11:17:17 by bhibbeln         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = client server
CC = cc
CFLAGS = -Wall -Wextra -Werror -I ./ft_printf.a
FT_PRINTF = ./ft_printf/ft_printf.a

SRC = client.c server.c
OBJS = $(SRC:.c=.o)

all: $(NAME)

MAKEFLAGS += -s

client: client.o
	@make -C ./ft_printf
	@$(CC) $(CFLAGS) client.o $(FT_PRINTF) -o client
	@echo "✅ Client compiled"

server: server.o
	@$(CC) $(CFLAGS) server.o $(FT_PRINTF) -o server
	@echo "✅ Server compiled"
clean:
	@make -C ./ft_printf clean
	@rm -rf $(OBJS)
	@echo "❌ Object files cleaned"
	
fclean: clean
	@make -C ./ft_printf fclean
	@rm -rf $(NAME)
	@echo "❌ Client and Server deleted"

re: fclean all
	@echo "🔄 Recompiled everything"

.PHONY: all clean fclean re