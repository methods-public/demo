default["dl_site"] = {
  "mecab"  => "http://mecab.googlecode.com/files/",
}

default["mecab-ruby"] = {
  "version" => "0.996",
  "support" => {
    "0.996" => { "checksum" => "5730d9667118d79ad6f2c49f45476d0874718d10", "checksum_type" => :SHA1 },
    "0.994" => { "checksum" => "cb52217e4d6d7c598691b41174606c5339a5bd17", "checksum_type" => :SHA1 }
  }
}
