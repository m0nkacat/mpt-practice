import random

def monetka():
    a = random.randint(0, 1)
    if a == 0:
        return "X"
    else: 
        return "O"

def bot(size, board):
    while True:
        a = random.randint(1, size)
        b = random.randint(1, size)
        if board[a-1][b-1] == '.':
            return a, b

def save(txt):
    with open("save_file", "a") as file:
        file.write(txt + "\n")
    

def game(size, player_first_move, bot_mode=False):
    board = []
    for i in range(size):
        row = []
        for j in range(size):
            row.append('.')
        board.append(row)
    
    player = player_first_move
    
    for turn in range(size * size):
        print("\nCurrent board:")
        for i in range(size):
            line = ""
            for j in range(size):
                line += board[i][j] + " "
            print(line)
        
        if bot_mode and player == 'O':
            r, c = bot(size, board)
            print(f"Bot plays: {r} {c}")
        else:
            while True:
                print(player + "'s turn")
                move = input("Enter row and column (e.g. 1 2): ")
                parts = move.split()
                
                if len(parts) != 2:
                    print("Please enter exactly two numbers separated by space")
                    continue
                
                if not parts[0].isdigit() or not parts[1].isdigit():
                    print("Please enter valid numbers")
                    continue
                
                r = int(parts[0])
                c = int(parts[1])
                
                if r < 1 or r > size or c < 1 or c > size:
                    print(f"Coordinates must be between 1 and {size}")
                    continue
                
                if board[r-1][c-1] != '.':
                    print("Cell is occupied! Try again.")
                    continue
                
                break
        
        board[r-1][c-1] = player
        
        win = False
        
        for i in range(size):
            if all(board[i][j] == player for j in range(size)):
                win = True
                break
        
        for j in range(size):
            if all(board[i][j] == player for i in range(size)):
                win = True
                break
        
        if all(board[i][i] == player for i in range(size)):
            win = True
        
        if all(board[i][size-1-i] == player for i in range(size)):
            win = True
        
        if win:
            print("\nFinal board:")
            for i in range(size):
                line = ""
                for j in range(size):
                    line += board[i][j] + " "
                print(line)
            print(player + " wins!")
            save(f"player {player} win!")
            return
        
        player = 'O' if player == 'X' else 'X'
    
    print("\nFinal board:")
    for i in range(size):
        line = ""
        for j in range(size):
            line += board[i][j] + " "
        print(line)
    print("It's a tie!")
    save("Tie!")

def main():
    while True:
        print("\n=== TIC-TAC-TOE GAME ===")
        print("Start game?")
        print("(yes/no)")
        a = input().lower().strip()
        
        if a == "yes":
            print("Play with bot? (yes/no)")
            bot_choice = input().lower().strip()
            bot_mode = bot_choice == "yes"
            
            while True:
                size_input = input("Enter the size of the board (3-9): ")
                
                if not size_input.isdigit():
                    print("Please enter a valid number")
                    continue
                
                size = int(size_input)
                
                if size >= 3 and size <= 9:
                    first_player = monetka()
                    print(f"\nFirst player is: {first_player}")
                    game(size, first_player, bot_mode)
                    break
                else:
                    print("Size must be between 3 and 9")
                    
        elif a == "no":
            print("Goodbye!")
            break
        else:
            print("Please enter 'yes' or 'no'")

if __name__ == "__main__":
    main()