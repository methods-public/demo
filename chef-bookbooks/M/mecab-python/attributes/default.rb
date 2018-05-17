default["dl_site"] = {
  "mecab"  => "http://mecab.googlecode.com/files/",
}

default["mecab-python"] = {
  "version" => "0.996",
  "support" => {
    "0.996" => { "checksum" => "b7801d78b4def5118903f3d7b97968b106aa8ea8", "checksum_type" => :SHA1 },
    "0.994" => { "checksum" => "eb588874dc7d6c182df9ece0817791daca7070d0", "checksum_type" => :SHA1 }
  },
  "conf" => {
    "prefix" => nil 
  },
  "python_path" => nil
}
