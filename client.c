/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bhibbeln <bhibbeln@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/10/30 12:06:02 by bhibbeln          #+#    #+#             */
/*   Updated: 2025/11/22 11:35:04 by bhibbeln         ###   ########.fr       */
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

static void	sig_confirm(int sig)
{
	static int	count = 0;

	if (sig == SIGUSR2)
		count++;
	else if (sig == SIGUSR1)
		ft_printf("%d Characters acknowledged!\n", count);
}

static void	send_char(pid_t server_pid, char c)
{
	int	i;

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
		signal(SIGUSR1, sig_confirm);
		send_char(server_pid, str[i]);
		i++;
	}
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
		ft_printf("try: ./client <Server PID> <Message>\n");
		return (1);
	}
	return (0);
}
