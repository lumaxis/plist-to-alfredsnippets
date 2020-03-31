**_This has been replaced by [Macmoji's Alfred support](https://github.com/warpling/Macmoji#alfred-version)_**

***

_In case you're lazy, simply download a pre-built version from [here](https://github.com/lumaxis/plist-to-alfredsnippets/blob/master/samples/slack_emoji.alfredsnippets?raw=true)._


I recently stumbled upon [Macmoji](https://github.com/warpling/Macmoji) which provides a `.plist` file that you can use to import text replacement snippets into macOS's settings that give you Slack-style emoji usage across your Mac.
Since I'm not a big fan of the default text replacement system and use Alfred's Snippets and [Text Expansion](https://www.alfredapp.com/help/features/snippets/) feature instead.

This Ruby script allows to convert a plist like the one provided on [Macmoji](https://github.com/warpling/Macmoji) to be converted to a `.alfredsnippets` file which can then be imported into Alfred 🚀

![Finished result in Alfred](https://github.com/lumaxis/plist-to-alfredsnippets/blob/master/images/alfred-screenshot.png?raw=true)

## Usage

To always use the latest and greatest `.plist` from  simply run this command:

```ruby
ruby plist-to-alfredsnippets.rb -p https://raw.githubusercontent.com/warpling/Macmoji/master/emoji%20substitutions.plist
```

Alternatively, you can use the `-p` option to specify any location for the `.plist` you want:

```ruby
ruby plist-to-alfredsnippets.rb -u samples/emoji\ substitutions.plist
```


This script currently does no error handling at all and only handles only my specific use case well. Feel free to improve it, PRs welcome!
