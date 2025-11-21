/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bhibbeln <bhibbeln@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/10/30 12:06:02 by bhibbeln          #+#    #+#             */
/*   Updated: 2025/11/21 13:53:53 by bhibbeln         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

static int	ft_atoi(const char *nptr)
{
	int	is_odd;
	int	num;

	num = 0;
	is_odd = 0;
	while ((*nptr == 32) || ((*nptr > 8) && (*nptr < 14)))
		nptr++;
	if ((*nptr == 43) || (*nptr == 45))
	{
		if (*nptr == 45)
			is_odd++;
		nptr++;
	}
	while (*nptr > 47 && *nptr < 58)
	{
		num *= 10;
		num += *nptr - 48;
		nptr++;
	}
	if ((is_odd % 2) != 0)
		return (-(num));
	return (num);
}

static void	sig_confirm(int sig) //Define a static function that takes in an integer representing a signal, and acknowledges reciept upon receiving it
{
	if (sig == SIGUSR2)
		write(1, "Message received\n", 18);/* 
	else //If SIGUSR2
		write(1, "Message received\n", 18);  */
}

static void	send_char(pid_t server_pid, char c)
{
	int				i;
	struct timespec	ts;

	ts.tv_sec = 0;
	ts.tv_nsec = 400 * 1000;
	i = 8;
	while (i--)
	{
		if ((c >> i) & 1)
			kill(server_pid, SIGUSR2);
		else
			kill(server_pid, SIGUSR1);
		usleep(400);
	}
}

static void	send_str(pid_t server_pid, char *str)
{
	int	i;

	i = 0;
	while (str[i])
	{
		signal(SIGUSR2, sig_confirm);
		send_char(server_pid, str[i]);
		i++;
	}
	send_char(server_pid, '\n');
	send_char(server_pid, '\0');
}

int	main(int ac, char **av)
{
	pid_t	server_pid;
	char	*str;
	if (ac == 3)
	{
		str = av[2];
		server_pid = ft_atoi(av[1]);
		send_str(server_pid, str);
	}
	else
	{
		write(2, "try: ./client <Server PID> <Message>\n", 38);
		return (1);
	}
	return (0);
}
