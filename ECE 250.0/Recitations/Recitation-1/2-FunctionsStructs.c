#include <stdio.h>
#include <stdlib.h>

struct HoopsPlayer {
    int playerNumber;
    float avg_ppg;


};

void sortList(struct HoopsPlayer *players, int length) {

    for (int i = 0; i < length - 1; i++) {
        for (int j = 0; j < length - 1; j++) {
            if (players[j].avg_ppg > players[j + 1].avg_ppg) {
                struct HoopsPlayer temp;
                temp = players[j];
                players[j] = players[j+1];
                players[j+1] = temp;
            }
        }
    }

}

int main() {

    struct HoopsPlayer players[10]; // declares an array of size 10 of type struct HoopsPlayer. player is pointer to array

    int index = 0;

    while (index < 10) {

        int player_num = 0;
        printf("Enter player number: ");
        scanf("%d", &player_num);

        if (player_num == -1) {
            break;
        }

        players[index].playerNumber = player_num;

        printf("Enter average points per game: ");
        scanf("%f", &players[index].avg_ppg);

        index++;

    };

    sortList(players, index);

    for (int i = 0;  i < index; i++) {
        printf("Player %d scored an average of %f points per game", players[i].playerNumber, players[i].avg_ppg);
    }
    

};
