angular.module('mc.core.ui.bs.infiniteList', ['mc.core.ui.infiniteList', 'ngSanitize', 'infinite-scroll']).run [ '$templateCache', ($templateCache) ->
    $templateCache.put 'modelcatalogue/core/ui/infinitePanels.html', '''
    <div>
      <div class="row" infinite-scroll="loadMore()" infinite-scroll-disabled="loading || !isVisible()" infinite-scroll-distance="2" infinite-scroll-immediate-check="isVisible()" infinite-scroll-listen-for-event="infiniteList:filtered">
        <div ng-repeat="item in elements" ng-init="element = getElement(item)" class="not-editable infinite-scroll-item col-lg-12 col-sm-12 col-md-12" >
          <div class="panel" ng-class="{'panel-warning': element.status == 'DRAFT', 'panel-info': element.status == 'PENDING', 'panel-default': element.status == 'FINALIZED' || !element.status, 'panel-danger': element.status == 'DEPRECATED'}">
            <div class="panel-heading">
              <h3 class="panel-title" title="{{element.name}}"><a class="full-width-link" ng-href="{{href(element)}}"><span ng-class="element.getIcon()" class="text-muted"></span> {{element.name}} <small>{{element.getDataModelWithVersion()}}</small><span class="small pull-right fa fa-fw fa-external-link"></span></a> </h3>
            </div>
            <div class="panel-body">
              <form editable-form ng-class="{ 'shorten-detail': !element.$$full, 'full-detail': element.$$full }">
                <div class="row detail-section" ng-repeat="view in getDetailSections(element)" ng-class="{'shorten-detail-section': view.position <= 0, 'full-detail-section': view.position > 0}">
                    <p ng-if="view.title" class="text-center detail-section-title small"><span class="title">{{view.title}}</span></p>
                    <ng-include src="view.template"></ng-include>
                </div>
                <div class="row detail-section show-more-detail-section">
                  <p ng-click="element.$$full = true" class="with-pointer text-center detail-section-title small"><span class="title">Show More</span></p>
                </div>
              </form>

            </div>
          </div>
          <div class="panel-actions" ng-if="!noActions">
            <contextual-actions size="sm" no-colors="true" icon-only="true" group="true" role="item-infinite-list"></contextual-actions>
          </div>
        </div>
        <div ng-if="elements.length < total" class="infinite-scroll-item" ng-class="columnClasses">
          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title"> Loading</h3>
            </div>
            <div class="panel-body">
                Loaded {{elements.length}} / {{total}} items
            </div>
          </div>
        </div>
      </div>
    </div>
    '''
  ]
