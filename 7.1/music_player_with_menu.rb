require './input_functions'

module Genre
    POP, CLASSIC, JAZZ, ROCK = *1..4
  end

  class Album
    attr_accessor :album_key, :title, :singer, :genre, :tracks
    def initialize (key, title, singer, genre, tracks)
      @album_key = key
      @title = title
      @singer = singer
      @genre = genre
      @tracks = tracks
     end
  end

  class Track
    attr_accessor :track_key, :name, :location
      def initialize (key, name, location)
        @track_key = key
        @name = name
        @location = location
       end
  end


  def read_album(music_file, i)
    album_key = i
    album_title = music_file.gets.chomp
  	album_singer = music_file.gets
  	album_genre = music_file.gets.to_i
  	album_tracks = read_tracks(music_file)
  	album = Album.new(album_key, album_title, album_singer, album_genre, album_tracks)
  	return album
  end


  def read_albums()
    music_file = nil
    file_name = read_string("Enter File Name")
              while (!File.exists?(file_name))
                 puts("file not found!! try again:(")
                 file_name = read_string("Enter File Name")
              end
              if (File.exists?(file_name))
                  music_file = File.new(file_name, "r")
                  puts("File has opened")
            else
              return nil
            end
    count = music_file.gets.to_i
    albums = Array.new()
    index = 0
      while index < count
        album = read_album(music_file, index+1)
        albums << album

        index += 1
      end
    return albums
  end



  def read_track (music_file, i)
    track_key = i
    track_name = music_file.gets()
    track_location = music_file.gets()
  	track = Track.new(track_key, track_name, track_location)
    return track
  end



  def read_tracks (music_file)
      count = music_file.gets.to_i()
      tracks = Array.new()
      index = 0
      while index < count
        track = read_track(music_file, index+1)
        tracks << track
        index += 1
      end
      tracks
  end



def print_tracks (tracks)
  index = 0
  while index < tracks.length
    print_track(tracks[index])
    index += 1
  end
end


def print_track (track)
  puts("track key is " + track.track_key.to_s)
  puts('track title is: ' + track.name)
  puts('track location is: ' + track.location)
end


def print_album (album)
    genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']
    puts("album key is " + album.album_key.to_s )
    puts("album title is " + album.title )
    puts("album singer is "+ album.singer)
    puts("album genre is " + genre_names[album.genre])
    print_tracks(album.tracks)
    puts("")
end


def print_albums (albums)
  if (albums)
    i = 0
    while i < albums.length
      print_album(albums[i])
      i += 1
    end
  end
end


def print_genre(genre, albums)
  if (albums)
    genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']
    i = 0
    while i < albums.length
      g = genre_names[albums[i].genre]
      if (genre.downcase == g.downcase)
        print_album(albums[i])
      end
      i+=1
    end
  end
end


# for Menu option 3 & 4
def print_album_key(album, press)
  if (album)
    i = 0
    while i < album.length
        puts(album[i].title + " key is " + album[i].album_key.to_s)
        i+=1
    end
    if (press == 3)
      search_album_key = read_integer_in_range("Enter album key you want to play", 1, 15)
      play_album(album, search_album_key)
    end
    if (press == 4)
      search_album_key = read_integer_in_range("Enter album key you want to update", 1, 15)
      update_album(album, search_album_key)
    end
  else
    puts("Please open the file first")
  end
end


def play_album(albums, search_album_key)
  i = 0
  while i < albums.length
    if (albums[i].album_key == search_album_key)
      print_tracks(albums[i].tracks)
      search_album_key = read_integer_in_range("Enter track key", 1, 15)
      play_tracks(albums[i], albums[i].tracks, search_album_key)
    end
    i+=1
  end
end


def play_tracks(albums, tracks, search_album_key)
  i = 0
  while i< tracks.length
    if (tracks[i].track_key == search_album_key)
      puts("Playing track: " + tracks[i].name + " from album " + albums.title + " by " + albums.singer)
    end
    i+=1
  end
end


def update_album(album, search_album_key)
  i = 0
  while i < album.length
    if (album[i].album_key == search_album_key)
      puts("Enter New Title: ")
      album[i].title = gets.chomp
      puts("Enter New singer: ")
      album[i].singer = gets()
      album[i].genre = read_integer_in_range("Enter New Genre key",1,4)
    end
    i+=1
  end
end


def menu()
    music_file = nil
    albums = nil

    begin
    puts("Main Menu:")
    puts("1.  Open new file")
    puts("2.  Display all informations of the albums")
    puts("3.  Play an Album")
    puts("4.  Update an Album")
    puts("5.  Exit")
      press = read_integer_in_range("Please enter your choice", 1, 5)
    case press
      when  1
              albums = read_albums()
              finished = false
      when 2
        if (albums != nil)
            puts("1. dispaly all albums")
            puts("2.  display album by genre")
            press = read_integer_in_range("Please enter your choice", 1, 2)
            case press
              when  1
                print_albums(albums)
              when  2
                press = read_string("Type genre:")
                print_genre(press, albums)
                finshed = false
            end
          end
      when 3
          print_album_key(albums, press)
      when 4
        print_album_key(albums, press)
        puts("File has been updated...")
      when 5
        finished  = true
        puts("Good Bye!")
    end
        puts("")
    end until finished
    return finished
end


def main()
    finshed = false
    begin
        finished = menu()
    end until finished
end

main()
