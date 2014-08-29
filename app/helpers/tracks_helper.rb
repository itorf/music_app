module TracksHelper
  
  def ugly_lyrics(lyrics)
    lyrics_array = lyrics.split("\n")
    new_lyrics = []
    lyrics_array.each do |line|
      html = "&#9835"
      new_lyrics << html + line
    end
    
    new_lyrics.unshift("<pre>")
    new_lyrics << "</pre>"
    new_lyrics.join('').html_safe
  end
end
