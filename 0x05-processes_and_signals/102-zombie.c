#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

/**
  * create_zombie - Creates a zombie processes
  * Return: The PID of the child process (the zombie) in the parent
  * process
  */

int create_zombie(void)
{
	int pid = fork();

	if (pid == 0)
	{
		exit(0);
	}
	else if (pid > 0)
	{
		printf("Zombie process created, PID: %d\n", pid);
	}
	return (pid);
}

/**
  * infinite_while - Runs an infinite loop with a one-second
  * pause in each iteration, keeping the parent process alive
  * so that the zombie processes remain visible.
  * Return: Always 0
  */

int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}
	return (0);
}

/**
 * main - Entry point of the program
 * Return: Always returns 0.
 */

int main(void)
{
	int i = 0;

	for (i = 0; i < 5; i++)
	{
		create_zombie();
	}
	infinite_while();
	return (0);
}
