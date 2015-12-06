#include <stdlib.h>
#include <signal.h>
#include <ncurses.h>
#include <unistd.h>

#define DELAY 30000

static void finish(int sig);

int main(int argc, char *argv[]) {
  int x = 0; int y = 0;
  int max_x = 0; int max_y = y;
  int next_x = 0;
  int direction = 1;

  (void) signal(SIGINT, finish);      /* arrange interrupts to terminate */

  initscr();
  noecho();
  curs_set(FALSE);

  while(1) {
    clear();
    getmaxyx(stdscr, max_y, max_x);
    mvprintw(y,x,"@");
    refresh();
    usleep(DELAY);
    next_x = x + direction;
    if (next_x >= max_x || next_x < 0) {
      direction = -direction;
    } else {
      x += direction;
    }
  }
  endwin();
  return 0;
}


static void finish(int sig)
{
  endwin();

  /* do your non-curses wrapup here */

  exit(0);

}
