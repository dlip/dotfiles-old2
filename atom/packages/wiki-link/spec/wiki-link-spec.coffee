WikiLink = require '../lib/wiki-link'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "WikiLink", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('wiki-link')

  describe "when the wiki-link:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.wiki-link')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'wiki-link:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.wiki-link')).toExist()

        wikiLinkElement = workspaceElement.querySelector('.wiki-link')
        expect(wikiLinkElement).toExist()

        wikiLinkPanel = atom.workspace.panelForItem(wikiLinkElement)
        expect(wikiLinkPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'wiki-link:toggle'
        expect(wikiLinkPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.wiki-link')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'wiki-link:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        wikiLinkElement = workspaceElement.querySelector('.wiki-link')
        expect(wikiLinkElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'wiki-link:toggle'
        expect(wikiLinkElement).not.toBeVisible()
