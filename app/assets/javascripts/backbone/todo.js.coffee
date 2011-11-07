#= require_self
#= require_tree ./helpers
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Todo =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  init: ->
    new Todo.Views.Index collection: new Todo.Collections.ItemsCollection()
