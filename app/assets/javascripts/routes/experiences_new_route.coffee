App.NewExperienceRoute = Ember.Route.extend
  model: ->
# Because we are maintaining a transaction locally in the controller for editing,
# the new record needs to be created in the controller.
    null

  setupController: (controller)->
    console.log "setup new exp contro"
    controller.startEditing()

  deactivate: ()->
    @controllerFor('new_experience').stopEditing()
