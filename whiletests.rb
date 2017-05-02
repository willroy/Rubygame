#______________________________________________________


menu = MenuWindow.new
playertypes = ["Archer", "Mage", "Warrior", "Assassin"]

while true
    puts "Menu/Game/Editor(M/G/E): "
    which = gets.chomp
    while true
        if which == "M" 
            menu.show #show
            closee = menu.closee
            player_type = menu.player_type
            if closee == true
                game = GameWindow.new(player_type)
                game.show #show if true
                break
            elsif closee == nil
                puts "Plgease type a player type: "
                player = gets.chomp()
                count = 0
                editor = EditorWindow.new(player, closee)
                playertypes.each do |x|
                    if player == x
                        if editor.show #show if false
                            puts "hello"
                        end
                        if closee == true
                            menu.show
                            print player_type
                            game = GameWindow.new(player_type)
                            game.show
                            break
                        end
                    elsif count == 4
                        print "Choose Player Type: "
                    else
                        count += 1
                    end
                    break
                end
                break
            end
        elsif which == "G"
            while true
                puts "Please type a player type: "
                player = gets.chomp()
                count = 0
                game = GameWindow.new(player)
                playertypes.each do |x|
                    if player == x
                        game.show
                    elsif count == 4
                        print "Choose Player Type: "
                    else
                        count += 1
                    end
                end
                break
            end
        elsif which == "E"
            while true
                puts "Please type a player type: "
                player = gets.chomp()
                count = 0
                editor = EditorWindow.new(player, closee)
                playertypes.each do |x|
                    if player == x
                        editor.show
                    elsif count == 4
                        print "Choose Player Type: "
                    else
                        count += 1
                    end
                end
                break
            end
        else
            break
        end
        break
    end
end
print("\n\n")

#______________________________________________________

def MenuStart()
    menu = MenuWindow.new
    menu.show
    return menu.closee
end
def GameStart(player_type)
    game = GameWindow.new(player_type)
    game.show
end
def EditorStart(player_type, closee)
    editor = EditorWindow.new(player_type, closee)
    editor.show
end

while true
    player_type, closee = MenuStart()
    if closee == false
        exit
    else 
        if closee == true
            GameStart(player_type)
        elsif closee == nil
            EditorStart(player_type, closee) if closee == nil 
        end
    end
end 
print("\n\n")

#______________________________________________________

while true
    menu = MenuWindow.new
    player_type, closee = menu.player_type, menu.closee
    game = GameWindow.new(player_type)
    editor = EditorWindow.new(player_type, closee)
    game.show()
    break
    if closee == nil
        EditorStart(player_type, closee)
        if closee == true
            player_type, closee = menu.player_type, menu.closee
            game.show(player_type)
            break
        end
        break
    end
end
print("\n\n")

#______________________________________________________