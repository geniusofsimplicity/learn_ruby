#Interface to the game.
class Dungeon
	attr_accessor :player

	#Create a new player
	def initialize player_name
		@player = Player.new(player_name)
		@rooms = []		
	end

	#Setup initial player's location
	def start location
		@player.location = location
		show_current_description		
	end

	#print player's location
	def show_current_description
		puts find_room_in_dungeon(@player.location).full_description
	end

	#find room in the dungeon
	def find_room_in_dungeon reference
		@rooms.detect{|room| room.reference == reference}	
	end

	#find the next adjucent room by providing direction
	def find_room_in_direction direction
		find_room_in_dungeon(@player.location).connections[direction]
	end

	#move player into adjucent room by providing direction
	def go direction
		puts "You go #{direction.to_s}"		
		@player.location = find_room_in_direction direction
		show_current_description
	end

	#Stores information about player's name and location
	class Player
		attr_accessor :name, :location

		#Create a new player
		def initialize name
			@name = name			
		end
	end

	#Stores information about a room
	class Room
		attr_accessor :reference, :name, :description, :connections

		#Create a new room by setting its reference, name, description and connections up
		def initialize reference, name, description, connections
			@reference = reference
			@name = name
			@description = description
			@connections = connections			
		end

		#print full description of the room
		def full_description
			@name + "\n\nYou are in #{@description}"			
		end
	end

	#add a new room to the dungeon
	def add_room reference, name, description, connections
		@rooms << (Room.new reference, name, description, connections)
	end
end

my_dungeon = Dungeon.new "Sam"
my_dungeon.add_room :largecave, "Large Cave", "a large cavernous cave", {west: :smallcave}
my_dungeon.add_room :smallcave, "Small Cave", "a small, claustrophobic cave", {east: :largecave}
my_dungeon.start(:largecave)
my_dungeon.go(:west)