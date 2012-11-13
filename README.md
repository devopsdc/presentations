## DevOpsDC Presentations

This project contains DevOpsDC Presentations built using with [showoff](https://github.com/schacon/showoff)

The `.rvmrc` file with the project assumes you have `ree` installed with rvm.  Previous experience shows that ruby 1.9.x doesn't work with showoff presentations that include images.

## Initial Setup
* `gem install bundler`
* `bundle install`

## Creating a new presentation

The master branch contains the base template.  Branch this for your presentation and add your slides to the presentation directory.  Be sure to update `showoff.json` with the appropriate meta-data for your presentation, too.

## Running the presentation

* `bundle exec showoff serve presentation`
* open [http://localhost:9090](http://localhost:9090)

## Editing the presentation

Please see the [showoff](https://github.com/schacon/showoff) site for details about editing a showoff presentation.  Feel free to update this code, submit pull requests, create branches, etc.
