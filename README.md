# Marvel-Comics-API

A Ruby wrapper to communicate with the Marvel Comics API.

## Installation

	$ git clone https://github.com/rah00l/marvel-comics-api

Set rvm environment by creating gemset and setting it for this application.

And then execute:

    $ bundle

## Contents

* [Usage](#usage)
* [Responses](#responses)

## Usage

Register first in the [Marvel Comics Developer
Portal](http://developer.marvel.com/) to get your API credentials (a public key
and a private key, you'll need them both to configure and instantiate a client).

### Instantiate a client

```
irb -I lib
require 'marvel_comics_api'
client = MarvelComicsApi::API::Client.new( :public_key => 'abcd1234', :private_key => '5678efgh')

# fetch a list of characters
client.characters

# fetch a single character
client.character(1009610)
```

See the list of [available
methods](https://github.com/rah00l/marvel-comics-api/wiki/Documentation) in the
wiki.


## Responses

Most requests to the API, return a `MarvelComicsApi::API::Response` object if
successful or a `MarvelComicsApi::API::ErrorResponse` if API response returns an
error.
