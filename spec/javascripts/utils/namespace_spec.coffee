describe 'namespace', ->
  beforeEach ->
    namespace('Application.Vertigo.Rtm')

  it 'defines a property in the window', ->
    expect(Application).toBeDefined()

  it 'creates nested properties', ->
    application =
      Vertigo:
        Rtm: {}

    expect(Application).toEqual(application)

  it 'expanding existing properties', ->
    application =
      Vertigo:
        Rtm: {}
        init:
          defaults: {}
          options: {}

    Application.Vertigo.init = defaults: {}
    namespace('Application.Vertigo.init.options')

    expect(Application).toEqual(application)
