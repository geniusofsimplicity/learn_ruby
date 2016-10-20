require "tic_tac_toe"

describe TicTacToe do

	let(:player1){ TicTacToe::Player.new("Player 1", "x") }
	let(:player2){ TicTacToe::Player.new("Player 2", "o") }
	
	let(:game_current_player_1) do		 
		game = TicTacToe.send(:new, player1, player2)
		game.instance_variable_set(:@current_player, player1)
		game
	end

	let(:game_current_player_2) do		 
		game = TicTacToe.send(:new, player1, player2)
		game.instance_variable_set(:@current_player, player2)
		game
	end

	let(:board) do
		board = {[0, 0] => "x", [0, 1] => "x", [0, 2] => "x"}
	end

	let(:game_with_board_1) do 
		game_current_player_1.instance_variable_set(:@board, board)
		game_current_player_1
	end

	let(:game_with_board_2) do 
		game_current_player_2.instance_variable_set(:@board, board)
		game_current_player_2
	end

	describe "#winner?" do
		context "having player 1 win" do
			it "with 3 crosses in the 1st row" do
				expect(game_with_board_1.send(:winner?)).to eql(player1)
			end
		end

		context "having player 1 undefinded as winner" do
			it "with 3 noughts in the 1st row" do
				expect(game_with_board_2.send(:winner?)).not_to eql(player1)
			end
		end
	end

	describe "#operate" do
		context "when running the method" do
			it do
				allow(game_with_board_1).to receive(:winner?).and_return(false)
				allow(game_with_board_1).to receive(:print_board).and_return(nil)
				expect(game_with_board_1).to receive(:get_move).at_most(9).times
				game_with_board_1.send(:operate)
			end

			it do
				allow(game_with_board_1).to receive(:winner?).and_return(player1)
				allow(game_with_board_1).to receive(:print_board).and_return(nil)
				expect(game_with_board_1).to receive(:get_move).once
				game_with_board_1.send(:operate)
			end
		end

	end
end

