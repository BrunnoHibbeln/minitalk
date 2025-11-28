# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bhibbeln <bhibbeln@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/10 11:49:40 by bhibbeln          #+#    #+#              #
#    Updated: 2025/11/28 17:57:30 by bhibbeln         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = client server
CC = cc
CFLAGS = -Wall -Wextra -Werror -I ./ft_printf.a
FT_PRINTF = ./ft_printf/ft_printf.a

SRC = client.c server.c
OBJS = $(SRC:.c=.o)
SRC_BONUS = client_bonus.c server_bonus.c
OBJS_BONUS = $(SRC_BONUS:.c=.o)

all: $(NAME)

MAKEFLAGS += -s

client: client.o
	@make -C ./ft_printf
	@$(CC) $(CFLAGS) client.o $(FT_PRINTF) -o client
	@echo "✅ Client compiled"

server: server.o
	@$(CC) $(CFLAGS) server.o $(FT_PRINTF) -o server
	@echo "✅ Server compiled"

bonus: client_bonus server_bonus

client_bonus: client_bonus.o
	@make -C ./ft_printf
	@$(CC) $(CFLAGS) client_bonus.o $(FT_PRINTF) -o client
	@touch client_bonus
	@echo "✅ Client bonus compiled"
	
server_bonus: server_bonus.o
	@make -C ./ft_printf
	@$(CC) $(CFLAGS) server_bonus.o $(FT_PRINTF) -o server
	@touch server_bonus
	@echo "✅ Server bonus compiled"

clean:
	@make -C ./ft_printf clean
	@rm -rf $(OBJS) $(OBJS_BONUS) server_bonus client_bonus
	@echo "❌ Object files deleted"
	
fclean: clean
	@make -C ./ft_printf fclean
	@rm -rf $(NAME)
	@echo "❌ Client and Server deleted"

re: fclean all
	@echo "🔄 Recompiled everything"

.PHONY: all clean fclean re