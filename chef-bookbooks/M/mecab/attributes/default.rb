default["dl_site"] = {
  "unidic"    => "http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Funidic%2F58338%2F",
  "naistjdic" => "http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fnaist-jdic%2F53500%2F"
}

default["mecab"] = {
  "version"   => "0.996", # or HEAD
  "git_repos" => "https://github.com/taku910/mecab.git",
  "prefix"    => "/usr/local",
  "charset"   => "utf8",
  "utf8-only" => true,
  "clone_timeout" => 1200,
  "ver2rev" => {
    "0.996" => "64f8c11f4389d359aa3f0074d635e582dd69b6a9",
    "0.995" => "fc62c8b70bcf46a367c10c8ed18ee0ba5ffd2066",
    "0.994" => "ad914cb3a67fb0c976bac047a00b560d5a4ab714",
    "0.993" => "9fc3d729b709a1a1843304683e46c951bb968597",
    "0.991" => "368392d761b3f1ce6e7cedd249c0db45b4d15ef8",
    "0.99"  => "d7ea460e8772245dcae3f46e6a1f8ed2d4f3a619"
  },
}

default["ipadic"] = {
  "version" => "2.7.0-20070801",
  "ver2rev" => {
    "2.7.0-20070801" => "2fd29256c6d5e1b10211cac838069ee9ede8c77a",
    "2.7.0-20070610" => "92ebc166ffb4cb472c3eb8469bdd004b2dbe87be",
    "2.7.0-20060707" => "f3d32f5f66a46e29f1a7dcbd25163ec9d794edd8",
    "2.7.0-20051110" => "e79030fdee058165935558a2d10d598539360089"
  }
}

default["jumandic"] = {
  "version" => "7.0-20130310",
  "ver2rev" => {
    "7.0-20130310" => "415f47d6119c4387a83e9f942e4ea2d47acf5bdc",
    "5.1-20070304" => "5a7db65493a0b57d5fc31734e65300320aaf94c8"
  }
}

default["unidic"] = {
  "version" => "2.1.2",
  "support" => {
    "2.1.2" => { "checksum" => "547ce5824429a022d6fe368af39a106c", "checksum_type" => :MD5 },
    "2.1.1" => { "checksum" => "9609881ee9c0a1d2bbc59447077863bc", "checksum_type" => :MD5 }
  }
}

default["naistjdic"] = {
  "version" => "0.6.3b-20111013",
  "support" => {
    "0.6.3b-20111013" => { "checksum" => "52238fb14d949e49a65a9dbc1f7e382c", "checksum_type" => :MD5 },
    "0.6.3-20100801"  => { "checksum" => "30af2251331b9d6141748caf033821e3", "checksum_type" => :MD5 },
    "0.6.2-20100208"  => { "checksum" => "01d806a4682da610a051480d87a2c7c2", "checksum_type" => :MD5 },
    "0.6.1-20090630"  => { "checksum" => "1a0ea25002dcf1e4b925a88e10e7d3eb", "checksum_type" => :MD5 },
    "0.6.0-20090616"  => { "checksum" => "1babf0f548b038af9d2206e6a1615a83", "checksum_type" => :MD5 },
    "0.5.0-20090512"  => { "checksum" => "90398f6be899178afea669928d5c5b70", "checksum_type" => :MD5 }
  }
}

default["mecab-python"] = {
  "version" => "0.996",
  "prefix" => nil,
  "python_dev_include_path" => nil,  # /path/to/Python.h
  "python_dev_lib_path" => nil# /path/to/libpythonXX.so
}

default["mecab-java"] = {
  "version" => "0.996",
  "install_to" => "/usr/local/bin/mecab-java/"
}

default["mecab-perl"] = {
  "version" => "0.996",
  "perl_path" => nil
}

default["mecab-ruby"] = {
  "version" => "0.996",
}
