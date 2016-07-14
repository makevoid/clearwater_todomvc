# Clearwater TODOMVC

TODO MVC, tried to remove the mvc logic and just keep the boilerplate in

need something that lists, filters, creates and edits entries


## Running the application

To run the application you need ruby and bundler installed. Any ruby version above 1.9.3 will do.
"gem install bundler"  will install bundler if it is not installed yet.

- Clone the repository
- cd into the directory

`bundle`
`bundle exec rackup`

- go to [localhost:9292](http://localhost:9292)


## Auto reload in development

```sh    
gem i rerun

rerun -s KILL -p \"**/*.{rb}\" -- bundle exec rackup -p 3000
```

Otherwise you'll need to disable `COMPILE_ASSETS` in the main ruby/roda app file.

Enjoy!
