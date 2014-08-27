namespace :steam do
  desc "get game schemes"
  games_with_achievements = { 1 => 220, 2 => 240, 3 => 300, 4 => 380, 5 => 400, 6 => 420, 7 => 500, 8 => 530 }.freeze
  task get_schemes: :environment do
    games_with_achievements.each do |g|
      game = Game.find_by(:appid => g)
      get_scheme(game)
      sleep(1)
    end
  end
  task get_friends: :environment do
    Player.all.each do |f|
      if f.friends.blank?
        f.get_friends
      end
    end
  end
  task update_counters: :environment do
    Player.all.each do |f|
      f.playedgames_count = f.playedgames.count
    end
  end
  task update_time_played: :environment do
    Player.all.each do |f|
      f.update_time_played
    end
  end
end


def get_scheme(game)
    scheme = Steam.game_scheme(game.appid)

    if scheme && scheme.achievements
      puts "Achievements for: " << game.name
      scheme.achievements.each do |a|
        if Achievement.find_by(:name => a.name).blank?
          game.achievements.create(
            name: a.name, 
            defaultvalue: a.value, 
            displayname: a.display_name, 
            hidden: a.hidden, 
            description: a.description, 
            icon: a.icon, 
            icongray: a.icongray)
          end
      end
    end
    if scheme && scheme.stats
      puts "Stats for: " << game.name
      puts scheme.stats.count
      scheme.stats.each do |stat|
        if Stat.find_by(:name => stat.name).blank?
          game.stats.create(
            name: stat.name,
            value: stat.value,
            displayname: stat.display_name
            )
        end
      end
    end
  end