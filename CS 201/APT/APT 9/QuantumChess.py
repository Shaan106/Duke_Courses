
class Piece:

  def __init__(self, color, type, x, y):
    self.type = type
    self.color = color
    self.x = x
    self.y = y

  def myfunc(self):
    print("Hello my name is " + self.name)


wp1 = Piece('W', 'p1', 1, 2)
wp2 = Piece('W', 'p2', 2, 2)
wp3 = Piece('W', 'p3', 3, 2)
wp4 = Piece('W', 'p4', 4, 2)
wp5 = Piece('W', 'p5', 1, 2)
wp6 = Piece('W', 'p6', 6, 2)
wp7 = Piece('W', 'p7', 7, 2)
wp8 = Piece('W', 'p8', 8, 2)
wr1 = Piece('W', 'r1', 1, 1)
wr2 = Piece('W', 'r2', 8, 1)
wb1 = Piece('W', 'b1', 3, 1)
wb2 = Piece('W', 'b2', 6, 1)
wn1 = Piece('W', 'n1', 3, 3)
wn2 = Piece('W', 'n2', 7, 1)
wk = Piece('W', 'k', 5, 1)
wq = Piece('W', 'q', 6, 1)

bp1 = Piece('B', 'p1', 1, 7)
bp2 = Piece('B', 'p2', 2, 7)
bp3 = Piece('B', 'p3', 3, 7)
bp4 = Piece('B', 'p4', 4, 7)
bp5 = Piece('B', 'p5', 5, 7)
bp6 = Piece('B', 'p6', 6, 7)
bp7 = Piece('B', 'p7', 7, 7)
bp8 = Piece('B', 'p8', 8, 7)
br1 = Piece('B', 'r1', 1, 8)
br2 = Piece('B', 'r2', 8, 8)
bb1 = Piece('B', 'b1', 2, 8)
bb2 = Piece('B', 'b2', 7, 8)
bn1 = Piece('B', 'n1', 3, 8)
bn2 = Piece('B', 'n2', 6, 8)
bk = Piece('B', 'k', 4, 8)
bq = Piece('B', 'q', 5, 8)

grid = [[wr1, wn1, wb1, wq, wk, wb2, wn2, wr2],
        [wp1, wp2, wp3, wp4, wp5, wp6, wp7, wp8],
        [None, None, None, None, None, None, None, None],
        [None, None, None, None, None, None, None, None],
        [None, None, None, None, None, None, None, None],
        [None, None, None, None, None, None, None, None],
        [bp1, bp2, bp3, bp4, bp5, bp6, bp7, bp8],
        [br1, bn1, bb1, bq, bk, bb2, bn2, br2]]


def rook_move(x, y):

  moves = []

  for i in range(1, 9):
    if (x + i > 0 and x + i < 9):
      if grid[y - 1][x + i - 1] == None:
        moves.append([x + i, y])
      elif grid[y - 1][x + i - 1].color == 'B':
        moves.append([x + i, y])
        break
      else:
        break
  for i in range(1, 9):
    if (x - i > 0 and x - i < 9):
      if grid[y - 1][x - i - 1] == None:
        moves.append([x - i, y])
      elif grid[y - 1][x - i - 1].color == 'B':
        moves.append([x - i, y])
        break
      else:
        break
  for j in range(1, 9):
    if (y + j > 0 and y + j < 9):
      if grid[y + j - 1][x - 1] == None:
        moves.append([x, y + j])
      elif grid[y + j - 1][x - 1].color == 'B':
        print('hit')
        moves.append([x, y + j])
        break
      else:
        break
  for j in range(1, 9):
    if (y - j > 0 and y - j < 9):
      if grid[y - j - 1][x - 1] == None:
        moves.append([x, y - j])
      elif grid[y - j - 1][x - 1].color == 'B':
        moves.append([x, y - j])
        break
      else:
        break

  return (moves)


def knight_move(x,y):

    x = x - 1
    y = y - 1

    possible_moves = [  [1,2],[-1,2],
                        [2,1],[2,-1],
                        [1,-2],[-1,-2],
                        [-2,1],[-2,-1]]

    return_moves = []

    for move in possible_moves:
        newGridPos_X = move[0] + x
        newGridPos_Y = move[1] + y

        if newGridPos_X < 0 or newGridPos_X > 7 or newGridPos_Y < 0 or newGridPos_Y > 7:
            continue

        if grid[newGridPos_Y][newGridPos_X] == None or grid[newGridPos_Y][newGridPos_X].color == "B":
            return_moves.append([newGridPos_X + 1, newGridPos_Y + 1])

    return return_moves


print(knight_move(3,4))

# [5,3] [5,5] [4,6] [2,6] [1,3] [1,5]