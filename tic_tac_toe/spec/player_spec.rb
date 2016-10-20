require "tic_tac_toe"

describe TicTacToe::Player do

	let(:board) do
		board = {[0, 0] => "x", [0, 1] => "x", [0, 2] => "x"}
	end

	let(:player1){player1 = double("player1", :name => "Player 1", :sign => "x")}

	let(:game_board_1_fake_players) do 		
		player2 = double("player2")
		game = TicTacToe.send(:new, player1, player2)
		game.instance_variable_set(:@board, board)
		game
	end

	describe "#to_s" do
		context "when he is winner" do
			it "called once" do
				#allow(game_board_1_fake_players).to receive(:winner?).and_return(player1)
				allow(game_board_1_fake_players).to receive(:print_board).and_return(nil)
				allow(game_board_1_fake_players).to receive(:get_move).and_return("2 2")
				#allow(player1).to receive(:sign).and_return("x")
				#player1.stub(:sign).with("x")
				expect(player1).to receive(:to_s).once
				game_board_1_fake_players.send(:operate)
			end
		end

	end

end