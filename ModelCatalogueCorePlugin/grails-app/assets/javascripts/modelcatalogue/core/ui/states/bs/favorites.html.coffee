angular.module('mc.core.ui.states.bs.favorites.html', []).run(['$templateCache', ($templateCache) ->

  #language=HTML
  $templateCache.put 'modelcatalogue/core/ui/state/favorites.html', '''
    <div class="row">
      <div class="col-md-12">
        <h3><small class="fa fa-fw fa-star text-muted"></small>Favourites</h3>
        <infinite-table list="list" columns="columns" transform="$element.relation"></infinite-table>
      </div>
    </div>
  '''
])