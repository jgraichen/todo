class Todo.Views.Item extends Backbone.View
  tagName: 'li'
  template: Todo.template '#item-template'
  
  events:
    "click .check"              : "toggleDone"
    "dblclick div.todo-content" : "edit"
    "click span.todo-destroy"   : "destroy"
    "keypress .todo-input"      : "updateOnEnter"
    
  initialize: ->
    _.bindAll this, 'render', 'close', 'destroy'
    @model.bind 'change', @render
    @model.bind 'destroy', => @remove()
    
  render: ->
    $(@el).html @template @model.toJSON()
    @setContent()
    this
      
  setContent: ->
    content = @model.get 'content'
    @$('.todo-content').text content
    @input = @$('.todo-input')
    @input.blur @close
    @input.val content
    
  toggleDone: ->
    @model.toggle()
    
  edit: ->
    $(@el).addClass "editing"
    @input.focus()
    
  close: ->
    @model.save content: @input.val()
    $(@el).removeClass "editing"
      
  updateOnEnter: (e) ->
    @close() if e.keyCode == 13
    
  destroy: ->
    @model.destroy()
