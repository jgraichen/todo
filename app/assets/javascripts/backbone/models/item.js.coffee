class Todo.Models.Item extends Backbone.Model
  EMPTY: "empty todo..."
  
  initialize: ->
    unless @get "content"
      @set content: @EMPTY
  
  toggle: ->
    @save done: not @get "done"
  
class Todo.Collections.ItemsCollection extends Backbone.Collection
  model: Todo.Models.Item
  url: '/items'
  
  done: ->
    @filter (todo) -> todo.get 'done'
    
  remaining: ->
    @without this.done()...
    
  nextOrder: ->
    if @length then @last().get('order') + 1 else 1
      
  comperator: (todo) ->
    todo.get 'order'
