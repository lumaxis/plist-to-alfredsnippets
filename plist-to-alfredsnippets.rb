require "plist"
require "optparse"
require "open-uri"
require "securerandom"
require "json"
require "fileutils"
require "zip"

def create_snippets(plist)
  snippets = []
  plist.each do |dict|
    snippet = {
      "alfredsnippet" => {
        "snippet" => dict["phrase"],
        "uid" => SecureRandom.uuid,
        "name" => dict["shortcut"].delete(":"),
        "keyword" => dict["shortcut"]
      }
    }
    snippets << snippet
  end
  snippets
end

def zip_directory(directory_name)
  zipped_filename = directory_name + ".zip"
  file_names = []
  Dir.chdir(directory_name) do 
    file_names = Dir.glob("*.json")
  end

  Zip::File.open(zipped_filename, Zip::File::CREATE) do |zipfile|
    file_names.each do |filename|
      zipfile.add(filename, directory_name + "/" + filename)
    end
  end
end

def write_snippets(snippets)
  directory_name = "slack_emoji"

  FileUtils.rm_rf(directory_name)
  FileUtils.mkdir(directory_name)

  snippets.each do |snippet|
    snippet_content = snippet["alfredsnippet"]
    filename = "#{snippet_content["name"]} [#{snippet_content["uid"]}].json"

    File.open("#{directory_name}/#{filename}", "w") do |file|
      #puts "Writing snippet with filename #{filename} and content:"
      #puts "#{JSON.pretty_generate(snippet)}"
      file.write(JSON.pretty_generate(snippet))
    end
  end

  zip_directory(directory_name)
  FileUtils.rm_rf(directory_name)

  # Rename zip file
  FileUtils.mv(directory_name + ".zip", directory_name + ".alfredsnippets")
end

def parse_options
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: example.rb [options]"

    opts.on('-p', '--path PATH', 'Plist Path or URL') { |v| options[:plist_uri] = v }

  end.parse!
  options
end

def load_plist(plist_uri)
  data = ""
  open(plist_uri) { |io|
    data = io.read
  }
  plist = Plist::parse_xml(data)
end

options = parse_options
plist_uri = options[:plist_uri]
plist = load_plist(plist_uri)
snippets = create_snippets(plist)
write_snippets(snippets)

