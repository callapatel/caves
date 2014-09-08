class Dungeon
  attr_accessor :player

  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms = []
  end

  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end

  def start(location)
    @player.location = location #why did we equal this out to location?
    show_current_description
  end

  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description #writes out the desc of the room
  end

  def find_room_in_dungeon(reference)
    @rooms.detect { |room| room.reference == reference} #explain..
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction] #where is connections method?
  end

  def go(direction)
    puts "Because of your reply you are going in this direction " + direction.to_s
    @player.location = find_room_in_direction(direction)
    #personal check to find issue: print @player.location
    show_current_description
  end

  def asks(direction)
    puts "how are you feeling?: (scared/ancy) "
    feelings = gots.chomp
      if feelings == scared
        self.go(east)
      else self.go(west)
      end
  end



  class Player
    attr_accessor :name, :location

    def initialize(name)
      @name = name
    end

  end

  class Room
    attr_accessor :reference, :name, :description, :connections

    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end

    def full_description
      @name + "\n\nYou are in " + @description
    end
  end


end


#creating main dungeon OBJECT
my_dungeon = Dungeon.new("")

#adding rooms to the dungeon, WHY do we make the reference name a symbol? Can I convert anything to speak to a symbol?
my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous/vegetarian cave", {:west => :smallcave, :north =>:smallcave, :east => :smallcave, :south => :smallcave})
my_dungeon.add_room(:smallcave, "Small Cave", "a small, small pool with clowns", {:east => :largecave, :west => :largecave, :south => :largecave, :north => :largecave})
my_dungeon.add_room(:teenycave, "Teeny Cave", "a teeny, tiny sf apt, claustrophobic much?", {:north => :hugecave, :south => :hugecave, :east => :hugecave, :west => :hugecave})
my_dungeon.add_room(:hugecave, "Huge Cave", "a huge, garbage can.. and that garbage character from sesame street may try to eat you", {:south => :teenycave, :east => :teenycave, :north => :teenycave, :west => :teenycave })
#start the dungeon by placing the player in the large cave
puts "dungeon of weird aka welcome to hairy potter (english accent here)"
my_dungeon.start(:largecave)

def continue(my_dungeon)
  letsgo = true
  while letsgo == true
    puts "would you like to continue? (yes/no) "
    input1 = gets.chomp
    if input1 == "no"
      letsgo = false
      abort("bye")
    end
    puts "where would you like to go? (east/west/south/north): "
    input = gets.chomp.to_sym
    my_dungeon.go(input)
    my_dungeon.asks(input)
  end
end

continue(my_dungeon)
