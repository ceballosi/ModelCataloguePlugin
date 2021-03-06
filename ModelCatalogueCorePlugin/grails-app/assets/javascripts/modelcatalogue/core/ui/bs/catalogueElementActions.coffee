angular.module('mc.core.ui.bs.catalogueElementActions', ['mc.util.ui.actions']).config ['actionsProvider', 'names', (actionsProvider, names)->

  showErrorsUsingMessages = (messages) ->
    (response) ->
      if response?.data and response.data.errors
        if angular.isString response.data.errors
          messages.error response.data.errors
        else
          for err in response.data.errors
            messages.error err.message


  getIsSourceFinalized = (relationship) ->
    unless relationship
      return false
    if relationship.direction == "sourceToDestination"
      return relationship.element.status is 'FINALIZED'
    return relationship.relation.status is 'FINALIZED'


  actionsProvider.registerActionInRoles 'catalogue-element',[actionsProvider.ROLE_ITEM_ACTION], ['$scope', 'security', 'names', 'catalogue', ($scope, security, name, catalogue)->
    return undefined if not security.hasRole('CURATOR')
    return undefined unless $scope.element
    if $scope.element
      return undefined if not angular.isFunction $scope.element.isInstanceOf

    {
      show:       true
      position:   0
      label:      names.getNaturalName(names.getPropertyNameFromQualifier($scope.element.elementType))
      icon:       catalogue.getIcon($scope.element.elementType)
      type:       'primary'
      watches:    ['element.elementType', 'element.status']
      expandToLeft: true
    }
  ]

  actionsProvider.registerActionInRoles 'edit-catalogue-element',[actionsProvider.ROLE_ITEM_DETAIL_ACTION], ['$scope', 'messages', 'names', 'security', ($scope, messages, names, security) ->
    return undefined if not $scope.element
    return undefined if not angular.isFunction $scope.element.isInstanceOf
    return undefined if not angular.isFunction $scope.element.getResourceName
    return undefined if not messages.hasPromptFactory('create-' + $scope.element.getResourceName()) and not messages.hasPromptFactory('edit-' + $scope.element.getResourceName())
    return undefined if not security.hasRole('CURATOR')
    return undefined if angular.isFunction($scope.supportsInlineEdit) and $scope.supportsInlineEdit($scope.editableForm)
    return undefined if $scope.element.isInstanceOf('dataModel') and $scope.element.status != 'DRAFT'

    {
      position:   -1000
      label:      'Edit'
      icon:       'fa fa-edit'
      type:       'primary'
      disabled:   $scope.element.archived or $scope.element?.status == 'FINALIZED'
      watches:    ['element.status', 'element.archived']
      action:     ->
        messages.prompt('Edit ' + $scope.element.getElementTypeName(), '', {type: 'edit-' + names.getPropertyNameFromType($scope.element.elementType), element: $scope.element}).then (updated)->
          $scope.element.updateFrom updated

    }

  ]

  actionsProvider.registerActionInRoles 'inline-edit',[actionsProvider.ROLE_ITEM_DETAIL_ACTION], ['$scope', 'messages', 'names', 'security', ($scope) ->
    return undefined if not $scope.editableForm
    return undefined if $scope.editableForm.$visible
    return undefined if angular.isFunction($scope.supportsInlineEdit) and not $scope.supportsInlineEdit($scope.editableForm)

    {
      position:   -1000
      label:      'Inline Edit'
      icon:       'fa fa-edit'
      type:       'primary'
      disabled:   $scope.element.archived or $scope.element?.status == 'FINALIZED'
      watches:    ['element.status', 'element.archived']
      action:     ->
        $scope.editableForm.$show()
        $scope.$broadcast 'redrawContextualActions'

    }

  ]

  actionsProvider.registerActionInRoles 'inline-edit-submit',[actionsProvider.ROLE_ITEM_DETAIL_ACTION], ['$scope', 'messages', 'names', 'security', ($scope) ->
    return undefined if not $scope.editableForm
    return undefined if not $scope.editableForm.$visible
    return undefined if angular.isFunction($scope.supportsInlineEdit) and not $scope.supportsInlineEdit($scope.editableForm)

    {
      position:   2000
      label:      'Save'
      icon:       'fa fa-check'
      type:       'success'
      submit:     true
      action:     ->
        $scope.$broadcast 'redrawContextualActions'

    }
  ]

  actionsProvider.registerActionInRoles 'inline-edit-cancel',[actionsProvider.ROLE_ITEM_DETAIL_ACTION], ['$scope', 'messages', 'names', 'security', ($scope) ->
    return undefined if not $scope.editableForm
    return undefined if not $scope.editableForm.$visible
    return undefined if angular.isFunction($scope.supportsInlineEdit) and not $scope.supportsInlineEdit($scope.editableForm)

    {
      position:   3000
      label:      'Cancel'
      icon:       'fa fa-ban'
      type:       'warning'
      action:     ->
        $scope.editableForm.$cancel()
        $scope.$broadcast 'redrawContextualActions'

    }
  ]

  actionsProvider.registerChildActionInRoles 'catalogue-element', 'create-new-relationship',[actionsProvider.ROLE_ITEM_ACTION], ['$scope', 'messages', 'names', 'security', ($scope, messages, names, security) ->
    return undefined if not $scope.element
    return undefined if not angular.isFunction($scope.element.isInstanceOf)
    return undefined if not $scope.element.isInstanceOf('catalogueElement')
    return undefined if not security.hasRole('CURATOR')

    {
      position:   200
      label:      'Create Relationship'
      icon:       'fa fa-fw fa-chain'
      icon:       'fa fa-fw fa-chain'
      type:       'success'
      watches:    ['element.status', 'element.archived']
      disabled:   $scope.element.archived
      action:     ->
        messages.prompt('Create Relationship', '', {type: 'create-new-relationship', element: $scope.element, currentDataModel: $scope.currentDataModel}).catch showErrorsUsingMessages(messages)
    }

  ]

  actionsProvider.registerChildActionInRoles 'catalogue-element', 'compare-catalogue-element',[actionsProvider.ROLE_ITEM_ACTION], ['$scope', 'messages', '$state', ($scope, messages, $state) ->
    elementPresent = $scope.element and angular.isFunction($scope.element.getResourceName) and angular.isFunction($scope.element.getElementTypeName) and angular.isFunction($scope.element.isInstanceOf) and $scope.element.isInstanceOf('catalogueElement')
    diffView = $state.current.name == 'mc.resource.diff'

    return undefined if not elementPresent and not diffView

    element = if elementPresent then $scope.element else $scope.elements[0]
    ids = if elementPresent then [element.id] else (e.id for e in $scope.elements)

    {
      position: -500
      label: if elementPresent then 'Compare' else 'Compare Another'
      icon: 'fa fa-fw fa-arrows-h'
      type: 'primary'
      action: ->
        messages.prompt('Compare ' + element.getElementTypeName(), "Select the #{element.getElementTypeName()} for the comparison",
          {type: 'catalogue-element', resource: element.getResourceName(), global: true}).then (toBeCompared)->
            $state.go 'mc.resource.diff', dataModelId: element.dataModel.id, resource: element.getResourceName(), ids: ids.concat([toBeCompared.id]).join('|')
    }
  ]


  actionsProvider.registerChildActionInRoles 'catalogue-element', 'create-new-mapping',[actionsProvider.ROLE_ITEM_ACTION], ['$scope', 'messages', 'names', 'security', ($scope, messages, names, security) ->
    return undefined if not $scope.element
    return undefined if not $scope.element.hasOwnProperty('mappings')
    return undefined if not security.hasRole('CURATOR')

    {
      position:   300
      label:      'Create Mapping'
      icon:       'fa fa-fw fa-superscript'
      type:       'success'
      action:     ->
        messages.prompt('Create new mapping for ' + $scope.element.name, '', {type: 'new-mapping', element: $scope.element}).catch showErrorsUsingMessages(messages)
    }
  ]


  actionsProvider.registerChildActionInRoles 'catalogue-element', 'validate-value',[actionsProvider.ROLE_ITEM_ACTION], [ '$scope', 'messages', 'security', ($scope, messages) ->
    return undefined if not $scope.element
    return undefined if not angular.isFunction $scope.element.isInstanceOf
    return undefined if not $scope.element.isInstanceOf('dataType')

    {
      position:   1200
      label:      'Validate Value'
      icon:       'fa fa-fw fa-check-circle-o'
      type:       'primary'
      watches:    ['element.rule', 'element.dataType']
      disabled:   not $scope.element.rule \
        and $scope.element.basedOn?.length == 0 \
        and not (($scope.element.dataType and $scope.element.dataType.isInstanceOf('enumeratedType')) or $scope.element.isInstanceOf('enumeratedType'))
    action:     ->
        messages.prompt('', '', {type: 'validate-value-by-domain', domain: $scope.element})
    }
  ]


  actionsProvider.registerChildActionInRoles 'catalogue-element', 'convert',[actionsProvider.ROLE_ITEM_ACTION], [ '$scope', 'messages', 'security', ($scope, messages) ->
    return undefined if not $scope.element
    return undefined if not angular.isFunction $scope.element.isInstanceOf
    return undefined if not $scope.element.isInstanceOf('dataType') and not $scope.element.isInstanceOf('mapping')

    {
      position:   1100
      label:      'Convert Value'
      icon:       'fa fa-fw fa-long-arrow-right'
      type:       'primary'
      action:     ->
        if $scope.element.isInstanceOf('dataType')
          messages.prompt('', '', {type: 'convert-with-value-domain', source: $scope.element})
        else if $scope.element.isInstanceOf('mapping')
          messages.prompt('', '', {type: 'convert-with-value-domain', source: $scope.element.source, destination: $scope.element.destination})

    }
  ]

  actionsProvider.registerChildActionInRoles 'catalogue-element', 'validate-xsd-schema',[actionsProvider.ROLE_ITEM_ACTION], [ '$scope', 'messages', 'catalogue', ($scope, messages, catalogue) ->
    return undefined if not catalogue.isInstanceOf($scope.element?.elementType, 'asset')

    {
      position:   1100
      label:      'Validate XML'
      icon:       'fa fa-fw fa-check-circle-o'
      type:       'default'
      action:     ->
        messages.prompt('', '', {type: 'validate-xml-by-schema', asset: $scope.element})

    }
  ]


  actionsProvider.registerActionInRoles 'download-asset',[actionsProvider.ROLE_ITEM_DETAIL_ACTION], [ '$scope', '$window', ($scope, $window) ->
    return undefined if not $scope.element?.downloadUrl?

    {
      position:   -50
      label:      ''
      icon:       'fa fa-fw fa-download'
      type:       'primary'
      action:     ->
        $window.open "#{$scope.element.downloadUrl}?force=true", '_blank'; return true

    }
  ]


  actionsProvider.registerActionInRoles 'remove-relationship',[actionsProvider.ROLE_ITEM_ACTION], ['$rootScope','$scope', '$state', 'messages', 'names', 'security', '$q', ($rootScope, $scope, $state, messages, names, security, $q) ->
    return undefined if not $scope.element
    return undefined if not angular.isFunction($scope.element.isInstanceOf)
    return undefined if not $scope.element.isInstanceOf('relationship')
    return undefined if not security.hasRole('CURATOR')


    {
      position:   150
      label:      ''
      icon:       'glyphicon glyphicon-remove'
      type:       'danger'
      watches:    [
        'element.inherited'
        'element.element.status'
        'element.relation.status'
        'element.type.versionSpecific'
      ]
      disabled:   $scope.element.inherited or ($scope.element.type.versionSpecific and getIsSourceFinalized($scope.element))
      action:     ->
        rel   = $scope.element
        deferred = $q.defer()
        messages.confirm('Remove Relationship', "Do you really want to remove relation '#{rel.element.name} #{rel.type[rel.direction]} #{rel.relation.name}'?").then () ->
          rel.remove().then ->
            messages.success('Relationship removed!', "#{rel.relation.name} is no longer related to #{rel.element.name}")
            # reloads the table
            deferred.resolve(true)
            $rootScope.$broadcast 'catalogueElementDeleted', rel
          , (response) ->
            if response.data?.errors
              if angular.isString response.data.errors
                messages.error response.data.errors
              else
                for err in response.data.errors
                  messages.error err.message
            else if response.status == 404
              messages.error('Error removing relationship', 'Relationship cannot be removed, it probably does not exist anymore. The table was refreshed to get the most up to date results.')
              deferred.resolve(true)
            else
              messages.error('Error removing relationship', 'Relationship cannot be removed, see application logs for details')

        deferred.promise
    }
  ]

  actionsProvider.registerChildActionInRoles 'catalogue-element',  'restore-relationship',[actionsProvider.ROLE_ITEM_ACTION], ['$rootScope','$scope', '$state', 'messages', 'names', 'security', '$q', 'rest', 'enhance', 'modelCatalogueApiRoot', ($rootScope, $scope, $state, messages, names, security, $q, rest, enhance, modelCatalogueApiRoot) ->
    return undefined if not $scope.element
    return undefined if not angular.isFunction($scope.element.isInstanceOf)
    return undefined if not $scope.element.isInstanceOf('relationship')
    return undefined if not security.hasRole('CURATOR')

    action =
      position:   1000
      label:      'Restore Archived'
      icon:       'glyphicon glyphicon-refresh'
      type:       'primary'
      watches:    'element.archived'
      disabled:   !$scope.element.archived
      action:     ->
        rel   = $scope.element
        messages.confirm('Restore Relationship', "Do you really want to restore relation '#{rel.element.name} #{rel.type[rel.direction]} #{rel.relation.name}'?").then () ->
          enhance(rest(method: 'POST', url: "#{modelCatalogueApiRoot}/relationship/#{rel.id}/restore")).then ->
            messages.success('Relationship restored!', "Relation '#{rel.element.name} #{rel.type[rel.direction]} #{rel.relation.name}' is no longer archived")
            rel.archived = false
          , (response) ->
            if response.data?.errors
              if angular.isString response.data.errors
                messages.error response.data.errors
              else
                for err in response.data.errors
                  messages.error err.message
            else if response.status == 404
              messages.error('Error restoring relationship', 'Relationship cannot be restored, it probably does not exist anymore. The table was refreshed to get the most up to date results.')
            else
              messages.error('Error restoring relationship', 'Relationship cannot be restored, see application logs for details')

    return action
  ]

  actionsProvider.registerActionInRoles 'edit-relationship', [actionsProvider.ROLE_ITEM_ACTION], ['$rootScope','$scope', '$state', 'messages', 'names', 'security', ($rootScope, $scope, $state, messages, names, security) ->
    getRelationship = ->
      $scope.element ? $scope.tab?.value
    return undefined if not getRelationship()
    return undefined if not angular.isFunction(getRelationship().isInstanceOf)
    return undefined if not getRelationship().isInstanceOf('relationship')
    return undefined if not security.hasRole('CURATOR')

    {
    position:   100
    label:      ''
    icon:       'glyphicon glyphicon-edit'
    type:       'primary'
    watches:    [
      'element.inherited'
      'element.element.status'
      'element.relation.status'
      'element.type.versionSpecific'
    ]
    disabled:   $scope.element.inherited or ($scope.element.type.versionSpecific and getIsSourceFinalized($scope.element))
    action:     ->
      rel   = getRelationship()
      rel.element.refresh().then (element) ->
        args = {relationshipType: rel.type, direction: rel.direction, type: 'update-relationship', currentDataModel: $scope.currentDataModel, update: true, element: element, relation: rel.relation, classification: rel.classification, metadata: angular.copy(rel.ext)}
        messages.prompt('Update Relationship', '', args).then (updated)->
          $rootScope.$broadcast 'catalogueElementUpdated', updated
          rel.ext = updated.ext
          rel.classification = updated.classification
    }
  ]

  actionsProvider.registerActionInRoles 'edit-mapping', [actionsProvider.ROLE_ITEM_ACTION], [ '$scope', 'messages', 'enhance', ($scope, messages, enhance) ->
    return undefined if not $scope.element
    return undefined if not angular.isFunction $scope.element.isInstanceOf
    return undefined if not $scope.element.isInstanceOf('mapping')

    catalogueElementEnhancer = enhance.getEnhancer('catalogueElement')

    {
      position:   100
      label:      ''
      icon:       'glyphicon glyphicon-edit'
      type:       'primary'
      watches:    'element.mappings.total'
      disabled:    $scope.element.isInstanceOf('dataType') and not $scope.element.mappings.total
      action:     ->
        $scope.element.source.refresh().then (element)->
          args = {type: 'new-mapping', update: true, element: element, mapping: $scope.element}
          messages.prompt('Update Mapping', '', args).then (updated)->
            catalogueElementEnhancer.updateFrom $scope.element, updated

    }

  ]

  actionsProvider.registerActionInRoles 'remove-mapping', [actionsProvider.ROLE_ITEM_ACTION], ['$rootScope','$scope', '$state', 'messages', 'names', 'security', '$q', ($rootScope, $scope, $state, messages, names, security, $q) ->
    return undefined if not $scope.element
    return undefined if not angular.isFunction($scope.element.isInstanceOf)
    return undefined if not $scope.element.isInstanceOf('mapping')
    return undefined if not security.hasRole('CURATOR')

    {
    position:   150
    label:      ''
    icon:       'glyphicon glyphicon-remove'
    type:       'danger'
    action:     ->
      mapping   = $scope.element
      deferred = $q.defer()
      messages.confirm('Remove Mapping', "Do you really want to remove mapping from #{mapping.source.name} to #{mapping.destination.name}?").then ->
        mapping.remove().then ->
          messages.success('Mapping removed!', "#{mapping.destination.name} is no longer related to #{mapping.source.name}")
          # reloads the table
          deferred.resolve(true)
        , (response) ->
          if response.data?.errors
            if angular.isString response.data.errors
              messages.error response.data.errors
            else
              for err in response.data.errors
                messages.error err.message
          else if response.status == 404
            messages.error('Error removing mapping', 'Mapping cannot be removed, it probably does not exist anymore. The table was refreshed to get the most up to date results.')
            deferred.resolve(true)
          else
            messages.error('Error removing mapping', 'Mapping cannot be removed, see application logs for details')

      deferred.promise
    }
  ]

  actionsProvider.registerActionInRoles 'change-type',[actionsProvider.ROLE_ITEM_DETAIL_ACTION], ['$rootScope','$scope', 'messages', 'names', 'security', 'catalogueElementResource', ($rootScope, $scope, messages, names, security, catalogueElementResource) ->
    return undefined if not $scope.element
    return undefined if not angular.isFunction $scope.element.isInstanceOf
    return undefined if not $scope.element.isInstanceOf('dataType')
    return undefined if not security.hasRole('CURATOR')

    {
      position:   10000
      label:      'Change Type'
      icon:       'fa fa-fw fa-random'
      type:       'primary'
      watches:    ['element.status', 'element.archived']
      disabled:   $scope.element.archived
      action:     ->
        options =
          dataType: 'Data Type'
          enumeratedType: 'Enumerated Type'
          primitiveType: 'Primitive Type'
          referenceType: 'Reference Type'

        messages.prompt('Change Type', "To which type should be #{$scope.element.name} converted? WARNING: any extra information such as enumerated values, data classes and measurement units will be lost!", {type: 'with-options', selected: names.getPropertyNameFromType($scope.element.elementType), options: options}).then (type)->
          catalogueElementResource($scope.element.elementType).update($scope.element, {newVersion: true, newType: type}).then (updated) ->
            $scope.element.updateFrom  updated
            messages.success("#{$scope.element.name} is now #{options[type]}")
            $rootScope.$broadcast 'newVersionCreated', updated
            $rootScope.$broadcast 'catalogueElementUpdated', updated
          , showErrorsUsingMessages(messages)
    }
  ]


  actionsProvider.registerChildActionInRole 'catalogue-element', 'clone', actionsProvider.ROLE_ITEM_ACTION, ['$rootScope','$scope', 'messages', 'names', 'security', 'catalogueElementResource', 'enhance', 'rest', 'modelCatalogueApiRoot', ($rootScope, $scope, messages, names, security, catalogueElementResource, enhance, rest, modelCatalogueApiRoot) ->
    return undefined if not security.hasRole('CURATOR')
    return undefined if not $scope.element
    return undefined if not angular.isFunction($scope.element.isInstanceOf)
    return undefined if not $scope.element.isInstanceOf('catalogueElement')

    {
      position:   20100
      label:      'Clone Current Element into Another Data Model'
      icon:       'fa fa-fw fa-clone'
      type:       'primary'
      action:     ->
        messages.prompt("Clone #{$scope.element.name}", "Please, select the destination data model for the cloned element.", type: 'catalogue-element', status: 'draft', resource: 'dataModel').then (destinationDataModel) ->
          enhance(rest(url: "#{modelCatalogueApiRoot}#{$scope.element.link}/clone/#{destinationDataModel.id}", method: 'POST')).then (finalized) ->
            finalized.show()
          , showErrorsUsingMessages(messages)
    }
  ]

  actionsProvider.registerChildActionInRole 'catalogue-element', 'clone-from', actionsProvider.ROLE_ITEM_ACTION, ['$rootScope','$scope', 'messages', 'names', 'security', 'catalogueElementResource', 'enhance', 'rest', 'modelCatalogueApiRoot', ($rootScope, $scope, messages, names, security, catalogueElementResource, enhance, rest, modelCatalogueApiRoot) ->
    return undefined if not security.hasRole('CURATOR')
    return undefined if not $scope.element
    return undefined if not angular.isFunction($scope.element.isInstanceOf)
    return undefined if not $scope.element.isInstanceOf('dataModel')
    return undefined if $scope.element.status != 'DRAFT'

    {
      position:   20000
      label:      'Clone Another Element into Current Data Model'
      icon:       'fa fa-fw fa-clone fa-flip-horizontal'
      type:       'primary'
      action:     ->
        messages.prompt("Clone into #{$scope.element.name}", "Please, select the element to be cloned", type: 'catalogue-element', status: 'finalized', resource: 'catalogueElement', global: true).then (elementToBeCloned) ->
          enhance(rest(url: "#{modelCatalogueApiRoot}#{elementToBeCloned.link}/clone/#{$scope.element.id}", method: 'POST')).then (finalized) ->
            finalized.show()
          , showErrorsUsingMessages(messages)
    }
  ]


  actionsProvider.registerChildActionInRole 'catalogue-element', 'delete', actionsProvider.ROLE_ITEM_ACTION, ['$rootScope','$scope', '$state', 'messages', 'names', 'security', ($rootScope, $scope, $state, messages, names, security) ->
    return undefined if not $scope.element
    return undefined if not angular.isFunction($scope.element.delete)
    return undefined unless security.hasRole('CURATOR')
    # currently constrained for assets and data models only
    return undefined unless $scope.element.isInstanceOf('asset') or $scope.element.isInstanceOf('dataModel')

    {
      position:   -1500
      label:      'Delete'
      icon:       'fa fa-fw fa-times-circle'
      type:       'danger'
      action:     ->
        messages.confirm("Do you really want to delete #{$scope.element.getElementTypeName()} #{$scope.element.name} ?", "The #{$scope.element.getElementTypeName()} #{$scope.element.name} will be deleted permanently. This action cannot be undone.").then ->
          $scope.element.delete()
          .then ->
            messages.success "#{$scope.element.getElementTypeName()} #{$scope.element.name} deleted."
            resource = names.getPropertyNameFromType($scope.element.elementType)
            if resource == 'dataModel'
              $state.go('dataModels')
            else if $state.current.name.indexOf('mc.resource.show') >= 0
              $state.go('mc.resource.list', {resource: resource}, {reload: true})
          .catch showErrorsUsingMessages(messages)
    }
  ]

  actionsProvider.registerChildActionInRole 'catalogue-element', 'finalize', actionsProvider.ROLE_ITEM_ACTION, ['$rootScope','$scope', 'messages', 'security', ($rootScope, $scope, messages, security) ->
    return undefined unless security.hasRole('CURATOR')
    return undefined unless $scope.element
    return undefined unless $scope.element.status
    return undefined unless $scope.element.status == 'DRAFT'
    return undefined unless angular.isFunction($scope.element.isInstanceOf)
    return undefined unless $scope.element.isInstanceOf('dataModel')

    {
      position:   -2000
      label:      'Finalize'
      icon:       'fa fa-fw fa-check-circle'
      type:       'primary'
      disabled:   $scope.element?.status != 'DRAFT'
      watches:    ['element.status', 'element.archived']
      action:     ->
        messages.prompt(null, null, type: 'finalize', element: $scope.element)
    }
  ]

  newVersionAction = ['$rootScope','$scope', 'messages', 'security', ($rootScope, $scope, messages, security) ->
    return undefined if not $scope.element
    return undefined if not $scope.element.status
    return undefined if not security.hasRole('CURATOR')
    return undefined if $scope.element.status == 'DRAFT'
    return undefined if $scope.element.status == 'PENDING'
    return undefined if angular.isFunction($scope.element.isInstanceOf()) and $scope.element.isInstanceOf('asset')

    {
      position:   -1900
      label:      'New Version'
      icon:       'fa fa-fw fa-arrow-circle-up'
      type:       'primary'
      watches:    ['element.status', 'element.archived']
      disabled:   $scope.element.archived || $scope.element.status == 'DRAFT' || $scope.element.status == 'PENDING'
      action:     ->
        messages.prompt(null, null, type: 'new-version', element: $scope.element)
    }
  ]


  actionsProvider.registerChildActionInRole 'catalogue-element', 'create-new-version', actionsProvider.ROLE_ITEM_ACTION, newVersionAction
  actionsProvider.registerActionInRoles 'create-new-version-tiny', [actionsProvider.ROLE_ITEM_DETAIL_ACTION, actionsProvider.ROLE_ITEM_INIFINITE_LIST], newVersionAction


  newAssetVersion = ['$rootScope','$scope', 'messages', 'security', ($rootScope, $scope, messages, security) ->
    return undefined if not $scope.element
    return undefined if not security.hasRole('CURATOR')
    return undefined if not angular.isFunction($scope.element.isInstanceOf)
    return undefined if not $scope.element.isInstanceOf('asset')

    {
      position:   -1900
      label:      'Upload New Version'
      icon:       'fa fa-fw fa-arrow-circle-up'
      type:       'primary'
      watches:    ['element.status', 'element.archived']
      disabled:   $scope.element.archived
      action:     ->
        messages.prompt('Upload New Version', null, type: 'edit-asset', element: $scope.element, currentDataModel: $scope.element.dataModel).then (newOne) ->
          newOne.show()
    }
  ]


  actionsProvider.registerChildActionInRole 'catalogue-element', 'upload-new-asset-version', actionsProvider.ROLE_ITEM_ACTION, newAssetVersion
  actionsProvider.registerActionInRoles 'upload-new-asset-version-tiny', [actionsProvider.ROLE_ITEM_DETAIL_ACTION, actionsProvider.ROLE_ITEM_INIFINITE_LIST], newAssetVersion



  actionsProvider.registerChildActionInRole 'catalogue-element', 'archive', actionsProvider.ROLE_ITEM_ACTION, ['$rootScope','$scope', 'messages', 'names', 'security', 'enhance', 'rest', 'modelCatalogueApiRoot', ($rootScope, $scope, messages, names, security, enhance, rest, modelCatalogueApiRoot) ->
    return undefined if not $scope.element
    return undefined if not $scope.element.status
    return undefined if not security.hasRole('CURATOR')
    return undefined if $scope.element.archived and not security.hasRole('ADMIN')

    action = {
      position:   -1800
      watches:    ['element.status', 'element.archived']
      action:     ->
        if $scope.element.archived
          if security.hasRole('ADMIN')
            messages.confirm("Do you want to restore #{$scope.element.getElementTypeName()} #{$scope.element.name} as finalized?", "The #{$scope.element.getElementTypeName()} #{$scope.element.name} will no longer be deprecated").then ->
              enhance(rest(url: "#{modelCatalogueApiRoot}#{$scope.element.link}/restore", method: 'POST')).then (restored) ->
                $scope.element.updateFrom restored
                $rootScope.$broadcast 'catalogueElementUpdated', restored
                $rootScope.$broadcast 'redrawContextualActions'
                restored.focus()
              , showErrorsUsingMessages(messages)
        else
          messages.confirm("Do you want to mark #{$scope.element.getElementTypeName()} #{$scope.element.name} as deprecated?", "The #{$scope.element.getElementTypeName()} #{$scope.element.name} will be marked as deprecated").then ->
            enhance(rest(url: "#{modelCatalogueApiRoot}#{$scope.element.link}/archive", method: 'POST')).then (archived) ->
              $scope.element.updateFrom archived
              $rootScope.$broadcast 'catalogueElementUpdated', archived
              $rootScope.$broadcast 'redrawContextualActions'
              archived.focus()
            , showErrorsUsingMessages(messages)
    }

    if $scope.element.archived
      if not security.hasRole('ADMIN')
        action.disabled = true
      else
        action.label = 'Restore'
        action.icon = 'fa fa-fw fa-repeat'
        action.type = 'primary'
    else
      action.label = 'Deprecate'
      action.icon = 'fa fa-fw fa-ban'
      action.type = 'danger'

    action
  ]

  actionsProvider.registerChildActionInRole 'catalogue-element', 'merge', actionsProvider.ROLE_ITEM_ACTION, ['$rootScope','$scope', 'messages', 'names', 'security', 'enhance', 'rest', 'modelCatalogueApiRoot', ($rootScope, $scope, messages, names, security, enhance, rest, modelCatalogueApiRoot) ->
    return undefined if not $scope.element
    return undefined if not $scope.element.status
    return undefined if not security.hasRole('CURATOR')

    {
      position:   10000
      label:      'Merge'
      icon:       'fa fa-fw fa-code-fork fa-rotate-180 fa-flip-vertical'
      type:       'danger'
      watches:    ['element.status', 'element.archived']
      disabled:   $scope.element.status != 'DRAFT'
      action:     ->
        messages.prompt("Merge #{$scope.element.getElementTypeName()} #{$scope.element.name} to another #{$scope.element.getElementTypeName()}", "All non-system relationships of the #{$scope.element.getElementTypeName()} #{$scope.element.name} will be moved to the following destination and than the #{$scope.element.getElementTypeName()} #{$scope.element.name} will be archived", {type: 'catalogue-element', resource: $scope.element.elementType, status: 'draft'}).then (destination)->
          enhance(rest(url: "#{modelCatalogueApiRoot}#{$scope.element.link}/merge/#{destination.id}", method: 'POST')).then (merged) ->
            oldName = $scope.element.classifiedName
            messages.success "Element #{oldName} merged successfully into  #{$scope.element.classifiedName}"
            merged.show()
            $rootScope.$broadcast 'redrawContextualActions'
          , showErrorsUsingMessages(messages)
    }
  ]

]
