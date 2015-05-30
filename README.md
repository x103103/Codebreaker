# Codebreaker

Codebreaker is a logic game in which a code-breaker tries to break a secret code created by a code-maker. The code-maker creates a secret code of four numbers between 1 and 6.

The code-breaker then gets some number of chances to break the code. In each turn, the code-breaker makes a guess of four numbers. The code-maker then marks the guess with up to four + and - signs.

A + indicates an exact match: one of the numbers in the guess is the same as one of the numbers in the secret code and in the same position.

A - indicates a number match: one of the numbers in the guess is the same as one of the numbers in the secret code but in a different position.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'codebreaker', :git => "git://github.com/x103103/codebreaker"
```

## Usage

Console interface

```ruby
require 'codebreaker'

Codebreaker::Console.new
```

or clone repository and run 'rake console'