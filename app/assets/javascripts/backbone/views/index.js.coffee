class Todo.Views.Index extends Backbone.View
  el: "#todoapp"
  statsTemplate: JST["backbone/templates/stats"]
  
  events:
    "keypress #new-todo"  : "createOnEnter"
    "keyup #new-todo"     : "showTooltip"
    "click .todo-clear a" : "clearCompleted"
    
  initialize: ->
    _.bindAll this, "addOne", "addAll", "renderStats"
      
    @input = @$ "#new-todo"
    @collection.bind "add", @addOne
    @collection.bind "reset", @addAll
    @collection.bind "all", @renderStats
    @collection.fetch()
    
  renderStats: ->
    @$('#todo-stats').html @statsTemplate
      total:     @collection.length
      done:      @collection.done().length
      remaining: @collection.remaining().length
      
  addOne: (todo) ->
    view = new Todo.Views.Item model: todo
    @$("#todo-list").append view.render().el
    
  addAll: ->
    @collection.each @addOne
    
  newAttributes: ->
    content: @input.val()
    order:   @collection.nextOrder()
    done:    false
    
  createOnEnter: (e) ->
    if e.keyCode == 13
      @collection.create @newAttributes()
      @input.val ''
      
  clearCompleted: ->
    todo.destroy() for todo in @collection.done()
    false
      
  showTooltip: (e) ->
    tooltip = @$ ".ui-tooltip-top"
    val = @input.val()
    tooltip.fadeOut()
    clearTimeout @tooltipTimeout if @tooltipTimeout
    unless val == '' or val == @input.attr 'placeholder'
      @tooltipTimeout = _.delay ->
        tooltip.show().fadeIn()
      , 1000
  
