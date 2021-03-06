App.SkillsEditController = Em.ArrayController.extend
  actions:
    ok: ->
      @transitionToRoute('index')

    removeSkill: (skill)->
      store = skill.get('store')
      skill.deleteRecord()
      skill.save()

    createSkill: ->
      name = @get('newName')
      if (!name.trim())
        return
      skill = @store.createRecord 'skill',
        name: name
      @set('newName', '')
      skill.save()
