class TicTacToe

    def initialize(board = nil)  # set the starting state
        @board = board || Array.new(9, " ") # create board array with 9 " " empty strings
    end

    WIN_COMBINATIONS = [  # define a constant 
        [0,1,2],          # nested array of all possible win compinations on board using index numbers
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2],                 
    ]

    def display_board  # Define a method that prints the current board based on the @board instance variable
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "  # use interpolation so arbitrary arrangements are possible 
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input) # passes in user input as string
        user_input.to_i - 1 # covert unser input to integer and subtract 1 so it becomes an index value
    end
 
    def move(index, token = "X")  # takes in two arguments, index and token with defult equal to "X"
        @board[index] = token # access index on board (a postion or space) and make it an X or O instead of " " (empty)
    end

    def position_taken?(index)
        if @board[index] == "X" || @board[index] == "O" # position is taken if there is and X or O on a particular space on the board 
            true
        else @board[index] == " " # not taken if still empty 
            false
        end
    end

    def valid_move?(index)  
        #returns true/false based on if present on the game board, not filled with a token, and within correct indexes 0-8
        if @board && !position_taken?(index) && index.between?(0, 8)
            true
        else
            false
        end
    end

    def turn_count #counts occupied positions
        # method .count - counts the number of elements for which the block returns a true value
        @board.count { |token| token == "X" || token == "O" }
    end

    def current_player
        # method should use the #turn_count method to determine if it is "X"'s or "O"'s turn
        # expect X to be even turns, O to be odd because no remainder means that the number is evenly divisible by 2
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        puts "Please enter your move, a position between 1-9." # ask for input
        user_input = gets.chomp # get input 
        index = input_to_index(user_input) # translate input into index, set equal to index (local variable needs to be defined)
        if valid_move?(index) # if index is valid
            token = current_player # set token (local variable) to #current_player 
            move(index, token) # make the move for index with correct token 
            display_board # show the board
        else
            turn # else ask for input again
        end
    end

    def won?
        WIN_COMBINATIONS.each do |win_combo| # iterate through win combinations 
           # make three new variables for each index of win_combo
            win_index_1 = win_combo[0]
            win_index_2 = win_combo[1]
            win_index_3 = win_combo[2]
            # use above to create three more variables for each position on the board at those indexes
            position_1 = @board[win_index_1]
            position_2 = @board[win_index_2]
            position_3 = @board[win_index_3]
             # if all three of those index are all equal 
            if position_1 == "X" && position_2 == "X" && position_3== "X"
                return win_combo
            elsif position_1 == "O" && position_2 == "O" && position_3== "O"
                # return that combo 
                return win_combo
            else
            end
        end
        return false 
    end

    def full? # return true if every element in the board contains either an X or O
        # check over every space (index) on board to see if there is an X or O 
        @board.all? { |index| index == "X" || index == "O" }
    end

    def draw? 
        #returns true if the board is full and has not been won
        if !won? && full?
            return true
        else  #false if the board is won or neither won nor full
           false   
        end 
    end

    def over?  # returns true if the board has been won or is full, i.e. draw
        if won? || draw? || full?
           return true
        else
            false
        end
    end

    def winner # return the token, "X" or "O", that has won the game
        if won?
           return @board[won?[0]]
        end
    end

    def play
        # until the game is over
        until over? == true
        turn  # take turns
        end
            if won? # if the game was won
            puts "Congratulations #{winner}!" # congratulate the winner
            elsif draw? # else if the game was a draw
            puts "Cat's Game!" # tell the players it ended in a draw
            end
    end

end